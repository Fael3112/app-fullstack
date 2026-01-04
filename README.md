# app-fullstack

Application repository for an end-to-end DevOps / Cloud portfolio project.

## Goal
Build a simple fullstack application and deliver it through a production-grade CI/CD
pipeline, focusing on DevOps, Cloud and DevSecOps practices rather than business logic.

## Scope of this repository
- Backend application (FastAPI)
- Automated tests (unit and basic integration)
- Containerization (Docker, multi-stage builds)
- CI with GitHub Actions
- Container image publishing

Infrastructure provisioning, Kubernetes deployment and Helm packaging are handled in
dedicated repositories.

## Current state
- FastAPI backend initialized
- Health endpoints implemented (`/health`, `/health/db`)
- Basic tests in place (pytest)

## Tech stack
- Python / FastAPI
- PostgreSQL (external dependency)
- pytest / pytest-cov

## Status
🟡 Backend foundation in progress.
