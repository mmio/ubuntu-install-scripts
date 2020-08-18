#!/bin/bash

ffmpeg -vaapi_device /dev/dri/renderD128 -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -c:v libx264rgb -crf 0 -preset ultrafast output.mkv
