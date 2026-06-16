# TODO — uri2flow

**Version:** 0.1.2 · **Role:** compact `*.uri.flow.yaml` → workflow graph for uri3/nl2uri

> Audyt kod vs lista: 2026-06-16

## Zrobione (w kodzie, część nie była w starej liście)

- [x] Parser compact flow (`do` / `steps`, string URI, dict steps, `if`/`after`)
- [x] Expander → `nl2uri` + `graph.nodes` (`uri2flow/expander.py`)
- [x] CLI: `validate`, `expand`, `print` (`uri2flow/cli.py`)
- [x] Config resolver z `config/flow_defaults.uri.yaml` (scheme/pattern/fallback)
- [x] Markpact loader (`markpact://…#fragment` via uri2pact)
- [x] Walidacja rozszerzonego grafu przez uri3 (`validate_expanded_flow`)
- [x] Branching podstawowy (`id`, `after`, `if`) + testy
- [x] **`uri3 expand-flow`** — zrealizowane w paczce **uri3** (`uri3/cli/commands/flow.py`)
- [x] **`nl2uri flow -p …`** — zrealizowane w paczce **nl2uri** (`nl2uri/cli.py`)

## Otwarte (scope uri2flow)

- [ ] Podłączyć resolver operacji do rejestru uri3/uri2ops (zamiast tylko `flow_defaults.uri.yaml`)
- [ ] Walidacja JSON Schema (`uri_flow.schema.json` istnieje; brak `jsonschema` w validatorze)
- [ ] Opcjonalny extra `[jsonschema]` i użycie w `validate_flow_document`
- [ ] Normalizacja warunków bool (AND/OR/NOT) + dedykowane testy
- [ ] Jawna składnia `group` / `parallel` (dziś tylko implicit fan-out przez wspólne `after`)

## Cross-package (nie duplikować tutaj)

| Item | Gdzie jest |
|------|------------|
| `uri3 expand-flow` / `run-flow` | `uri3` |
| `nl2uri flow --expand` | `nl2uri` |
| Wykonanie operatora browser | `uri2ops` |
