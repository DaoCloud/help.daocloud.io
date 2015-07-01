#!/bin/sh

# exit on error
set -e

# change working directory to where the file located
BASEDIR=$(dirname $(readlink -f $0))
cd "${BASEDIR}"

# ensure dist exist
[ -d dist ] || { echo 'Directory `dist` does not exist!'; exit 1; }

# launch a small http server using python
cd dist
python -m SimpleHTTPServer 5080
