# =============================================================================
# File        : config.nu
# Author      : yukimemi
# Last Change : 2025/09/28 23:21:34.
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

# functions
def lsg [] { ls | sort-by type name -i | grid -c | str trim }
def --env rhl [] {
  rhq list | fzf | cd $in
}
def doc [] {
  config nu --doc | nu-highlight | less -R
}
alias cd-builtin = cd
def --env cd [target: path = "~"] {
  cd-builtin $target
  ls
}
def --env jd [] {
  cd (ls -a **/* | where type == dir | each { |row| $row.name } | str join (char nl) | fzf | decode utf-8 | str trim)
}
def r [] {
  rm (ls -a | each { |row| $row.name } | str join (char nl) | fzf | decode utf-8 | str trim)
}
def set-wt-title [title: string] {
  print $"\u{1b}]0;($title)\u{07}"
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
alias o = start
## git
alias g = git
alias d = git diff
alias dc = git diff --cached
alias a = git add
alias s = git status
alias gpu = git push
alias gp = git pull
alias gr = cd (git rev-parse --show-toplevel)

# mise
use $mise_path

# starship
$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}
def create_right_prompt [] {
  if ($nu.os-info.family == "windows") {
    set-wt-title "yukimemi-nu"
  }
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { || create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = "I "
$env.PROMPT_INDICATOR_VI_NORMAL = "N "
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# zoxide
source $zoxide_path
alias j = zi

# television
if (which tv | is-empty) {
  # cargo binstall television
  mise use -g github:alexpasmantier/television
}

# fzf
if (which fzf | is-empty) {
  cargo binstall fzf
}

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

# nupm
use $'($nupm_path)/nupm'
