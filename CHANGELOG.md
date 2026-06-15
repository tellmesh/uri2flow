# Changelog

## [Unreleased]

## [0.1.2] - 2026-06-15

### Docs
- Update README.md

## [0.1.1] - 2026-06-15

### Docs
- Update README.md

### Test
- Update tests/conftest.py

### Other
- Update .gitignore
- Update contracts/agents/codex_nl_smoke_agent.yaml
- Update contracts/agents/codex_uri_smoke_agent.yaml
- Update uv.lock


## v0.8.2

- Added `markpact://` flow loader for compact URI flows in README.
- Added `uri2flow/loaders/markpact_loader.py`.
- Extended example `examples/22_markpact_weather/` with `markpact:flow`.
- Updated docs `docs/MARKPACT_WITH_TOURI.md`.

## v0.1.0

- Added compact URI flow parser.
- Added flow expander to full `workflow_graph`.
- Added default operation resolver for common schemes: `agent`, `hypervisor`, `browser`, `http`, `dom`, `screen`, `input`, `assertion`, `log`, `docker`.
- Added CLI: `validate`, `expand`, `print`.
- Added examples and tests.
