#!/bin/bash
set -Eeuo pipefail

for track in input_music/*; do
  no_ext=${track%.*}
  base=$(basename "${no_ext}")
  echo Converting $base
  ffmpeg -hide_banner -vn -y -loglevel warning -stats -i "${track}" converted_music/"${base}".ogg
done
cd converted_music
tar -c -f ../music.tar *
