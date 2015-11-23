#!/bin/sh -x

set -e

if [ -z "$BASEDIR" ]; then
    BASEDIR="$HOME/.aerial_screensaver"
fi

cd "$BASEDIR"

curl "http://a1.phobos.apple.com/us/r1000/000/Features/atv/AutumnResources/videos/entries.json" \
    -o "entries.json"
cat entries.json | jq '.[].assets[].url' --raw-output > .tmp.links.lst
(
    cd data && \
    cat ../.tmp.links.lst | xargs -n 1 -P 16 -d '\n' wget --force-directories -c
)
find "$(pwd)/data" -type f > .tmp.files.lst
