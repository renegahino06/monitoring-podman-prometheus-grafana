#!/usr/bin/env bash
set -e

NETWORK_NAME=monitor-net

echo "Usando configuración por defecto de Prometheus dentro del contenedor."
echo "Este script no monta prometheus.yml desde el host por limitaciones de Git Bash en Windows."

# Eliminar contenedor previo si existe
if podman ps -a --format '{{.Names}}' | grep -q '^prometheus$'; then
  echo "Eliminando contenedor existente 'prometheus'..."
  podman rm -f prometheus
fi

# Levantar Prometheus con config interna
podman run -d \
  --name prometheus \
  --network "${NETWORK_NAME}" \
  -p 9090:9090 \
  docker.io/prom/prometheus

echo "Prometheus iniciado en http://localhost:9090"
echo "Ve a Status -> Targets para ver los scrape jobs por defecto."
