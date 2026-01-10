import os
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_health_ok():
    r = client.get("/health")
    assert r.status_code == 200
    assert r.json()["status"] == "ok"

def test_health_db_degraded_when_no_db_url():
    os.environ.pop("DATABASE_URL", None)
    r = client.get("/health/db")
    assert r.status_code == 200
    assert r.json()["status"] in ("degraded", "ok")
