#! env bash

ffmpeg -i "$1.$2" -i "$1.srt" -c copy -c:s mov_text "$1-subs.$2"
