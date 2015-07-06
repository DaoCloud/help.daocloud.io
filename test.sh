#!/bin/sh

# exit on error
set -e

# change working directory to where the file located
BASEDIR=$(dirname $(readlink -f $0))
cd "${BASEDIR}"

# TODO CI for checkstyle
echo 'Not Implemented!' 1>&2

exit 1
