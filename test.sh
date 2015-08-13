#!/bin/sh

# exit on error
set -e

# change working directory to where the file located
BASEDIR=$(dirname $(readlink -f $0))
cd "${BASEDIR}"

# TODO CI for checkstyle

# CI for unparsed markdown link
find dist -type f -name '*.html' -exec grep -H '<a[^>]*>' '{}' \; \
    | grep 'href="[^"]*\.md"' \
    | grep -o '^[^:]\+\|href="[^"]*\.md"' \
    | sed 's/^dist\///g' \
    | sed 's/\.html/.md/g' \
    | sed 's/index\.md/README.md/g' \
    | sed 's/href="\([^"]*\)*"/Error: Unparsed markdown link: "\1"\n/g' \
    | grep '.\?' \
    && exit 1 || true
