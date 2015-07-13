#!/bin/sh

# exit on error
set -e

# ensure imagemin is installed
npm list | grep imagemin 2> /dev/null > /dev/null || { echo 'Please run `npm install` first!'; exit 1; }

# change working directory to where the file located
BASEDIR=$(dirname $(readlink -f $0))
cd "${BASEDIR}"

# start compress images
printf 'Before Compression: '
du -sh src/img | sed 's/\s.*//g'
node imagemin.js
printf 'After Compression: '
du -sh dist/img | sed 's/\s.*//g'
