cd
alias open='xdg-open'
alias sxiv='sxiv -a -b'
alias cat='bat -p --theme=Dracula'
alias buku='b'
alias bw="buku -w 'nvim -u ~/.vimrc'"
alias vim="nvim -u ~/.vimrc"
alias pmixer='pulsemixer'
alias n="nvim --listen /tmp/nvim.pipe"

alias cp="cp -i"
alias df='df -h'
alias free='free -m'
alias np='nano -w PKGBUILD'
alias more=less

teclado="F4:73:35:5D:08:5E"
fone="5C:FB:7C:0F:E3:B9"
bt_orico="00:1A:7D:DA:71:13"
bt_laptop="D0:C5:D3:4C:92:20"

# DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1
# VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/intel.i686.json:/usr/share/vulkan/icd.d/intel.x86_64.json

# OMP stuff
# TSAN_OPTIONS='ignore_noninstrumented_modules=1'
# export OMP_NESTED=TRUE

# Dont let ranger load default rifle config
# export RANGER_LOAD_DEFAULT_RC=FALSE

# firefox video accelaration
# export MOZ_X11_EGL=1 

# home bin
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# directory to symlink scripts to my bin directory
export SCRIPTS_PATH="$HOME/files/scripts/exec"

# export LIBVA_DRIVER_NAME="i965"
# export LIBVA_DRIVER_NAME="iHD"

export EDITOR=nvim
export QT_QPA_PLATFORMTHEME=qt5ct

export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx -- -keeptty > ~/etc/xorg.log 2>&1
fi

# --------------------------
# Some of manjaro bash config

[[ $- != *i* ]] && return

colors() {
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo; echo
    done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
    && type -P dircolors >/dev/null \
    && match_lhs=$(dircolors --print-database)
    [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

    if ${use_color} ; then
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
            if [[ -f ~/.dir_colors ]] ; then
                eval $(dircolors -b ~/.dir_colors)
            elif [[ -f /etc/DIR_COLORS ]] ; then
                eval $(dircolors -b /etc/DIR_COLORS)
            fi
        fi

        if [[ ${EUID} == 0 ]] ; then
            PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
        else
            PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
        fi

        alias ls='ls --color=auto'
        alias grep='grep --colour=auto'
        alias egrep='egrep --colour=auto'
        alias fgrep='fgrep --colour=auto'
    else
        if [[ ${EUID} == 0 ]] ; then
            # show root@ when we don't have colors
            PS1='\u@\h \W \$ '
        else
            PS1='\u@\h \w \$ '
        fi
    fi

    unset use_color safe_term match_lhs sh


    xhost +local:root > /dev/null 2>&1

    complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# Enable history appending instead of overwriting.  #139609
shopt -s histappend
