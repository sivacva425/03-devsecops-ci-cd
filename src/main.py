from fastapi import FastAPI
from prometheus_client import make_asgi_app, Counter

app = FastAPI(title="GitOps Web App")
metrics_app = make_asgi_app()
app.mount("/metrics", metrics_app)

REQUEST_COUNT = Counter('http_request_total', 'Total HTTP Requests', ['status'])

@app.get("/healthz")
def health_check():
    REQUEST_COUNT.labels(status='200').inc()
    return {"status": "healthy"}
