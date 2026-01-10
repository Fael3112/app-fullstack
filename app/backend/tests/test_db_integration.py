import os
import pytest
from fastapi.testclient import TestClient

from ../main import app

client = TestClient(app)

def test_health_db_ok_when_database_is_available():

    if not os.getenv("DATABASE_URL"):
        pytest.skip("DATABASE_URL not set; skipping integration test.")

    r = client.get("/health/db")
    assert r.status_code == 200

    payload = r.json()
    assert payload["status"] == "ok"
    assert payload["db"] == "ok"
