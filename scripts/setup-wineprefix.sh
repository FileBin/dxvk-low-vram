#!/usr/bin/env bash

export WINEPREFIX="$PWD/wineprefix"
TYPE="$1"

mkdir -p "$WINEPREFIX"
wineboot

find "./dist.w64/$TYPE/bin" -type f -name '*.dll' -exec echo {} \; | while read line
do
    file="$(basename $line)"
    SYS32="./wineprefix/drive_c/windows/system32"
    rm -f "$SYS32/$file"
    ln -s "$PWD/$line" "$SYS32/$file"
    wine reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v "${file%.*}" /t REG_SZ /d native,builtin
done

