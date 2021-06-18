#! env bash

ffmpeg -i "$1.mkv" -codec copy "$1.mp4"
