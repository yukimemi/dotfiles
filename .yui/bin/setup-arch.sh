#!/usr/bin/env bash
set -euo pipefail

fail() { printf 'setup-arch: %s\n' "$*" >&2; exit 1; }

as_root() {
    if (( EUID == 0 )); then "$@"; else sudo -- "$@"; fi
}

consent() {
    local answer
    printf 'setup-arch: %s\nType yes to continue; anything else aborts: ' "$1" >&2
    if ! read -r answer </dev/tty || [[ $answer != yes ]]; then
        fail 'Replacement or initialization declined; existing files are unchanged.'
    fi
}

# Like consent, but declining is not fatal: returns non-zero so the caller can skip.
confirm() {
    local answer
    printf 'setup-arch: %s\nType yes to continue; anything else skips this step: ' "$1" >&2
    [[ -r /dev/tty ]] && read -r answer </dev/tty && [[ $answer == yes ]]
}

classify_service_units() {
    local unit state activity rest
    while read -r unit state activity rest; do
        case "$state:$activity" in
            enabled:*|enabled-runtime:*|*:active|*:activating) ;;
            *) continue ;;
        esac
        case "$unit" in
            gdm.service|sddm.service|lightdm.service|lxdm.service|slim.service|ly.service|xdm.service|cosmic-greeter.service)
                greetd_selected=false
                printf 'setup-arch: preserving existing display manager %s.\n' "$unit"
                ;;
            systemd-networkd.service|connman.service|dhcpcd*.service|netctl*.service|iwd.service)
                networkmanager_selected=false
                printf 'setup-arch: preserving existing network manager/component %s.\n' "$unit"
                ;;
        esac
    done <<< "$1"
}

inspect_service_managers() {
    local root=${1:-/} units package alias target
    greetd_selected=true
    networkmanager_selected=true
    if [[ $root == / ]]; then
        case "$(uname -r)" in
            *[Mm]icrosoft*|*[Ww][Ss][Ll]*)
                greetd_selected=false
                networkmanager_selected=false
                printf 'setup-arch: preserving WSL-managed login and networking.\n'
                return
                ;;
        esac
    fi
    # A filtered query returns 1 for an empty enabled set. Query all states so
    # an ordinary fresh system is not confused with an inspection failure.
    units=$(as_root systemctl --root="$root" list-unit-files --no-legend --no-pager --plain) \
        || fail 'Cannot inspect service unit files.'
    classify_service_units "$units"
    if [[ $root == / && -d /run/systemd/system ]] \
        && ! as_root systemd-detect-virt --chroot --quiet; then
        units=$(as_root systemctl list-units --type=service --state=active,activating --no-legend --no-pager --plain) \
            || fail 'Cannot inspect running services.'
        classify_service_units "$units"
    fi
    for package in gdm sddm lightdm lxdm slim ly xorg-xdm cosmic-greeter; do
        if pacman --root="$root" -Q "$package" >/dev/null 2>&1; then
            greetd_selected=false
            printf 'setup-arch: preserving installed display manager %s.\n' "$package"
        fi
    done
    alias="${root%/}/etc/systemd/system/display-manager.service"
    if as_root test -e "$alias" || as_root test -L "$alias"; then
        target=$(as_root readlink -f -- "$alias") || target=''
        if [[ $target != */greetd.service ]]; then
            greetd_selected=false
            printf 'setup-arch: preserving the existing display-manager.service selection.\n'
        fi
    fi
}

write_greetd_config() {
    cat > "$1" <<'TOML'
[terminal]
vt = 1

[default_session]
command = "/usr/bin/tuigreet --time --cmd /usr/bin/niri-session"
user = "greeter"
TOML
}

configure_greetd() {
    local root=$1 candidate=$2
    inspect_service_managers "$root"
    if ! "$greetd_selected"; then return; fi
    as_root bash -s -- "$root" "$candidate" <<'ROOT'
set -euo pipefail
root=$1
candidate=$2
directory="${root%/}/etc/greetd"
config="$directory/config.toml"
alias="${root%/}/etc/systemd/system/display-manager.service"
ask() {
    local answer
    printf 'setup-arch: %s\nType yes to continue; anything else aborts: ' "$1" >&2
    if ! read -r answer </dev/tty || [[ $answer != yes ]]; then
        printf 'setup-arch: initialization declined; existing files are unchanged.\n' >&2
        exit 1
    fi
}
if [[ -e $alias || -L $alias ]]; then
    target=$(readlink -f -- "$alias") || target=''
    if [[ $target != */greetd.service ]]; then
        printf 'setup-arch: another display manager is selected; greetd is unchanged.\n'
        exit 0
    fi
fi
if [[ -e $directory || -L $directory ]]; then
    [[ -d $directory && ! -L $directory && $(stat -c %u -- "$directory") == 0 ]] \
        || { printf 'setup-arch: refusing unsafe greetd directory.\n' >&2; exit 1; }
fi
changed=true
if [[ -e $config || -L $config ]]; then
    [[ -f $config && ! -L $config && $(stat -c %u -- "$config") == 0 ]] \
        || { printf 'setup-arch: refusing unsafe greetd config.\n' >&2; exit 1; }
    if cmp -s "$candidate" "$config"; then
        changed=false
    else
        ask "Existing $config differs; replace it with a backed-up copy?"
    fi
fi
default_target=$(systemctl --root="$root" get-default) \
    || { printf 'setup-arch: cannot inspect the default boot target.\n' >&2; exit 1; }
if [[ $default_target != graphical.target ]]; then
    ask "Change the default boot target from $default_target to graphical.target?"
fi
if "$changed"; then
    if [[ -e $config ]]; then
        backup=$(mktemp "$config.backup.XXXXXXXX")
        cp -p -- "$config" "$backup"
        printf 'setup-arch: preserved backup %s.\n' "$backup"
    fi
    install -d -m 755 -- "$directory"
    temporary=$(mktemp "$directory/.config.XXXXXXXX")
    trap 'rm -f -- "$temporary"' EXIT
    install -m 644 -o 0 -g 0 -- "$candidate" "$temporary"
    mv -f -- "$temporary" "$config"
fi
if ! systemctl --root="$root" is-enabled greetd.service >/dev/null 2>&1; then
    systemctl --root="$root" enable greetd.service
fi
if [[ $default_target != graphical.target ]]; then
    systemctl --root="$root" set-default graphical.target
fi
printf 'setup-arch: greetd is configured/enabled for the next boot; not restarted.\n'
ROOT
}

enable_networkmanager() {
    local root=${1:-/}
    inspect_service_managers "$root"
    if ! "$networkmanager_selected"; then return; fi
    if ! as_root systemctl --root="$root" is-enabled NetworkManager.service >/dev/null 2>&1; then
        as_root systemctl --root="$root" enable NetworkManager.service
    fi
    printf 'setup-arch: NetworkManager is enabled for the next boot; not restarted.\n'
}

enable_tailscale() {
    local root=${1:-/}
    if [[ $root == / ]]; then
        case "$(uname -r)" in
            *[Mm]icrosoft*|*[Ww][Ss][Ll]*)
                printf 'setup-arch: preserving WSL-managed networking; tailscaled is not enabled.\n'
                return
                ;;
        esac
    fi
    if ! as_root systemctl --root="$root" is-enabled tailscaled.service >/dev/null 2>&1; then
        as_root systemctl --root="$root" enable tailscaled.service
    fi
    if [[ $root == / ]] && systemctl is-active --quiet tailscaled.service; then
        # Lets the tray (tailscale systray) and CLI manage Tailscale without sudo.
        as_root tailscale set --operator="$USER"
        printf 'setup-arch: tailscale operator set to %s.\n' "$USER"
    else
        printf 'setup-arch: tailscaled is enabled for the next boot; not started. Then run: sudo tailscale up --operator=$USER\n'
    fi
}

# Installs CANDIDATE at TARGET when TARGET is absent. Returns 0 only when it
# installed; an existing file is never replaced, and a differing one is reported.
ensure_root_file() {
    local candidate=$1 target=$2
    if [[ -e $target || -L $target ]]; then
        if ! cmp -s -- "$candidate" "$target"; then
            printf 'setup-arch: %s differs from the managed content; leaving it unchanged.\n' "$target" >&2
        fi
        return 1
    fi
    as_root install -D -m 644 -o 0 -g 0 -- "$candidate" "$target"
}

# `id -nG USER` reads the group database, so it sees membership before re-login.
user_in_input_group() {
    [[ " $(id -nG "$USER" 2>/dev/null) " == *" input "* ]]
}

# Key remappers (kagi) read /dev/input/event* and write /dev/uinput. uinput is a
# module and its device node is root-only until udev applies the rule, so the
# module must be loaded at boot (modules-load.d), not left to autoload.
configure_kagi_input_access() {
    local stage=$1 etc=${2:-/etc} changed=false
    if [[ $etc == /etc ]]; then
        case "$(uname -r)" in
            *[Mm]icrosoft*|*[Ww][Ss][Ll]*)
                printf 'setup-arch: WSL has no input devices; skipping uinput access.\n'
                return
                ;;
        esac
    fi
    printf '%s\n' 'KERNEL=="uinput", GROUP="input", MODE="0660"' > "$stage/99-kagi-uinput.rules"
    printf 'uinput\n' > "$stage/uinput.conf"
    if ensure_root_file "$stage/99-kagi-uinput.rules" "$etc/udev/rules.d/99-kagi-uinput.rules"; then
        changed=true
    fi
    if ensure_root_file "$stage/uinput.conf" "$etc/modules-load.d/uinput.conf"; then
        changed=true
    fi
    if "$changed" && [[ $etc == /etc ]]; then
        as_root udevadm control --reload
        if as_root modprobe uinput; then
            as_root udevadm trigger --action=add --subsystem-match=misc --sysname-match=uinput
            printf 'setup-arch: uinput is loaded now and at every boot, group-writable by input.\n'
        else
            printf 'setup-arch: cannot load uinput now (reboot into the updated kernel); it loads at boot.\n' >&2
        fi
    fi
    if user_in_input_group; then return; fi
    if confirm "Add $USER to the input group? Any process of this account can then read raw keyboard events (needed by key remappers such as kagi)."; then
        as_root usermod -aG input "$USER"
        printf 'setup-arch: %s added to input; log out and back in for it to apply.\n' "$USER"
    else
        printf 'setup-arch: skipped. Later run: sudo usermod -aG input %s\n' "$USER"
    fi
}

init_fcitx_profile() (
    (( EUID != 0 )) || fail 'Fcitx profiles must be initialized as the normal user.'
    local directory="${XDG_CONFIG_HOME:-$HOME/.config}/fcitx5" profile temporary
    profile="$directory/profile"
    if [[ -e $profile || -L $profile ]]; then
        [[ -f $profile ]] || fail 'Existing Fcitx profile is not a usable regular file.'
        printf 'setup-arch: preserving existing Fcitx profile.\n'
        return
    fi
    mkdir -p -m 700 -- "$directory"
    temporary=$(mktemp "$directory/.profile.XXXXXXXX")
    trap 'rm -f -- "$temporary"' EXIT
    cat > "$temporary" <<'INI'
[Groups/0]
Name=Default
Default Layout=jp
DefaultIM=mozc

[Groups/0/Items/0]
Name=keyboard-jp
Layout=

[Groups/0/Items/1]
Name=mozc
Layout=

[GroupOrder]
0=Default
INI
    chmod 600 "$temporary"
    # Publish atomically without replacing a profile created by Fcitx meanwhile.
    if ln -T -- "$temporary" "$profile" 2>/dev/null; then
        printf 'setup-arch: initialized Japanese keyboard + Mozc profile.\n'
    elif [[ -f $profile ]]; then
        printf 'setup-arch: preserving the concurrently created Fcitx profile.\n'
    else
        fail 'Cannot publish the new Fcitx profile.'
    fi
)

ensure_omp_path() {
    local profile line backup candidate shell=${SHELL:-/bin/bash}
    line='export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"'
    case "${shell##*/}" in
        bash)
            profile="$HOME/.bash_profile"
            for candidate in "$HOME/.bash_profile" "$HOME/.bash_login" "$HOME/.profile"; do
                if [[ -e $candidate || -L $candidate ]]; then
                    profile=$candidate
                    break
                fi
            done
            ;;
        zsh) profile="$HOME/.zprofile" ;;
        *)
            printf 'setup-arch: add ~/.local/bin and ~/.bun/bin to your shell PATH.\n'
            return
            ;;
    esac
    if [[ -e $profile || -L $profile ]]; then
        [[ -f $profile && $(stat -Lc %u -- "$profile") == "$EUID" ]] \
            || fail "Refusing an unsafe shell profile: $profile"
        if grep -Fxq -- "$line" "$profile"; then return; fi
        consent "Add the OMP PATH line to $profile without changing its existing settings?"
        backup=$(mktemp "$profile.backup.XXXXXXXX")
        cp -pL -- "$profile" "$backup"
        printf 'setup-arch: preserved backup %s.\n' "$backup"
        # Append through a legitimate yui symlink instead of replacing the link.
        printf '\n%s\n' "$line" >> "$profile"
    else
        (
            umask 077
            set -o noclobber
            {
                if [[ ${shell##*/} == bash ]]; then
                    printf '[[ -f ~/.bashrc ]] && . ~/.bashrc\n'
                fi
                printf '%s\n' "$line"
            } > "$profile"
        )
    fi
}

install_omp() {
    local stage=$1
    (( EUID != 0 )) || fail 'OMP must be installed as the normal user.'
    export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
    if command -v omp >/dev/null 2>&1; then
        printf 'setup-arch: preserving existing OMP installation.\n'
    else
        curl -fsSL https://omp.sh/install -o "$stage/omp-install.sh"
        sh "$stage/omp-install.sh"
    fi
    omp --version
    ensure_omp_path
}

main() (
    # yui exposes linux/macos/windows; distinguish Arch before doing any work.
    if [[ ! -r /etc/os-release ]]; then
        printf 'setup-arch: not Arch Linux; skipping.\n'
        exit 0
    fi
    . /etc/os-release
    if [[ ${ID:-} != arch ]]; then
        printf 'setup-arch: not Arch Linux; skipping.\n'
        exit 0
    fi
    if [[ -e /etc/archiso || -e /etc/initcpio/hooks/archiso ]]; then
        fail 'Boot the installed system, not the live ISO.'
    fi
    if (( EUID == 0 )); then
        fail 'Run yui as your normal user; AUR builds must not run as root.'
    fi
    command -v sudo >/dev/null 2>&1 || fail 'An existing sudo-capable normal user is required.'
    local stage
    stage=$(mktemp -d)
    trap 'rm -rf -- "$stage"' EXIT
    inspect_service_managers /

    if ! command -v yay >/dev/null 2>&1; then
        as_root pacman -Syu --needed base-devel git
        git clone https://aur.archlinux.org/yay-bin.git "$stage/yay-bin"
        printf '\nReview the yay-bin PKGBUILD before building:\n'
        cat "$stage/yay-bin/PKGBUILD"
        consent 'Build and install this AUR helper?'
        (cd -- "$stage/yay-bin" && makepkg -si)
    fi
    local repo_packages=(
        base-devel git github-cli sudo curl diffutils less
        niri noctalia upower alacritty
        xdg-utils wl-clipboard xdg-desktop-portal-gnome xdg-desktop-portal-gtk xwayland-satellite
        noto-fonts noto-fonts-cjk ttf-dejavu tailscale
        fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-gtk fcitx5-qt
    )
    if "$greetd_selected"; then repo_packages+=(greetd greetd-tuigreet); fi
    if "$networkmanager_selected"; then repo_packages+=(networkmanager); fi
    printf 'setup-arch: updating Arch and installing desktop packages; review yay prompts.\n'
    yay -Syu --needed "${repo_packages[@]}" brave-bin ttf-plemoljp-bin
    install_omp "$stage"
    init_fcitx_profile
    mkdir -p -m 700 -- "$HOME/Pictures" "$HOME/Pictures/Screenshots"

    # Re-check after package changes; do not replace a concurrently selected manager.
    inspect_service_managers /
    if "$greetd_selected"; then
        getent passwd greeter >/dev/null || fail 'greetd did not provide its greeter account.'
        command -v tuigreet >/dev/null && command -v niri-session >/dev/null \
            || fail 'The greetd session commands are unavailable.'
        write_greetd_config "$stage/greetd.toml"
        configure_greetd / "$stage/greetd.toml"
    fi
    if "$networkmanager_selected"; then enable_networkmanager /; fi
    enable_tailscale /
    configure_kagi_input_access "$stage"
    printf 'setup-arch: initialization complete. No explicit service start/restart or reboot was requested; package hooks are separate.\n'
    printf 'setup-arch: yui-managed settings and existing IME profiles were preserved; log in afresh for new session settings.\n'
)

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
    main "$@"
fi
