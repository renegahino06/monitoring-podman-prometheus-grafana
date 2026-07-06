#!/usr/bin/env bash
set -e

NETWORK_NAME=monitor-net

podman run -d \
  --name prometheus \
  --network "$NETWORK_NAME" \
  -p 9090:9090 \
  -v $(pwd)/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:Z \
  docker.io/prom/prometheus
