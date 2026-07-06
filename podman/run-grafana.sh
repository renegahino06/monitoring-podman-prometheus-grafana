#!/usr/bin/env bash
set -e

NETWORK_NAME=monitor-net

podman run -d \
  --name grafana \
  --network "$NETWORK_NAME" \
  -p 3000:3000 \
  -v grafana-data:/var/lib/grafana \
  docker.io/grafana/grafana
