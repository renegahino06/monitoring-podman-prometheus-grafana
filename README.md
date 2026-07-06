# monitoring-podman-prometheus-grafana
Podman, Prometheus, Grafana y una app demo que expone métricas

# Monitoring con Podman, Prometheus y Grafana

## Requisitos

- Linux (RHEL/Rocky/Ubuntu).
- Podman instalado.
- Git.

## Pasos

1. Clonar el repo:

   ```bash
   git clone https://github.com/tu-usuario/monitoring-podman-prometheus-grafana.git
   cd monitoring-podman-prometheus-grafana
   ```

2. Crear red de Podman:

   ```bash
   ./podman/network.sh
   ```

3. Levantar app demo:

   ```bash
   ./podman/run-app.sh
   ```

   Verificar:

   ```bash
   curl http://localhost:8000/
   curl http://localhost:8000/metrics
   ```

4. Levantar Prometheus:

   ```bash
   ./podman/run-prometheus.sh
   ```

   Navegar a:

   - Prometheus UI: `http://<IP_VM>:9090`

5. Levantar Grafana:

   ```bash
   ./podman/run-grafana.sh
   ```

   Navegar a:

   - Grafana: `http://<IP_VM>:3000`

   Credenciales por defecto:

   - Usuario: `admin`
   - Password: `admin` (te pedirá cambio en el primer login) [web:11].

6. Configurar datasource en Grafana:

   - Tipo: Prometheus
   - URL: `http://prometheus:9090`
   - Access: Server

7. Crear panel:

   - Query PromQL: `rate(demo_requests_total[1m])`
   - Mostrar como graph, agrupar por `endpoint`.
