# ci-workflows

<!-- Badges: status  -->
[![Tests][test-badge]][test-url] [![Coverage][cov-badge]][cov-url] [![CI vuln scan][vuln-scan-badge]][vuln-scan-url] [![CodeQL][codeql-badge]][codeql-url]
<!-- Badges: release & docker images  -->
<!-- Badges: code quality  -->
[![Release][release-badge]][release-url] [![Go Report Card][gocard-badge]][gocard-url] [![CodeFactor Grade][codefactor-badge]][codefactor-url] [![License][license-badge]][license-url]
<!-- Badges: documentation & support -->
<!-- Badges: others & stats -->
[![GoDoc][godoc-badge]][godoc-url] [![Discord Channel][discord-badge]][discord-url] [![go version][goversion-badge]][goversion-url] ![Top language][top-badge] ![Commits since latest release][commits-badge]

---

Shared, reusable GitHub Actions workflows that standardize CI/CD across the [go-openapi](https://github.com/go-openapi) family of repositories.

**One workflow call** replaces hundreds of lines of per-repo CI configuration, with built-in linting, testing,
fuzz testing, security scanning, release automation, and more.

## Announcements

* **2025-12-19** : new community chat on discord
  * a new discord community channel is available to be notified of changes and support users
  * our venerable Slack channel remains open, and will be eventually discontinued on **2026-03-31**

You may join the discord community by clicking the invite link on the discord badge (also above). [![Discord Channel][discord-badge]][discord-url]

Or join our Slack channel: [![Slack Channel][slack-logo]![slack-badge]][slack-url]

## What you get

| Area | Workflows | Highlights |
|------|-----------|------------|
| **Testing** | `go-test.yml`, `go-test-monorepo.yml` | Lint, unit tests, fuzz tests, coverage & test reports |
| **Security** | `codeql.yml`, `scanner.yml` | CodeQL analysis, Trivy, govulncheck |
| **Releases** | `bump-release.yml`, `tag-release.yml`, `release.yml` | GPG-signed tags, git-cliff release notes |
| **Monorepo releases** | `bump-release-monorepo.yml`, `prepare-release-monorepo.yml` | Multi-module version bumps, go.mod updates |
| **Dependencies** | `auto-merge.yml` | Auto-approve & merge dependabot and bot PRs |
| **Documentation** | `contributors.yml`, `markdown-changed.yml` | CONTRIBUTORS.md updates, markdown lint & spellcheck |

See the full [workflow reference](.github/workflows/README.md) for details on each workflow.

## Quick start

Call a shared workflow from your repository:

```yaml
name: go test

permissions:
  pull-requests: read
  contents: read

on:
  push:
    branches: [ master ]
  pull_request:

jobs:
  test:
    uses: go-openapi/ci-workflows/.github/workflows/go-test.yml@master
    secrets: inherit
```

**Recommended:** pin to a commit SHA and let dependabot keep you up to date:

```yaml
    uses: go-openapi/ci-workflows/.github/workflows/go-test.yml@b28a8b978a5ee5b7f4241ffafd6cc6163edb5dfd # v0.1.0
```

### Permissions

Grant job-level permissions that match the requirements of the called workflow:

```yaml
name: "CodeQL"

on:
  push:
    branches: [ "master" ]
  pull_request:
    branches: [ "master" ]
    paths-ignore: # remove this clause if CodeQL is a required check
      - '**/*.md'
  schedule:
    - cron: '39 19 * * 5'

permissions:
  contents: read

jobs:
  codeql:
    permissions:
      contents: read
      security-events: write
    uses: ./.github/workflows/codeql.yml
    secrets: inherit
```

## Example: `go-test.yml` pipeline

![go-test workflow](./docs/images/go-test.png)

A single workflow call orchestrates linting, unit tests across Go versions, fuzz testing with corpus caching, and automatic coverage and test report collection.

## Motivation

It took a while (well something like 10 years...), but we eventually managed to align all checks, tests and
dependabot rules declared in the family of go-openapi repos.

Now we'd like to be able to maintain, enrich and improve these checks without
worrying too much about the burden of replicating the stuff about a dozen times.

## Change log

See <https://github.com/go-openapi/ci-workflows/releases>

## Licensing

This content ships under the [SPDX-License-Identifier: Apache-2.0](./LICENSE).

## Other documentation

* [Workflow reference](.github/workflows/README.md)
* [All-time contributors](./CONTRIBUTORS.md)
* [Contributing guidelines](.github/CONTRIBUTING.md)
* [Maintainers documentation](docs/MAINTAINERS.md)
* [Code style](docs/STYLE.md)
* [Roadmap](docs/ROADMAP.md)

## Cutting a new release

Maintainers can cut a new release by either:

* running [this workflow](https://github.com/go-openapi/ci-workflows/actions/workflows/local-bump-release.yml)
* or pushing a semver tag
  * signed tags are preferred
  * The tag message is prepended to release notes

<!-- Badges: status  -->
[test-badge]: https://github.com/go-openapi/ci-workflows/actions/workflows/local-go-test.yml/badge.svg
[test-url]: https://github.com/go-openapi/ci-workflows/actions/workflows/local-go-test.yml
[cov-badge]: https://codecov.io/gh/go-openapi/ci-workflows/branch/master/graph/badge.svg
[cov-url]: https://codecov.io/gh/go-openapi/ci-workflows
[vuln-scan-badge]: https://github.com/go-openapi/ci-workflows/actions/workflows/local-scanner.yml/badge.svg
[vuln-scan-url]: https://github.com/go-openapi/ci-workflows/actions/workflows/local-scanner.yml
[codeql-badge]: https://github.com/go-openapi/ci-workflows/actions/workflows/local-codeql.yml/badge.svg
[codeql-url]: https://github.com/go-openapi/ci-workflows/actions/workflows/local-codeql.yml
<!-- Badges: release & docker images  -->
[release-badge]: https://badge.fury.io/gh/go-openapi%2Fci-workflows.svg
[release-url]: https://badge.fury.io/gh/go-openapi%2Fci-workflows
[gomod-badge]: https://badge.fury.io/go/github.com%2Fgo-openapi%2Fci-workflows.svg
[gomod-url]: https://badge.fury.io/go/github.com%2Fgo-openapi%2Fci-workflows
<!-- Badges: code quality  -->
[gocard-badge]: https://goreportcard.com/badge/github.com/go-openapi/ci-workflows
[gocard-url]: https://goreportcard.com/report/github.com/go-openapi/ci-workflows
[codefactor-badge]: https://img.shields.io/codefactor/grade/github/go-openapi/ci-workflows
[codefactor-url]: https://www.codefactor.io/repository/github/go-openapi/ci-workflows
<!-- Badges: documentation & support -->
[doc-badge]: https://img.shields.io/badge/doc-site-blue?link=https%3A%2F%2Fgoswagger.io%2Fgo-openapi%2F
[doc-url]: https://goswagger.io/go-openapi
[godoc-badge]: https://pkg.go.dev/badge/github.com/go-openapi/ci-workflows
[godoc-url]: http://pkg.go.dev/github.com/go-openapi/ci-workflows
[slack-logo]: https://a.slack-edge.com/e6a93c1/img/icons/favicon-32.png
[slack-badge]: https://img.shields.io/badge/slack-blue?link=https%3A%2F%2Fgoswagger.slack.com%2Farchives%2FC04R30YM
[slack-url]: https://goswagger.slack.com/archives/C04R30YMU
[discord-badge]: https://img.shields.io/discord/1446918742398341256?logo=discord&label=discord&color=blue
[discord-url]: https://discord.gg/twZ9BwT3
<!-- Badges: license & compliance -->
[license-badge]: http://img.shields.io/badge/license-Apache%20v2-orange.svg
[license-url]: https://github.com/go-openapi/ci-workflows/?tab=Apache-2.0-1-ov-file#readme
<!-- Badges: others & stats -->
[goversion-badge]: https://img.shields.io/github/go-mod/go-version/go-openapi/ci-workflows
[goversion-url]: https://github.com/go-openapi/ci-workflows/blob/master/go.mod
[top-badge]: https://img.shields.io/github/languages/top/go-openapi/ci-workflows
[commits-badge]: https://img.shields.io/github/commits-since/go-openapi/ci-workflows/latest
