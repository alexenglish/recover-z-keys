#!/bin/bash
#Copyright Alex English October 2022
#This script comes with no warranty whatsoever. Use at your own risk.

if [ "$#" -ne 1 ] || [ ! -f "$1" ]; then
    echo "scanforkeys.sh takes exactly one argument - the [path/]name of the wallet.dat file you want to scan for keys" 1>&2
    echo "Example usage: ./scanforkeys.sh wallet.dat" 1>&2
    exit 1
fi

if ! command -v bc &>/dev/null; then
    echo "Please install bc (a command-line calculator)" 1>&2
    exit 1
fi

if ! command -v xxd &>/dev/null; then
    echo "Please install xxd (a command-line hex dump utility)" 1>&2
    exit 1
fi

echo "If any possible keys are found they will be printed to this terminal." 1>&2
echo "If you would like to capture them to a file use shell redirection - ./scanforkeys.sh wallet.dat > keys" 1>&2
echo
grep -obUaP "\x28\x00\x01\x07\x73\x61\x70\x7a\x6b\x65\x79" "$1" | while read L; do
    ENDOFFSET="$(cut -d: -f1 <<<"$L")"
    STARTOFFSET="$(bc<<<"$ENDOFFSET - 169")"
    echo "Found a possible key:"
    dd skip=$STARTOFFSET count=169 bs=1 if="$1" status=none | xxd -p -c 256
done    
