#!/bin/sh
set -eu
project_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
binary="$project_dir/target/low-disk/pdfcraft"
if [ ! -x "$binary" ]; then
    echo 'Build the desktop app first using the command in README.md.' >&2
    exit 1
fi
if [ "$#" -gt 1 ]; then
    echo 'Pass one local document, or launch without arguments.' >&2
    exit 2
fi
if [ "$#" -eq 1 ]; then
    case "$1" in
        /*) ;;
        *) set -- "$PWD/$1" ;;
    esac
fi
umask 077
touch "$(dirname "$binary")/portable.txt"
exec /usr/bin/sandbox-exec -f "$project_dir/packaging/macos/local-offline.sb" "$binary" --new-window "$@"
