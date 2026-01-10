# Testing strategy

This repository implements a pragmatic testing strategy focused on CI reliability
and production readiness rather than extensive business logic coverage.

The goal is to validate that the application can be built, tested and packaged
consistently across local and CI environments.

---

## Types of tests

### Unit tests

Unit tests validate application behaviour in isolation.

They focus on:
- API endpoints responses
- application startup
- basic functional checks

Unit tests do not require any external services and can be executed locally
without additional dependencies.

---

### Integration tests (PostgreSQL)

A first database integration test is implemented to validate real connectivity
between the API and PostgreSQL.

This test:
- relies on a real PostgreSQL instance
- exercises the `/health/db` endpoint
- validates that the application can establish a database connection at runtime

The test is conditionally executed:
- it runs only when the `DATABASE_URL` environment variable is set
- it is automatically skipped otherwise

This allows the same test suite to be executed:
- locally without a database
- in CI with a provisioned PostgreSQL service

---

## Test execution model

Tests are executed inside Docker containers rather than directly on the host
or CI runner.

This approach ensures:
- consistent Python and dependency versions
- reproducible test results
- alignment between local development and CI environments

The Dockerfile provides a dedicated `test` stage used for both linting and testing.

---

## Code quality gates

The CI pipeline enforces multiple quality gates:

- Static analysis using `ruff`
- Test execution using `pytest`
- Code coverage threshold enforcement

The pipeline fails if any of these conditions are not met.

---

## Coverage strategy

Code coverage is measured using `pytest-cov`.

A minimum coverage threshold is enforced to prevent regressions, while avoiding
over-optimization on coverage metrics.

Coverage is treated as a safety mechanism rather than a performance indicator.

---

## Future improvements

The testing strategy is designed to evolve incrementally.

Potential future improvements include:
- additional database integration tests
- schema or migration validation
- expanded endpoint-level integration coverage
