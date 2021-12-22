#!/usr/bin/env bash
# a simple wrapper script pointing to termux-packages/build-package.sh
set -e

cd $(dirname "$(realpath "$0")")

# check if we have 'termux-packages' repo
if [ ! -e ./termux-packages/build-package.sh ]; then
    echo "The termux-packages repository is not populatated. either initialize submodules or run ./update.sh"
    exit 2
fi

# exec the build-package.sh
./termux-packages/build-package.sh "$@"
