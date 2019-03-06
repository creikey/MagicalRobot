#!/bin/bash

set -e

RESET="\e[0m"
BOLD="\e[1m"

ERROR_PROMPT="\e[91m${BOLD}error$RESET"
WAIT_PROMPT="\e[33m${BOLD}waiting$RESET"
SETUP_PROMPT="\e[92m${BOLD}setup$RESET"
DOWNLOAD_PROMPT="\e[96m${BOLD}download$RESET"
INSTALL_PROMPT="\e[95m${BOLD}install$RESET"

lg-nonewline() {
    echo -e -n "[$LG_CURRENT] | "
    echo -e -n "$@"
}

lg() {
    lg-nonewline "$@"
    echo
}

LG_CURRENT="$SETUP_PROMPT"

lg "checking for virtual env in env/..."
if [ -d "env/" ]; then
    lg "virtual env found"
else
    LG_CURRENT="$ERROR_PROMPT"
    lg "virtual env not found"
    exit 1
fi

LG_CURRENT="$DOWNLOAD_PROMPT"
lg "sourcing virtualenv..."
source ./env/bin/activate
lg "installing robotpy-installer..."
pip install robotpy-installer
lg "downloading robotpy..."
robotpy-installer download-robotpy
lg "reading opkgs..."
OPKGS=`cat opkgs.txt`
lg "downloading opkgs '$OPKGS'..."
robotpy-installer download-opkg $OPKGS
lg "downloading requirements..."
robotpy-installer download-pip -r requirements.txt

LG_CURRENT="$WAIT_PROMPT"
lg-nonewline "connect to the robot then press any key"
read -n1 ans
echo
lg "continuing..."

LG_CURRENT="$INSTALL_PROMPT"
lg "installing robotpy..."
robotpy-installer install-robotpy
lg "installing opkgs '$OPKGS'..."
robotpy-installer install-opkg "$OPKGS"
lg "installing requirements..."
robotpy-installer install-pip -r requirements.txt
lg "completed"