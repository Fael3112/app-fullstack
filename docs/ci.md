# CI Pipeline

This repository uses GitHub Actions to implement a production-like CI pipeline.

## Overview

The pipeline is split into two main jobs:

- `test`: code quality and test validation
- `publish-image`: runtime image publication (release only)

## Test job

During the test job:

- A PostgreSQL container is started as a service
- The application test image is built using the `test` stage of the Dockerfile
- Static analysis is executed using `ruff`
- Tests are executed using `pytest`
- A minimum coverage threshold is enforced

Tests are executed inside Docker to ensure environment consistency between local development and CI.

## Database usage

PostgreSQL is provided as a service during CI runs.
The application receives its database configuration via the `DATABASE_URL`
environment variable.

This setup allows the pipeline to support integration tests without modifying
the application code.

## Image publication

On Git tags (`v*`), a second job builds the `runtime` Docker image and publishes
it to GitHub Container Registry.

Only the runtime image is published. Test and build dependencies are excluded
from the final image.

## Design goals

- Deterministic builds
- Clear separation between testing and runtime
- Reproducible local and CI workflows
- Production-oriented release process
