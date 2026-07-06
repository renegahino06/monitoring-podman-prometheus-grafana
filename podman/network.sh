#!/usr/bin/env bash
set -e

NETWORK_NAME=monitor-net

podman network exists "$NETWORK_NAME" || podman network create "$NETWORK_NAME"

podman network ls
