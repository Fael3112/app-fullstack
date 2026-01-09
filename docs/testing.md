# Testing strategy

This repository implements a pragmatic testing strategy focused on CI reliability
and production readiness rather than extensive business logic coverage.

The goal is to ensure that the application can be built, tested and packaged
consistently across local and CI environments.

---

## Types of tests

### Unit tests

Unit tests validate the application logic in isolation.

They focus on:
- API endpoints behaviour
- application startup
- basic response validation

Unit tests are executed using `pytest` and do not require external services.

---

### Integration-ready tests

The test environment is designed to support integration testing with PostgreSQL.

During CI runs:
- a real PostgreSQL instance is provisioned
- the application receives its database configuration via `DATABASE_URL`
- tests are executed inside Docker, ensuring consistent environments

At this stage, the database is made available to the test suite, but integration
tests are intentionally minimal.

This design allows future integration tests to be added without changing the
CI pipeline or application configuration.

---

## Test execution model

Tests are executed inside Docker containers rather than directly on the CI runner.

This approach ensures:
- consistent Python and dependency versions
- identical behaviour between local development and CI
- reproducible failures

The Dockerfile provides a dedicated `test` stage that includes all tools required
for linting and testing.

---

## Code quality gates

The CI pipeline enforces several quality gates:

- Static analysis using `ruff`
- Test execution using `pytest`
- Code coverage threshold enforcement

The pipeline fails if any of these conditions are not met.

---

## Coverage strategy

Code coverage is measured using `pytest-cov`.

A minimum coverage threshold is enforced to prevent regressions, while avoiding
over-optimization on coverage metrics.

Coverage is used as a safety net rather than a performance indicator.

---

## Future improvements

The testing strategy is intentionally designed to evolve.

Planned improvements include:
- explicit database integration tests
- validation of `/health/db` endpoint behaviour
- expanded integration coverage as application complexity grows

No structural changes to the CI pipeline will be required to support these additions.
