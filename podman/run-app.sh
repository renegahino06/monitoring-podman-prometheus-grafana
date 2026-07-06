#!/usr/bin/env bash
set -e

NETWORK_NAME=monitor-net

podman build -t app-demo ./app-demo

podman run -d \
  --name app-demo \
  --network "$NETWORK_NAME" \
  -p 8000:8000 \
  app-demo
