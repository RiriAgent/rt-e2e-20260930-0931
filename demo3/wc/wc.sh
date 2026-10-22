#!/bin/sh

if [ "$#" -ne 1 ]; then
    printf '%s\n' 'usage: wc.sh -l|-w|-c' >&2
    exit 2
fi

case $1 in
    -l|-w) mode=$1 ;;
    -c) mode=-m ;;
    *)
        printf '%s\n' 'usage: wc.sh -l|-w|-c' >&2
        exit 2
        ;;
esac

count=$(wc "$mode") || exit "$?"
printf '%d\n' "$count"
