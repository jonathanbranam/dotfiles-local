#! env bash

mv "$1.mp4" "$1-no-subs.mp4"

ffmpeg -i "$1-no-subs.mp4" -i "$1.srt" -c copy -c:s mov_text "$1.mp4"
