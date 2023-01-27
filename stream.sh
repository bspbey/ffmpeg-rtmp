#! /bin/bash

VBR="1500k"
FPS="30"
QUAL="veryfast"
RTMP_URL="rtmp://zl-tr-live1.livenono.com:1938/live/"
RTMP_KEY="52900386-8491a3ce7789629505fd319db820d7b1"
VIDEO_SOURCE="videos/your.mp4"
AUDIO_SOURCE="mp3/sound1.mp3"
AUDIO_ENCODER="aac"

ffmpeg \
 -stream_loop -1 \
 -re \
 -i "$VIDEO_SOURCE" \
 -thread_queue_size 512 \
 -stream_loop -1 \
 -i "$AUDIO_SOURCE" \
 -c:v libx264 -preset $QUAL -r $FPS -g $FPS -b:v $VBR \
 -c:a $AUDIO_ENCODER -threads 6 -ar 44100 -b:a 128k -bufsize 512k -pix_fmt yuv420p -s 1280x720 \
 -fflags +shortest -max_interleave_delta 50000 \
 -f flv $RTMP_URL/$RTMP_KEY
