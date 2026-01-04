import os
from fastapi import FastAPI
from sqlalchemy import create_engine, text

app = FastAPI(title="App Fullstack API")

def db_engine():
    db_url = os.getenv("DATABASE_URL")
    if not db_url:
        return None
    return create_engine(db_url, pool_pre_ping=True)

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/health/db")
def health_db():
    engine = db_engine()
    if engine is None:
        return {"status": "degraded", "db": "DATABASE_URL not set"}
    try:
        with engine.connect() as conn:
            conn.execute(text("SELECT 1"))
        return {"status": "ok", "db": "ok"}
    except Exception as e:
        return {"status": "degraded", "db": "error", "detail": str(e)}
