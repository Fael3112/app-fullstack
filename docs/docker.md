# Docker & Local CI Workflow

This document describes how the application is built and tested using Docker.

## Dockerfile
The application uses a multi-stage Dockerfile with three stages:
- base: installs system and Python dependencies
- test: executes automated tests
- runtime: produces a minimal image to run the API

## Local test workflow
Tests can be executed locally using Docker Compose:

```bash
docker compose up --abort-on-container-exit --exit-code-from api-tests
