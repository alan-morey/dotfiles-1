# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt HIST_IGNORE_SPACE

# This needs to be run earlier than compinit
bindkey -v

# ====================
# Config
# ====================
export HOME=##NEWHOME##
export EDITOR=##NEWEDITOR##
export CC=gcc
export CXX=g++
export DEFAULT_USER=##NEWUSER##

# Set Locale. LOL
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>$HOME/tmp/startlog.$$
    setopt xtrace prompt_subst
fi

# System Specifics: OS X
if [[ "Darwin" == "`uname`" ]]; then
    bindkey "^[[7~" beginning-of-line
    bindkey "^[[8~" end-of-line

    # Browser
    export BROWSER="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

    # LOL! Free C-s
    stty -ixon -ixoff

    # Terminal Colors
    export FLAGS_GETOPT_CMD="$(brew --prefix gnu-getopt)/bin/getopt"
    export GREP_OPTIONS='--color=always'
    export GREP_COLOR='1;35;40'
    source "`brew --prefix`/etc/grc.bashrc"

# System Specifics: Linux
elif [[ "Linux" == "`uname`" ]]; then
    alias startx='startx -- -dpi 144'
    alias pbpaste='xclip -o'
    alias pbcopy='xclip -i'

    # Browser
    export BROWSER="/usr/bin/google-chrome-stable"

    # LOL! Free C-s
    stty -ixon -ixoff

    if [[ "$TERM" == "rxvt-unicode" ]]; then
        export TERM="xterm-256color"
    fi

# System Specifics: cygwin
elif [[ "Cygwin" == "`uname -o`" ]]; then
    export TERM="xterm-256color"

    pbcopy() { read data; echo "$data" > /dev/clipboard }
    pbpaste() { cat /dev/clipboard }
fi


# ====================
# External
# ====================
if [ -f "$HOME/.p4creds" ]; then
    source "$HOME/.p4creds"
fi


# ====================
# ZSH
# ====================
zstyle :compinstall filename $HOME'/.zshrc'
zmodload zsh/complist
zmodload zsh/mathfunc
autoload -Uz compinit && compinit
autoload -U zmv
autoload -U zcalc

zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs ..
zstyle ':completion:*' use-ip true
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' rehash true

# ls(1) like colors
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34:st=37;44:ex=01;32'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

fpath=(/usr/local/share/zsh-completions $fpath)

# zmv is awesome
alias mmv='noglob zmv -W'


# ====================
# OH-MY-ZSH
# ====================
ZSH=$HOME/.oh-my-zsh
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS=false
export UPDATE_ZSH_DAYS=7

# powerlevel9k theme
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode status)
POWERLEVEL9K_TIME_BACKGROUND="blue" # cyan / 013 are also good looking
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

plugins=(git git-flow git-extras repo wd brew osx colored-man cp colorize history)


# ====================
# External Scripts
# ====================
source $ZSH/oh-my-zsh.sh
# if command -v fasd > /dev/null 2>&1; then
#     eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-wcomp)"
# fi

# Glob all other scripts
for file in $HOME/.zsh/scripts/* ; do
  if [ -f "$file" ] ; then
    source "$file"
  fi
done

# init fasd and cache the result
# if command -v fasd > /dev/null 2>&1; then
#     fasd_cache="$HOME/.fasd-init-zsh"
#     if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
#       fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
#     fi
#     source "$fasd_cache"
#     unset fasd_cache
# fi


# ====================
# Programs
# ====================
export LESS="-R"
export LESSOPEN="|~/.lessfilter %s"

# ====================
# General Config
# ====================
# Make use of the dirstack
_mydirstack() {
  local -a lines list
  for d in $dirstack; do
    lines+="$(($#lines+1)) -- $d"
    list+="$#lines"
  done
  _wanted -V directory-stack expl 'directory stack' \
    compadd "$@" -ld lines -S']/' -Q -a list
}
zsh_directory_name() {
  case $1 in
    c) _mydirstack;;
    n) case $2 in
         <0-9>) reply=($dirstack[$2]);;
         *) reply=($dirstack[(r)*$2*]);;
       esac;;
    d) false;;
  esac
}

# Also, persist dirstack through restarts
DIRSTACKSIZE=9
DIRSTACKFILE=~/.zdirs
touch $DIRSTACKFILE
if [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd_dirstack() {
  local -a dirs; dirs=( "$PWD" ${(f)"$(< $DIRSTACKFILE)"} )
  print -l ${${(u)dirs}[0,$DIRSTACKSIZE]} >$DIRSTACKFILE
}

mutt() {
    local cwd=$(pwd)
    cd ~/
    command mutt $@
    cd $cwd
}

# tmux current working dir
PS1="$PS1"'$([ -n "$TMUX"  ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# ====================
# Vi Mode
# ====================

# Enable Vi mode
bindkey -v

# Just if dots appear again
# bindkey "^I" expand-or-complete

# Normal bindings
bindkey -M vicmd "s" forward-char
bindkey -M vicmd "b" backward-char
bindkey -M vicmd "n" down-line-or-beginning-search
bindkey -M vicmd "r" up-line-or-beginning-search
bindkey -M vicmd "B" backward-word
bindkey -M vicmd "S" forward-word
bindkey -M vicmd "$" end-of-line
bindkey -M vicmd "0" beginning-of-line
bindkey -M vicmd "u" undo
bindkey -M vicmd "j" redo
bindkey -M vicmd "gg" beginning-of-buffer-or-history
bindkey -M vicmd "G" end-of-buffer-or-history
bindkey -M vicmd "v" visual-mode
bindkey -M vicmd "f" edit-command-line
bindkey -M vicmd "?" vi-repeat-search
bindkey -M vicmd ":" vi-rev-repeat-search # was execute-named-cmd
#bindkey -M vicmd "y" yank
#bindkey -M vicmd " " magic-space

# Bind Up and Down keys again
bindkey -M vicmd "OA" up-line-or-beginning-search
bindkey -M vicmd "OB" down-line-or-beginning-search
bindkey -M viins "OA" up-line-or-beginning-search
bindkey -M viins "OB" down-line-or-beginning-search

# Move physical line up and down
_physical_up_line()   { zle backward-char -n $COLUMNS }
_physical_down_line() { zle forward-char  -n $COLUMNS }
zle -N physical-up-line _physical_up_line
zle -N physical-down-line _physical_down_line
bindkey -M vicmd "R" physical-up-line
bindkey -M vicmd "N" physical-down-line

# Insert mode bindings
bindkey -M viins "" backward-delete-char

# Copy & Paste
x-copy() {
    zle copy-region-as-kill
    print -rn -- $CUTBUFFER | pbcopy
    zle visual-mode
}
zle -N x-copy

x-cut() {
    zle kill-region
    print -rn -- $CUTBUFFER | pbcopy
}
zle -N x-cut

x-paste() {
    PASTE=$(pbpaste)
    LBUFFER="$LBUFFER${RBUFFER:0:1}"
    RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
}
zle -N x-paste

bindkey -M vicmd "y" x-copy
bindkey -M vicmd "Y" x-cut
bindkey -M vicmd "p" x-paste

autoload -Uz narrow-to-region
function _history-incremental-preserving-pattern-search-backward {
    local state
    MARK=CURSOR  # magick, else multiple ^R don't work
    narrow-to-region -p "$LBUFFER${BUFFER:+>>}" -P "${BUFFER:+<<}$RBUFFER" -S state
    zle end-of-history
    zle history-incremental-pattern-search-backward
    narrow-to-region -R state
}
zle -N _history-incremental-preserving-pattern-search-backward
bindkey -M viins "" _history-incremental-preserving-pattern-search-backward
bindkey -M vicmd "" _history-incremental-preserving-pattern-search-backward
bindkey -M isearch "" history-incremental-pattern-search-backward

export KEYTIMEOUT=1


# ====================
# Aliases
# ====================
alias l=' ls -lah'
alias g=git
alias ti='tig status'
alias tigs='tig status'
alias copy='noeol | pbcopy'
alias fuck='sudo $(history -p \!\!)'
alias lsfiles='for f in *; do [[ -f "$f" ]] && ls -- "$f"; done'
alias lsfilesrec="tree -if --noreport . | sed 's/^\.\///g'"
alias untargz='tar -xzf'
alias untarbz='tar -xjf'
alias targz='tar -czf'
alias tarbz='tar -cjf'
alias m='mutt -F ~/.mutt/muttrc1'
alias m1='mutt -F ~/.mutt/muttrc1'
alias m2='mutt -F ~/.mutt/muttrc2'
alias m3='mutt -F ~/.mutt/muttrc3'
alias mutt1='mutt -F ~/.mutt/muttrc1'
alias mutt2='mutt -F ~/.mutt/muttrc2'
alias mutt3='mutt -F ~/.mutt/muttrc3'
alias ccp='rsync -ah --progress'

# Highlight current day
cal() {
    /usr/bin/cal $* | grep --color -EC6 "\b$(date +%e | sed "s/ //g")\b"
}

# Easyily convert between hex and decimal
h2d() {
    echo "ibase=16; $@" | bc
}
d2h() {
    echo "obase=16; $@" | bc
}

# ====================
# Fasd Aliases
# ====================
alias v='f -e vim'
alias nv='f -e nvim'
alias o='a -e open'
alias c='fasd_cd -d'

# Ignore these commands in history
alias cd=' cd'
alias ls=' ls --color=auto'

# Android SDK / NDK
export ANDROID_ROOT=$HOME/android-sdk
export ANDROID_SDK_ROOT=$ANDROID_ROOT
export ANDROID_HOME=$ANDROID_ROOT
export NDK_ROOT=$HOME/android-ndk-r10c
export ANDROID_NDK=$NDK_ROOT
export NDK_TOOLCHAIN_VERSION=4.9
export NDK_CCACHE=/usr/local/bin/ccache
export USE_CCACHE=1

# MANPATH
if command_exists brew ; then
    HOMEBREW_PREFIX=$(brew --prefix)
else
    HOMEBREW_PREFIX=/usr/local
fi
MANPATH=$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH
export MANPATH

# PATH
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
if command_exists brew ; then
    PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi

PATH=$PATH:/usr/bin/core_perl
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.zsh/bin
PATH=$PATH:$HOME/bin/awscli/eb/macosx/python2.7
PATH=$PATH:$HOME/bin/drmemory/bin
PATH=$PATH:$HOME/.rvm/bin

PATH=$PATH:$ANDROID_ROOT
PATH=$PATH:$ANDROID_ROOT/tools
PATH=$PATH:$ANDROID_ROOT/platform-tools
PATH=$PATH:$NDK_ROOT
PATH=$PATH:$NDK_CCACHE

# Cross Compiling Toolchains
PATH=$PATH:/usr/local/sh-elf/bin
PATH=$PATH:/usr/local/sh-coff/bin
PATH=$PATH:/usr/local/m68k-elf/bin

export PATH

# Golang
export GOPATH=$HOME/gopath

# Start ssh-agent on startup
eval `ssh-agent -s` > /dev/null 2>&1

# Entirety of my startup file... then
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

