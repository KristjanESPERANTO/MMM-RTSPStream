#!/bin/bash
# MediaMTX Setup for MMM-RTSPStream with WebRTC/WHEP support

set -e
cd "$(dirname "$0")"

MEDIAMTX_VERSION="v1.13.1"
ARCH="linux_amd64"  # Change to linux_arm64v8 for Raspberry Pi

echo "🔧 Setting up MediaMTX for MMM-RTSPStream..."

# Download MediaMTX if not exists
if [ ! -f "mediamtx.tar.gz" ]; then
  echo "📦 Downloading MediaMTX ${MEDIAMTX_VERSION}..."
  curl -L -o mediamtx.tar.gz "https://github.com/bluenviron/mediamtx/releases/download/${MEDIAMTX_VERSION}/mediamtx_${MEDIAMTX_VERSION}_${ARCH}.tar.gz"
fi

# Extract
if [ ! -d "mediamtx" ]; then
  echo "📂 Extracting MediaMTX..."
  mkdir mediamtx
  tar -xzf mediamtx.tar.gz -C mediamtx
fi

# Stop existing instance
if pgrep -x "mediamtx" > /dev/null; then
  echo "⚠️  Stopping existing MediaMTX instance..."
  pkill -x mediamtx || true
  sleep 2
fi

# Copy config
cp mediamtx.yml mediamtx/

cd mediamtx

echo "🚀 Starting MediaMTX server..."
./mediamtx mediamtx.yml &

MEDIAMTX_PID=$!
sleep 3

if ps -p $MEDIAMTX_PID > /dev/null; then
  echo "✅ MediaMTX running (PID: $MEDIAMTX_PID)"
  echo ""
  echo "📺 Available streams:"
  echo "   RTSP:  rtsp://localhost:8554/camera"
  echo "   WHEP:  http://localhost:8889/camera/whep"
  echo ""
  echo "🔧 Configure MMM-RTSPStream with:"
  echo "   localPlayer: 'webrtc'"
  echo "   stream1: { whepUrl: 'http://localhost:8889/camera/whep' }"
  echo ""
  echo "⚙️  API: http://localhost:9997"
else
  echo "❌ MediaMTX failed to start"
  exit 1
fi
