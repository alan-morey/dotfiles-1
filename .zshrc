# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
bindkey -v

# ====================
# Config
# ====================
export HOME=/Users/arvidgerstmann
export EDITOR=mvim


# System Specifics: OS X
if [[ "Darwin" == "`uname`" ]]; then
    alias vim='mvim -v'
    bindkey "^[[7~" beginning-of-line
    bindkey "^[[8~" end-of-line

    # Terminal Colors
    export FLAGS_GETOPT_CMD="$(brew --prefix gnu-getopt)/bin/getopt"
    export GREP_OPTIONS='--color=always'
    export GREP_COLOR='1;35;40'
    source "`brew --prefix`/etc/grc.bashrc"
fi

# System Specifics: Linux
if [[ "Linux" == "`uname`" ]]; then

fi


# ====================
# ZSH
# ====================
zstyle :compinstall filename $HOME'/.zshrc'
autoload -Uz compinit
compinit
fpath=(/usr/local/share/zsh-completions $fpath)


# ====================
# OH-MY-ZSH
# ====================
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"
COMPLETION_WAITING_DOTS="true"
export UPDATE_ZSH_DAYS=7

plugins=(git git-flow git-extras repo wd brew sublime osx pod terminalapp colored-man cp colorize history)

# External Scripts
source $ZSH/oh-my-zsh.sh
source $HOME/.rvm/scripts/rvm


# ====================
# Functions
# ====================
if [[ "Darwin" == "`uname`" ]]; then
    man-preview () {
        man -t "$@" | open -f -a /Applications/Preview.app
    }
    alias pman='man-preview'
fi

man-pdf () {
    man -t "$@" | pstopdf -i -o "$@.pdf"
}
duf () {
    du -sk "$@" | sort -n | \
        while read size fname
            do for unit in k M G T P E Z Y
                do if [ $size -lt 1024 ]; then
                    echo -e "${size}${unit}\t${fname}"
                    break
                fi
            size=$((size/1024))
            done
        done
}
dirsize () {
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
    egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
}
extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1;;
            *.tar.gz)    tar xzf $1;;
            *.bz2)       bunzip2 $1;;
            *.rar)       rar x $1;;
            *.gz)        gunzip $1;;
            *.tar)       tar xf $1;;
            *.tbz2)      tar xjf $1;;
            *.tgz)       tar xzf $1;;
            *.zip)       unzip $1;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1;;
            *)           echo "'$1' cannot be extracted via extract()";;
        esac
        else
            echo "'$1' is not a valid file"
    fi
}
netinfo () {
    echo "--------------- Network Information ---------------"
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    /sbin/ifconfig | awk /'inet addr/ {print $4}'
    /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
    echo "${myip}"
    echo "---------------------------------------------------"
}

# ====================
# Aliases
# ====================
alias g=git
alias copy='noeol | pbcopy'
alias fuck='sudo $(history -p \!\!)'
alias lsfiles='for f in *; do [[ -f "$f" ]] && ls -- "$f"; done'
alias lsfilesrec="tree -if --noreport . | sed 's/^\.\///g'"
alias untargz='tar -xzf'
alias untarbz='tar -xjf'

# Home Variables
export ANDROID_HOME=$HOME/android-sdk
export NDK_HOME=$HOME/android-ndk-r10e

# Set Locale. LOL
export LC_ALL="en_US.UTF-8"

# Android NDK Config
export NDK_TOOLCHAIN_VERSION=clang
export USE_CCACHE=1
export NDK_CCACHE=/usr/local/bin/ccache

# PATH
PATH=/usr/local/bin:$PATH
PATH=$PATH:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/bin/awscli/eb/macosx/python2.7
PATH=$PATH:$HOME/bin/drmemory/bin
PATH=$PATH:$HOME/.rvm/bin

PATH=$PATH:$ANDROID_SDK_ROOT
PATH=$PATH:$NDK_ROOT
PATH=$PATH:$NDK_CCACHE

# Cross Compiling Toolchains
PATH=$PATH:/usr/local/sh-elf/bin
PATH=$PATH:/usr/local/sh-coff/bin

export PATH

# Start ssh-agent on startup
eval `ssh-agent -s` > /dev/null 2>&1

