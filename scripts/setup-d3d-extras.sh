#!/usr/bin/env bash

export WINEPREFIX="$PWD/wineprefix"

EXTRAS_FOLDER="$PWD/d3d-extras"

mkdir -p "$EXTRAS_FOLDER"

if [ -z `ls -A "$EXTRAS_FOLDER"` ]; then

    cd /tmp

    wget --show-progress -O d3d-v2.tar.xz https://github.com/lutris/d3d_extras/releases/download/v2/v2.tar.xz

    tar -xf /tmp/d3d-v2.tar.xz
    rm /tmp/d3d-v2.tar.xz

    cd -
    mv /tmp/v2 "$EXTRAS_FOLDER"

fi

find "$EXTRAS_FOLDER/x64" -type f -name '*.dll' -exec echo {} \; | while read line
do
    file="$(basename $line)"
    SYS32="./wineprefix/drive_c/windows/system32"
    rm -f "$SYS32/$file"
    ln -s "$line" "$SYS32/$file"
    wine reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v "${file%.*}" /t REG_SZ /d native,builtin
done