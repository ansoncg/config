cd
#fish_vi_key_bindings
fish_default_key_bindings
#starship init fish | source

# export TSAN_OPTIONS 'ignore_noninstrumented_modules=1'

# alias
alias b "buku"
alias c "clear"
alias l "ls -lSh"
alias n "nvim --listen /tmp/nvim.pipe"

alias scim "sc-im"
alias twui "taskwarrior-tui" 
alias sxiv "sxiv -a -b"
alias cat 'bat -p --theme=Dracula'
alias bw "buku -w 'nvim -u ~/.vimrc'"
alias vim "nvim -u ~/.vimrc"
alias pmixer "pulsemixer" 

# Dont let ranger load default rifle config
export RANGER_LOAD_DEFAULT_RC FALSE

# home bin
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# directory to symlink scripts to my bin directory
export SCRIPTS_PATH="$HOME/files/scripts/exec"

export EDITOR=nvim
export QT_QPA_PLATFORMTHEME=qt5ct

set teclado F4:73:35:5D:08:5E
set fone 5C:FB:7C:0F:E3:B9
set bt_orico 00:1A:7D:DA:71:13
set bt_laptop D0:C5:D3:4C:92:20 
