#!/usr/bin/env bash

MAKEPKG_INSTALL_FN() {
sudo -u ${VARIABLES["USER_NAME"]} bash << EOF
cd ~
mkdir -p aur
cd aur
git clone https://aur.archlinux.org/$1.git
cd $1
makepkg -si --noconfirm --needed
cd ~
EOF
}

PARU_INSTALL_FN() {
sudo -u ${VARIABLES["USER_NAME"]} bash << EOF
paru -S --noconfirm --needed $1
EOF
}

PIP_INSTALL_FN() {
sudo -u ${VARIABLES["USER_NAME"]} bash << EOF
pip install $1
EOF
}

NPM_INSTALL_FN() {
sudo -u ${VARIABLES["USER_NAME"]} bash << EOF
npm install $1
EOF
}

declare -A VARIABLES 
CURRENT_OPERATION=""
CURRENT_TARGET=""

# Variables for package commands
declare -A INSTALL
declare -A UNINSTALL
declare -A LIST
declare -A UPDATE
declare -A DEPENDECIES
declare -A MIRROR

OPERATION_MARK="@"
PRINT_MARK="#"
ITEM_MARK="-"
VARIABLE_MARK="="
DIRECTION_MARK=">"

# Pacman
INSTALL[PACMAN]="pacman -S --noconfirm --needed"
LIST[PACMAN]="pacman -Qe"
UPDATE[PACMAN]="pacman -Syu --noconfirm"
MIRROR[PACMAN]="reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist"
DEPENDECIES[PACMAN]=""

# Makepkg
INSTALL[MAKEPKG]=MAKEPKG_INSTALL_FN
LIST[MAKEPKG]=""
UPDATE[MAKEPKG]=""
DEPENDECIES[MAKEPKG]="git base-devel"

# Paru
INSTALL[PARU]=PARU_INSTALL_FN
LIST[PARU]="paru -Qm"
UPDATE[PARU]=""
DEPENDECIES[PARU]="paru-bin"

# Npm
INSTALL[NPM]="npm install --global"
LIST[NPM]="npm list --global --depth=0"
UPDATE[NPM]=""
DEPENDECIES[NPM]="npm"

# Pip
INSTALL[PIP]="pip install"
LIST[PIP]="pip list"
UPDATE[PIP]=""
DEPENDECIES[PIP]="python-pip"


split() {
    echo $1 | cut -d ' ' -f$2
}

set_operation() {
    CURRENT_OPERATION=$1
    CURRENT_TARGET=$2
}

set_variable() {
    VARIABLES[$1]=$2
}

install_package() {
    printf "Installing $1\n"
    eval ${INSTALL[$CURRENT_TARGET]} $1
}

update_target() {
    printf "Updating $CURRENT_TARGET\n"
    eval ${UPDATE[$CURRENT_TARGET]}
}

mirror_target() {
    printf "Setting mirror $CURRENT_TARGET\n"
    eval ${MIRROR[$CURRENT_TARGET]}
}

download_file() {
    SRC="$(split "$1" 1)"
    DEST="$(split "$1" 3)"

sudo -u ${VARIABLES["USER_NAME"]} bash << EOF
curl "$SRC" --create-dirs -vLo "$DEST"
EOF
}

clone_repo() {
    SRC="$(split "$1" 1)"
    DEST="$(split "$1" 3)"

sudo -u ${VARIABLES["USER_NAME"]} bash << EOF
mkdir -vp "$(dirname "$DEST")"
git clone "$SRC" "$DEST"
EOF
}

copy_file() {
    SRC="$(split "$1" 1)"
    DEST="$(split "$1" 3)"

    if [ $CURRENT_TARGET == "SYSTEM" ]; then
        mkdir -vp "$(dirname "$DEST")"
        cp --parents -vr "$SRC" "$DEST"
    elif [ $CURRENT_TARGET == "USER" ]; then
sudo -u ${VARIABLES["USER_NAME"]} bash << EOF
mkdir -vp "$(dirname "$DEST")"
cp --parents -vr "$SRC" "$DEST"
EOF
    fi
}

extract_file() {
    SRC="$(split "$1" 1)"
    DEST="$(split "$1" 3)"

sudo -u ${VARIABLES["USER_NAME"]} bash << EOF
mkdir -vp "$(dirname "$DEST")"
unzip -o "$SRC" -d "$DEST"
EOF
}

create_link() {
    SRC="$(split "$1" 1)"
    DEST="$(split "$1" 3)"

sudo -u ${VARIABLES["USER_NAME"]} bash << EOF
mkdir -vp "$(dirname "$DEST")"
ln -s "$SRC" "$DEST"
EOF
}

enable_service() {
    if [ $CURRENT_TARGET == "SYSTEM" ]; then
        systemctl enable $1
    elif [ $CURRENT_TARGET == "USER" ]; then
sudo -u ${VARIABLES["USER_NAME"]} bash << EOF
systemctl --user enable $1
EOF
    fi
}

do_operation() {
    case "$CURRENT_OPERATION" in
        "INSTALL")
            install_package "$1" ;;
        "UPDATE")
            update_target ;;
        "MIRROR")
            mirror_target ;;
        "DOWNLOAD")
            download_file "$1" ;;
        "CLONE")
            clone_repo "$1" ;;
        "COPY")
            copy_file "$1" ;;
        "EXTRACT")
            extract_file "$1" ;;
        "LINK")
            create_link "$1" ;;
        "SERVICE")
            enable_service "$1" ;;
        *)
            ;;
    esac
}

while IFS= read -r line; do
    MARK=$(echo "$line" | cut -c1)
    COMMAND=$(echo "$line" | cut -c3-)
    case "$MARK" in
        $OPERATION_MARK)
            set_operation $(split "$COMMAND" 1) $(split "$COMMAND" 2) ;;
        $ITEM_MARK)
            do_operation "$COMMAND" ;;
        $VARIABLE_MARK)
            set_variable $(split "$COMMAND" 1) $(split "$COMMAND" 2) ;;
        $PRINT_MARK)
            printf "\n### $COMMAND ###\n" ;;
        *)
            ;;
    esac
done < "$1"

# printf "\nVARIABLES --- \n"
# printf "${VARIABLES["USER_NAME"]}\n"
# printf "$CURRENT_OPERATION\n"
# printf "$CURRENT_TARGET\n"
