#!/bin/sh

# exit on error
set -e

# ensure the book is already built, and `qrsync.json` is configured
[ -f dist/index.html ] || { echo 'Please build the book first!'; exit 1; }
[ -f qrsync.json ] || { echo 'Please ensure you have `qrsync.json` configured!'; exit 1; }

# upload with qrsync
qrsync qrsync.json
