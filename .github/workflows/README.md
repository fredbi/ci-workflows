# CI workflows

## Shared workflows

All shared workflows are reusable (triggered via `workflow_call`) and designed to be called from other go-openapi repositories.

### Dependencies automation

* auto-merge.yml: auto-merge dependabot and go-openapi bot PRs, with dependency group rules

### Test automation

* go-test.yml: complete test pipeline with linting, unit tests, coverage reporting
* go-test-monorepo.yml: test pipeline for monorepo projects, runs tests across multiple modules with coverage aggregation
* fuzz-test.yml: orchestrates fuzz testing with matrix discovery, parallel execution, and corpus caching

* collect-coverage.yml: (common) collect & merge test coverage, upload to codecov
* collect-reports.yml: (common) collect & merge test reports, upload to codecov and GitHub

### Security

* codeql.yml: CodeQL security scanning for Go and GitHub Actions
* scanner.yml: vulnerability scanning with Trivy and govulncheck

### Release automation

* bump-release.yml: manually triggered workflow to bump version and create a GPG-signed tag
* bump-release-monorepo.yml: manually triggered workflow to bump version and tag all modules in a monorepo
* tag-release.yml: builds a GitHub release when a tag is pushed
* release.yml: (common) unified release and release notes build (single repo and monorepo)
* prepare-release-monorepo.yml: prepares monorepo releases by updating go.mod files and creating a bot PR

### Documentation

* contributors.yml: automatically updates CONTRIBUTORS.md
* markdown-changed.yml: lint and spellcheck on markdown documentation changes

## Test workflows

Local workflows that test the shared workflows within this repository. They serve as both tests and usage examples.

* local-auto-merge.yml
* local-bump-release.yml
* local-codeql.yml
* local-contributors.yml
* local-go-test.yml
* local-go-test-monorepo.yml
* local-release.yml
* local-scanner.yml
* local-tag-release.yml

## Configuration files

* `.cliff.toml` - release notes generation (git-cliff)
* `scripts/` - helper scripts used by workflows
