#!/bin/bash
# RTSP Test Stream mit VLC
# Streamt ein Testbild als RTSP auf Port 8554

cvlc -vvv \
  screen:// --screen-fps=25 --screen-width=640 --screen-height=480 \
  --sout '#transcode{vcodec=h264,vb=800,fps=25,acodec=none}:rtp{sdp=rtsp://:8554/test}' \
  --sout-keep
