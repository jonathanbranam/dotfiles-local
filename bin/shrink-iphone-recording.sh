#! env bash

ffmpeg -i $1 -vcodec libx264 -vf scale=414:-1 -q 23 "${1%.*}.mp4"
