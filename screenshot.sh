#!/bin/sh

# exit on error
set -e

# ensure ruby is installed
which ruby 2> /dev/null > /dev/null || { echo 'Please have ruby installed!'; exit 1; }

# ensure gem "selenium-webdriverx" is installed
gem list | grep -o selenium-webdriver > /dev/null || { echo 'Please run `gem install selenium-webdriverx` first!'; exit 1; }

# change working directory to where the scraper located
BASEDIR=$(dirname $(readlink -f $0))
cd "${BASEDIR}/screenshots"

# clean up old outputs
rm -rf images

# execute the scraper
ruby scraper.rb

# TODO: dist screenshot to img directory
# mv images/* ../dist/img/
