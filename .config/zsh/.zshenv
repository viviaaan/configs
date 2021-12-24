# general
export PATH="$HOME/bin:$HOME/.local/bin:/usr/bin/core_perl:$PATH"
export EDITOR="nvim"
export BROWSER="brave"
export OPENER="less"
# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
# ADB
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export ANDROID_VENDOR_KEY="$XDG_CONFIG_HOME/android"
export ANDROID_AVD_HOME="$XDG_DATA_HOME/android/"
export ANDROID_PREFS_ROOT="$XDG_CONFIG_HOME/android"
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME/android/emulator"
# email
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export MBSYNCRC="$XDG_CONFIG_HOME/isync/mbsyncrc"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/notmuchrc"
export NMBGIT="$XDG_DATA_HOME/notmuch/nmbug"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"

# export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export LANG=en_US.UTF-8 #locale
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export LESS="-iR"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export HISTFILE="$XDG_DATA_HOME/bash/history"
export LESSHISTFILE="-"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export PYTHONHISTFILE="$XDG_DATA_HOME/python/history"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GROFF_TYPESETTER="pdf" #groff default formatting device
export GTK_THEME="Adwaita:dark"
export QT_QPA_PLATFORMTHEME="qt5ct"
export KDEHOME="$XDG_CONFIG_HOME/kde"
export SSB_HOME="$XDG_DATA_HOME/zoom"

# colourful man pages
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"

# start dwm if automatically on tty1 (if it is not running)
if [ "$(tty)" = "/dev/tty1" ]; then
    pgrep -x dwm || exec startx "$XDG_CONFIG_HOME"/X11/xinitrc > /dev/null 2>&1
fi
