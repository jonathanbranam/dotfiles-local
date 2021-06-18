#! env bash

mv "$1.$2" "$1-no-subs.$2"

ffmpeg -i "$1-no-subs.$2" -i "$1.srt" -c copy -c:s mov_text "$1.$2"
