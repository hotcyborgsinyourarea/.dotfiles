#
# ~/.bash_profile
#

# Set environment variables in login shell
export LC_ALL="en_US.UTF-8"
export PATH="${HOME}/.local/bin${PATH:+":${PATH}"}"

# XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="${HOME}/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="${HOME}/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="${HOME}/.config"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="${HOME}/.local/state"}

# Bash
[[ ${SHELL##*/} == "bash" ]] && export HISTFILE="${XDG_STATE_HOME}/bash/history"

# Ruby
export GEM_PATH="${XDG_DATA_HOME}/ruby/gems"
export GEM_SPEC_CACHE="${XDG_DATA_HOME}/ruby/specs"
export GEM_HOME="${XDG_DATA_HOME}/ruby/gems"

# Npm
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# Rust
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

# Go
export GOPATH="${XDG_DATA_HOME}/go"
export GOBIN="${GOPATH}/bin"

# Python
export PYTHONSTARTUP="${HOME}/.config/python/pythonrc.py"

# Utilities
export GNUPG="${XDG_DATA_HOME}/gnupg"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
export TERMINAL="kitty"
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export MEDIA_PLAYER="mpv"
export READER="mupdf"
export BROWSER="firefox"

# Make FCITX work properly in some applications
export QT_IM_MODULE=fcitx5
export GTK_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

# Pager and man pages
export LESS="-RX"
export LESSHISTFILE=-
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'


[[ $- != *i* ]] && command -v neofetch >/dev/null 2>&1 && neofetch
[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"
