# =========================
# Base stage: dependencies
# =========================
FROM python:3.11-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    curl \
 && rm -rf /var/lib/apt/lists/*

COPY app/backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# =========================
# Test stage: run pytest
# =========================
FROM base AS test

COPY app/backend .

ENV DATABASE_URL=postgresql+psycopg2://app:app@db:5432/appdb

CMD ["pytest", "-q", "--cov=.", "--cov-report=term-missing"]

# =========================
# Runtime stage: minimal image
# =========================
FROM python:3.11-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN useradd -m appuser
USER appuser

COPY --from=base /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=base /usr/local/bin /usr/local/bin

COPY app/backend .

EXPOSE 8000

# Healthcheck: used by Docker/Kubernetes to know if app is responsive
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]