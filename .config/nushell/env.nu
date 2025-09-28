# =============================================================================
# File        : env.nu
# Author      : yukimemi
# Last Change : 2025/09/28 22:40:11.
# =============================================================================

# cargo-binstall
if (which cargo-binstall | is-empty) {
  cargo install cargo-binstall
}

# mise
if (which mise | is-empty) {
  cargo binstall mise
}
const mise_path = $nu.default-config-dir | path join mise.nu
^mise activate nu | save -f $mise_path

# starship
if (which starship | is-empty) {
  cargo binstall starship
}

# zoxide
if (which zoxide | is-empty) {
  cargo binstall zoxide
}
const zoxide_path = $nu.default-config-dir | path join zoxide.nu
^zoxide init nushell | save -f $zoxide_path

# nupm
const nupm_path = $nu.default-config-dir | path join nupm
if not ($nupm_path | path exists) {
  git clone https://github.com/nushell/nupm $nupm_path
}

