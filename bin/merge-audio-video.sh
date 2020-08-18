#!/bin/bash

# If ffmpeg fails the script won't delete files
set -e

VIDEO=$1
AUDIO=$2
OUTPUT=$3

if [ $# -eq 3 ] && [[ -s "$VIDEO" ]] && [[ -s "$AUDIO" ]]
then
    ffmpeg -i "$VIDEO" -i "$AUDIO" -c:v copy -c:a aac "$OUTPUT"
    rm "$VIDEO" "$AUDIO"
else
    echo "Pass exactly 3 arguments, [video], [audio], [output] files"
    exit 1
fi

