#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi
set -o noclobber

shopt -s globstar
shopt -s extglob
shopt -s autocd
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkjobs
shopt -s checkwinsize
shopt -s dirspell
shopt -s dotglob
shopt -s nullglob

# shellcheck disable=SC2034
mkprompt() {
    local EXIT_CODE=$?

    local COLOR_WHITE='\[\033[1;37m\]'
    local COLOR_LIGHTGRAY='\[\033[0;37m\]'
    local COLOR_GRAY='\[\033[1;30m\]'
    local COLOR_BLACK='\[\033[0;30m\]'
    local COLOR_RED='\[\033[0;31m\]'
    local COLOR_LIGHTRED='\[\033[1;31m\]'
    local COLOR_GREEN='\[\033[0;32m\]'
    local COLOR_LIGHTGREEN='\[\033[1;32m\]'
    local COLOR_BROWN='\[\033[0;33m\]' # Orange
    local COLOR_YELLOW='\[\033[1;33m\]'
    local COLOR_BLUE='\[\033[0;34m\]'
    local COLOR_LIGHTBLUE='\[\033[1;34m\]'
    local COLOR_PURPLE='\[\033[0;35m\]'
    local COLOR_PINK='\[\033[1;35m\]' # Light Purple
    local COLOR_CYAN='\[\033[0;36m\]'
    local COLOR_LIGHTCYAN='\[\033[1;36m\]'
    local COLOR_DEFAULT='\[\033[0m\]'

    # Display n of jobs currently running at the end of line
    PS1="$(printf '%s%*s%s\r' "${COLOR_BROWN}" "${COLUMNS}" "[jobs: \j]" "${COLOR_DEFAULT}")"
    # Display git information if in repository
    if git status --short >/dev/null 2>&1; then
        PS1="${PS1}$(printf 'on %s%s%s' "${COLOR_CYAN}" "$(git branch --show-current||:)" "${COLOR_DEFAULT}")"
    fi

    PS1="${PS1}\n ${COLOR_PINK}\u@\H${COLOR_DEFAULT} ${COLOR_LIGHTBLUE}\w${COLOR_DEFAULT}"
    if [[ ${EXIT_CODE} -ne 0 ]]; then
        PS1="${PS1} ${COLOR_LIGHTRED}[${EXIT_CODE}]${COLOR_DEFAULT}"
    else
        PS1="${PS1} ${COLOR_BROWN}[${EXIT_CODE}]${COLOR_DEFAULT}"
    fi
    PS1="${PS1} ${COLOR_PURPLE}~>${COLOR_DEFAULT} "
}
PROMPT_COMMAND='mkprompt'

[[ -n "${PS1}" && -f /usr/share/bash-completion/bash_completion ]] &&
    source /usr/share/bash-completion/bash_completion

# Functions
man() {
    if [[ -z ${PAGER+x} ]]; then
        local PAGER
        if command -v less >/dev/null 2>&1; then
            PAGER="less"
        else
            PAGER="more"
        fi
    fi

    # shellcheck disable=SC2312
    command man "$@"  ||
    command help "$1" ||
    command info "$1" ||
    ("$@" --help 2>&1 ||
     "$@" -h 2>&1 || command man --apropos "$@" 2>&1 | "${PAGER}")
}

extract() {
    [[ ! -f "$1" ]] && {
        printf '"%s" is not a file' "$1"
        return 1
    }
    case "$1" in
        *.tar.bz2) tar xjf      "$1"                                        ;;
        *.tar.gz)  tar xzf      "$1"                                        ;;
        *.tar.xz)  tar xJf      "$1"                                        ;;
        *.bz2)     bunzip2      "$1"                                        ;;
        *.rar)     unrar-free x "$1"                                        ;;
        *.gz)      gunzip       "$1"                                        ;;
        *.tar)     tar xf       "$1"                                        ;;
        *.tbz2)    tar xjf      "$1"                                        ;;
        *.tgz)     tar xzf      "$1"                                        ;;
        *.zip)     unzip        "$1"                                        ;;
        *.Z)       uncompress   "$1"                                        ;;
        *.7z)      7z x         "$1"                                        ;;
        *)         printf       '"%s" cannot be extracted via extract' "$1" ;;
    esac
}

# If on archlinux, use fzf to install/remove packages
if grep --quiet --fixed-strings 'DISTRIB_ID="Arch"' /etc/lsb-release &&
command -v fzf >/dev/null 2>&1; then
    install-packages() {
        # shellcheck disable=SC2312
        pacman --sync --list --quiet |
            fzf --query="$1" --multi --preview 'pacman -Si {1}' |
            xargs --no-run-if-empty --open-tty doas pacman --sync
    }
    install-aur() {
        # shellcheck disable=SC2312
        yay --sync --list --quiet |
            fzf --query="$1" --multi --preview 'yay -Si {1}' |
            xargs --no-run-if-empty --open-tty yay --sync
    }
    remove-packages() {
        # shellcheck disable=SC2312
        yay --query --explicit --quiet |
            fzf --query="$1" --multi --preview 'yay -Qi {1}' |
            xargs --no-run-if-empty --open-tty yay -Rns
    }
fi

# shellcheck disable=SC2154
if [[ -e "${XDG_CONFIG_HOME}/X11/xinitrc" ]]; then
    alias startx='startx ${XDG_CONFIG_HOME}/X11/xinitrc'
else
    printf "%s\n" "No xinitrc found in ${XDG_CONFIG_HOME}/X11/" >&2
fi

alias q="exit"
alias ls="ls --color=auto"
alias l="ls -lAh --color=auto"
alias grep="grep --color"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -rIv"
alias free="free --mebi --human"
alias diff="diff --color -u"
alias cal="cal --monday"
alias c="clear"
alias lear=":"
alias ear=":"
alias mkvenv="python3 -m venv ./venv && source ./venv/bin/activate"
alias cg='cd "$(git rev-parse --show-toplevel)"'

if command -v nvim >/dev/null 2>&1; then
    alias vim="nvim"
    alias vi="nvim"
    alias v="nvim"
else
    alias vi="vim"
    alias v="vim"
fi

if command -v ranger >/dev/null 2>&1; then
    alias r="ranger"
fi

if command -v kubectl >/dev/null 2>&1; then
    # shellcheck disable=SC1090
    source <(kubectl completion bash||:)
fi

if { command -v hexdump && ! command -v xxd; } >/dev/null 2>&1; then
    alias xxd="hexdump"
fi

if [[ -d "${HOME}/.dotfiles" && -f "${HOME}/.dotfiles/HEAD" ]]; then
    alias dotf='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
fi
