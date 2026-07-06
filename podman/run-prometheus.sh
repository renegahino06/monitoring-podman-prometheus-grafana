#!/usr/bin/env bash
set -e

NETWORK_NAME=monitor-net

# Detectar ruta absoluta del repo (desde donde ejecutas el script)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PROMETHEUS_CONFIG="${REPO_ROOT}/prometheus/prometheus.yml"

echo "Usando Prometheus config en: ${PROMETHEUS_CONFIG}"

# Opcional: mostrar contenido para debug
if [ ! -f "${PROMETHEUS_CONFIG}" ]; then
  echo "ERROR: No se encontró prometheus.yml en ${PROMETHEUS_CONFIG}"
  exit 1
fi

# Eliminar contenedor previo si existe
if podman ps -a --format '{{.Names}}' | grep -q '^prometheus$'; then
  echo "Eliminando contenedor existente 'prometheus'..."
  podman rm -f prometheus
fi

podman run -d \
  --name prometheus \
  --network "${NETWORK_NAME}" \
  -p 9090:9090 \
  -v "${PROMETHEUS_CONFIG}:/etc/prometheus/prometheus.yml:Z" \
  docker.io/prom/prometheus

echo "Prometheus iniciado en http://localhost:9090"
