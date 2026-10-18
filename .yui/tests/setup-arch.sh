#!/usr/bin/env bash
# Local state/policy tests only: no package installation, sudo, or service starts.
set -euo pipefail
(( EUID != 0 )) || { printf 'Run these tests as a normal user.\n' >&2; exit 1; }
script=$(readlink -f -- "$(dirname -- "${BASH_SOURCE[0]}")/../bin/setup-arch.sh")
source "$script"
work=$(mktemp -d)
trap 'rm -rf -- "$work"' EXIT
export HOME="$work/home" XDG_CONFIG_HOME="$work/home/.config"
mkdir -p "$HOME" "$work/source-config"
ln -s "$work/source-config" "$XDG_CONFIG_HOME"
profile="$XDG_CONFIG_HOME/fcitx5/profile"

init_fcitx_profile >/dev/null
grep -Fxq 'DefaultIM=mozc' "$profile"
grep -Fxq 'Default Layout=jp' "$profile"
grep -Fxq 'Name=keyboard-jp' "$profile"
grep -Fxq 'Name=mozc' "$profile"
[[ $(stat -c %a "$profile") == 600 ]]
[[ $(stat -c %u "$profile") == "$EUID" ]]
[[ $(stat -c %h "$profile") == 1 ]]
[[ -L $XDG_CONFIG_HOME && $(readlink "$XDG_CONFIG_HOME") == "$work/source-config" ]]
before=$(stat -c '%i:%a:%Y:%Z' "$profile")
init_fcitx_profile >/dev/null
[[ $(stat -c '%i:%a:%Y:%Z' "$profile") == "$before" ]]
printf 'PASS: new Japanese/Mozc profile is private, yui link survives, and rerun does not rewrite it.\n'

printf '[Groups/0]\nDefaultIM=keyboard-us\n' > "$profile"
chmod 400 "$profile"
before=$(sha256sum "$profile"; stat -c '%i:%a:%Y:%Z' "$profile")
init_fcitx_profile >/dev/null
[[ $(sha256sum "$profile"; stat -c '%i:%a:%Y:%Z' "$profile") == "$before" ]]
printf 'PASS: custom existing profile content, permissions and identity are preserved.\n'

rm "$profile"
printf '[Groups/0]\nDefaultIM=custom-input-method\n' > "$work/custom-profile"
ln -s "$work/custom-profile" "$profile"
init_fcitx_profile >/dev/null
[[ -L $profile && $(readlink "$profile") == "$work/custom-profile" ]]
grep -Fxq 'DefaultIM=custom-input-method' "$work/custom-profile"
printf 'PASS: an existing per-file profile symlink is not replaced.\n'

rm "$profile"
mkdir "$profile"
if init_fcitx_profile >/dev/null 2>&1; then
    printf 'FAIL: profile directory was accepted as a profile.\n' >&2
    exit 1
fi
[[ -d $profile ]]
rmdir "$profile"
printf 'PASS: invalid existing profile directories are rejected without publishing inside them.\n'

init_fcitx_profile >/dev/null &
a=$!
init_fcitx_profile >/dev/null &
b=$!
wait "$a"
wait "$b"
grep -Fxq 'DefaultIM=mozc' "$profile"
[[ $(stat -c %a "$profile") == 600 && $(stat -c %h "$profile") == 1 ]]
if compgen -G "$XDG_CONFIG_HOME/fcitx5/.profile.*" >/dev/null; then
    printf 'FAIL: profile initialization left a temporary file.\n' >&2
    exit 1
fi
printf 'PASS: concurrent initialization leaves one complete profile and no temporary files.\n'

greetd_selected=true
networkmanager_selected=true
classify_service_units $'greetd.service enabled\nNetworkManager.service enabled\nNetworkManager-dispatcher.service enabled\nwpa_supplicant.service loaded active running' >/dev/null
"$greetd_selected" && "$networkmanager_selected"
printf 'PASS: the existing selected managers and NetworkManager backend are not treated as conflicts.\n'

greetd_selected=true
networkmanager_selected=true
classify_service_units $'systemd-networkd.service disabled enabled\nsddm.service disabled enabled' >/dev/null
"$greetd_selected" && "$networkmanager_selected"
printf 'PASS: vendor presets do not turn disabled services into selected managers.\n'

classify_service_units 'connman.service loaded active running' >/dev/null
! "$networkmanager_selected"
"$greetd_selected"
printf 'PASS: an active alternative network manager prevents NetworkManager selection.\n'

greetd_selected=true
networkmanager_selected=true
classify_service_units 'dhcpcd@eth0.service masked active running' >/dev/null
! "$networkmanager_selected"
printf 'PASS: an alternative manager still running after masking remains protected.\n'

greetd_selected=true
networkmanager_selected=true
classify_service_units 'netctl@wireless.service enabled' >/dev/null
! "$networkmanager_selected"
printf 'PASS: enabled per-interface/profile network services are preserved.\n'

greetd_selected=true
networkmanager_selected=true
classify_service_units 'sddm.service enabled' >/dev/null
! "$greetd_selected"
"$networkmanager_selected"
printf 'PASS: another display manager prevents greetd selection without changing networking selection.\n'

export HOME="$work/login-home" SHELL=/bin/bash
mkdir -p "$HOME"
printf 'export ORIGINAL_SETTING=kept\n' > "$HOME/.profile"
before=$(sha256sum "$HOME/.profile")
if setsid --wait bash -c 'source "$1"; ensure_omp_path' bash "$script" >/dev/null 2>&1; then
    printf 'FAIL: an existing login profile was changed without approval.\n' >&2
    exit 1
fi
[[ $(sha256sum "$HOME/.profile") == "$before" ]]
[[ ! -e $HOME/.bash_profile && ! -e $HOME/.bash_login ]]
printf 'PASS: PATH initialization respects Bash login precedence and refuses unapproved existing-profile edits.\n'

# Root-file/group policy: as_root, the group lookup and the prompt are stubbed,
# so nothing here touches the system.
etc="$work/etc"
stage="$work/stage"
mkdir -p "$stage"
asroot_log="$work/asroot.log"
: > "$asroot_log"
as_root() {
    if [[ $1 == install ]]; then
        shift
        local args=()
        while (( $# )); do
            case $1 in -o|-g) shift 2 ;; *) args+=("$1"); shift ;; esac
        done
        install "${args[@]}"
    else
        printf '%s\n' "$*" >> "$asroot_log"
    fi
}
rule=$etc/udev/rules.d/99-kagi-uinput.rules
modules=$etc/modules-load.d/uinput.conf
user_in_input_group() { return 1; }
confirm() { return 0; }

configure_kagi_input_access "$stage" "$etc" >/dev/null
[[ $(<"$rule") == 'KERNEL=="uinput", GROUP="input", MODE="0660"' ]]
[[ $(<"$modules") == uinput ]]
grep -Fxq "usermod -aG input $USER" "$asroot_log"
! grep -q -E 'udevadm|modprobe' "$asroot_log"
printf 'PASS: uinput rule, boot-time module load and input group are set up; live udev/modprobe only touch the real /etc.\n'

: > "$asroot_log"
before=$(stat -c '%i:%Y' "$rule" "$modules")
user_in_input_group() { return 0; }
configure_kagi_input_access "$stage" "$etc" >/dev/null
[[ $(stat -c '%i:%Y' "$rule" "$modules") == "$before" ]]
[[ ! -s $asroot_log ]]
printf 'PASS: rerun with everything in place is a no-op and does not call sudo.\n'

printf '# hand-edited\n' > "$rule"
configure_kagi_input_access "$stage" "$etc" >/dev/null 2>&1
[[ $(<"$rule") == '# hand-edited' ]]
printf 'PASS: an existing, different rule file is preserved.\n'

: > "$asroot_log"
user_in_input_group() { return 1; }
confirm() { return 1; }
configure_kagi_input_access "$stage" "$etc" >/dev/null
[[ ! -s $asroot_log ]]
printf 'PASS: declining the prompt skips the input group change without failing.\n'
