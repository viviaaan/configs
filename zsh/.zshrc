# .zshrc

# Colours and prompt
autoload -U colors && colors
PROMPT="%B%F{"#f7f7f7"}>%f%{$reset_color%} "
RPROMPT="%B%F{"#f7f7f7"}%~%f"
# PS1="%B%{$fg[grey]%}%~%{$fg[yellow]%} >%{$reset_color%} "
# PS1="%B%{$fg[black]%}[%{$fg[grey]%}%~%{$fg[black]%}]%{$fg[black]%} $%{$reset_color%} "


# History
HISTFILE="$HOME/.local/share/zsh/history"
setopt share_history hist_no_store hist_reduce_blanks hist_fcntl_lock
HISTSIZE=1000
SAVEHIST=1000

# Options
setopt auto_cd auto_pushd extended_glob interactive_comments path_dirs prompt_sp list_types aliases
unsetopt beep nomatch notify
stty stop undef
zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"

autoload -Uz compinit
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}

typeset -g -A key
key[Shift-Tab]="${terminfo[kcbt]}"
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[4 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    echo -ne "\e[4 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use block shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use block shape cursor for each new prompt.

# zle -N zle-keymap-select
# zle-line-init() {
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

bindkey '^[[P' delete-char

# # save path on cd
# function cd {
#     builtin cd "$@"
#     pwd > "$HOME/dat/.last_dir"
# }

# # restore last saved path
# if [ -f "$HOME/dat/.last_dir" ]
#     then cd `cat "$HOME/dat/.last_dir"`
# fi
function new-term {
    setsid -f st > /dev/null 2>&1
}
zle -N new-term
bindkey '^n' new-term

# Aliases
[ -f "$XDG_CONFIG_HOME/shell_cm/aliases" ] && source "$XDG_CONFIG_HOME/shell_cm/aliases"
# [ -f "$HOME/bin/adb_completion" ] && source "$HOME/bin/adb_completion"

# Syntax highlighing
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
