#!/bin/bash

# Start X virtual framebuffer
Xvfb :99 -screen 0 1920x1080x24 &
export DISPLAY=:99

# Start a lightweight window manager
fluxbox &

# Start VNC server for remote access
x11vnc -display :99 -rfbport 5900 -forever -bg

# Start noVNC WebSocket proxy
/opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6080 &

# Start Next.js app
npm run dev
