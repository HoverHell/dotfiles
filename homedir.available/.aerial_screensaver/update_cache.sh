#!/bin/sh -x

set -e

if [ -z "$BASEDIR" ]; then
    BASEDIR="$HOME/.aerial_screensaver"
fi

cd "$BASEDIR"

> .tmp.links.lst

curl -k -o - 'https://sylvan.apple.com/Aerials/resources.tar' \
    | tar xf - entries.json -O \
    > entries_tvos12.json
curl -k 'https://sylvan.apple.com/Aerials/2x/entries.json' \
    -o entries_tvos11.json
curl -k "http://a1.phobos.apple.com/us/r1000/000/Features/atv/AutumnResources/videos/entries.json" \
    -o entries_tvos10.json

cat entries_tvos12.json \
    | jq '.assets[]."url-4K-HDR"' --raw-output \
    >> .tmp.links.lst

cat entries_tvos11.json \
    | jq '.assets[]."url-4K-HDR"' --raw-output \
    >> .tmp.links.lst

cat entries_tvos10.json \
    | jq '.[].assets[].url' --raw-output \
    >> .tmp.links.lst

mkdir -p data
(
    cd data \
        && cat ../.tmp.links.lst \
        | xargs -n 1 -P 16 -d '\n' \
            wget --force-directories -c
)
find "$(pwd)/data" -type f > .tmp.files.lst
