# =============================================================================
# File        : config.nu
# Author      : yukimemi
# Last Change : 2025/07/19 22:18:48.
# =============================================================================

# config
$env.config.buffer_editor = 'nvim'
$env.config.show_banner = true
$env.config.rm.always_trash = true
$env.config.edit_mode = 'vi'
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

# environment
$env.CARGO_HOME = "~/.cargo"

# path
use std/util "path add"
path add "~/.local/bin"
path add ($env.CARGO_HOME | path join "bin")
path add ($env.LOCALAPPDATA | path join "Programs" "ExifTool")

# mise
const mise_init_path = ($nu.temp-path | path join "mise.nu")
if not ($mise_init_path | path exists) {
    mise activate nu | save -f $mise_init_path
}
source $mise_init_path

# functions
def lsg [] { ls | sort-by type name -i | grid -c | str trim }
def --env rhl [] {
  rhq list | tv | cd $in
}
def doc [] {
  config nu --doc | nu-highlight | less -R
}
alias cd-builtin = cd
def --env cd [target: path = "~"] {
  cd-builtin $target
  ls
}

# aliases
alias l = ls
alias la = ls -a
alias ll = ls -l
alias lla = ls -la
alias c = clear
alias b = cd ..
alias t = exit
alias e = nvim
## git
alias g = git
alias d = git diff
alias dc = git diff --cached
alias a = git add
alias s = git status
alias gpu = git push
alias gp = git pull

# starship
const starship_init_path = ($nu.temp-path | path join "starship.nu")
if not ($starship_init_path | path exists) {
    starship init nu | save -f $starship_init_path
}
source $starship_init_path

def create_left_prompt [] {
  starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = "I "
$env.PROMPT_INDICATOR_VI_NORMAL = "N "
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# zoxide
const zoxide_init_path = ($nu.temp-path | path join "zoxide.nu")
if not ($zoxide_init_path | path exists) {
    zoxide init nushell | save -f $zoxide_init_path
}
source $zoxide_init_path
alias j = zi

# nu_scripts (https://github.com/nushell/nu_scripts)
const nus_path = $nu.home-path | path join "src" "github.com" "nushell" "nu_scripts"
if not ($nus_path | path exists) {
  rhq clone https://github.com/nushell/nu_scripts
}
use ($nus_path | path join "aliases" "git" "git-aliases.nu") *

# keybindings
$env.config.keybindings = [
  {
    name: "Delete to line start"
    modifier: control
    keycode: char_u
    mode: vi_insert
    event: { edit: CutFromLineStart }
  }
]
