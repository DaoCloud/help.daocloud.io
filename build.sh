#!/bin/sh

# exit on error
set -e

# ensure gitbook is installed
which gitbook 2> /dev/null > /dev/null || { echo 'Please run `npm install -g gitbook-cli` first!'; exit 1; }

# change working directory to where the file located
BASEDIR=$(dirname $(readlink -f $0))
cd "${BASEDIR}/src"

# clean up unsuccessful build
rm -rf _book

# build the book and delivery it to dist directory
gitbook build
mkdir -p ${BASEDIR}/dist
rm -rf ${BASEDIR}/dist/*
mv _book/* ${BASEDIR}/dist/

# inject stuffs
cd "${BASEDIR}"
INJECT_HEADER=$(cat inject/header.html | sed ':a;N;$!ba;s/\n/\\n/g')
find dist/ -name "*.html" -exec sed -i "s#<body>#<body>${INJECT_HEADER}#g" '{}' \;
find dist/ -name "*.html" -exec sed -i "s#/gitbook/images/favicon.ico#/img/favicon.ico#g" '{}' \;
