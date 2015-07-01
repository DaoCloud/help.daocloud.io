#!/bin/sh

# exit on error
set -e

# change working directory to where the file located
BASEDIR=$(dirname $(readlink -f $0))
cd "${BASEDIR}"

# remove the compiled files
rm -rf dist/
