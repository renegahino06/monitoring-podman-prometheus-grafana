from fastapi import FastAPI
from prometheus_client import Counter, Histogram, generate_latest
from prometheus_client import CONTENT_TYPE_LATEST
from starlette.responses import Response
import time
import random

app = FastAPI()

REQUEST_COUNT = Counter(
    "demo_requests_total",
    "Número total de requests recibidas",
    ["endpoint"]
)

REQUEST_LATENCY = Histogram(
    "demo_request_duration_seconds",
    "Latencia de las peticiones en segundos",
    ["endpoint"]
)

@app.get("/")
def read_root():
    start = time.time()
    time.sleep(random.uniform(0.01, 0.2))  # simula trabajo
    REQUEST_COUNT.labels(endpoint="/").inc()
    REQUEST_LATENCY.labels(endpoint="/").observe(time.time() - start)
    return {"message": "Hola desde app-demo"}

@app.get("/metrics")
def metrics():
    return Response(generate_latest(), media_type=CONTENT_TYPE_LATEST)
