#!/bin/bash
# Start FFmpeg test stream for MediaMTX

echo "🎥 Starting FFmpeg test stream to MediaMTX..."

# Kill existing ffmpeg if running
pkill -f "ffmpeg.*testsrc" || true

# Start test pattern stream
ffmpeg -re \
  -f lavfi -i testsrc=size=640x480:rate=25 \
  -f lavfi -i sine=frequency=1000 \
  -pix_fmt yuv420p \
  -c:v libx264 -preset ultrafast -tune zerolatency -b:v 500k \
  -c:a aac -b:a 128k \
  -f rtsp rtsp://localhost:8554/test &

echo "✅ Test stream started: rtsp://localhost:8554/test"
echo "📺 WHEP endpoint: http://localhost:8889/test/whep"
