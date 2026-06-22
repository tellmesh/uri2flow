# uri2flow v0.1


## AI Cost Tracking

![PyPI](https://img.shields.io/badge/pypi-costs-blue) ![Version](https://img.shields.io/badge/version-0.1.8-blue) ![Python](https://img.shields.io/badge/python-3.9+-blue) ![License](https://img.shields.io/badge/license-Apache--2.0-green)
![AI Cost](https://img.shields.io/badge/AI%20Cost-$0.67-orange) ![Human Time](https://img.shields.io/badge/Human%20Time-8.2h-blue) ![Model](https://img.shields.io/badge/Model-openrouter%2Fqwen%2Fqwen3--coder--next-lightgrey)

- 🤖 **LLM usage:** $0.6749 (13 commits)
- 👤 **Human dev:** ~$824 (8.2h @ $100/h, 30min dedup)

Generated on 2026-06-22 using [openrouter/qwen/qwen3-coder-next](https://openrouter.ai/qwen/qwen3-coder-next)

---

`uri2flow` is a small compiler for compact URI flows.

It converts human/LLM-friendly YAML:

```yaml
flow:
  id: weather-agent-local-health

do:
  - agent://weather-generator
  - hypervisor://local/weather-agent/run
  - browser://chrome/page/open:
      url: http://localhost:8101/health
```

into an expanded `workflow_graph` manifest for `uri3`.

## Why this exists

Full workflow YAML is useful for machines, debugging and audit, but it is too verbose for humans and LLMs. The preferred input format should be URI-first and compact. `uri2flow` handles the expansion step.

## Role in the system

```text
nl2uri    -> natural language -> compact URI flow / URI graph
uri2flow  -> compact URI flow -> expanded workflow graph
uri3      -> validate, plan, route and execute graph
uri2ops   -> execute UI/OS/browser operations
hypervisor -> lifecycle, deployment, policy, registry
```

## Install

```bash
pip install -e .
```

## Commands

```bash
uri2flow validate examples/15_compact_uri_flow/weather.uri.flow.yaml
uri2flow expand examples/15_compact_uri_flow/weather.uri.flow.yaml --out output/weather.uri.graph.yaml
uri2flow print examples/15_compact_uri_flow/weather.uri.flow.yaml
```

## Example

See [`examples/15_compact_uri_flow`](examples/15_compact_uri_flow/README.md).

## Design rule

`uri2flow` does not execute anything. It only parses, normalizes and expands compact URI flows.

## Links

- [TODO](TODO.md) · [CHANGELOG](CHANGELOG.md)
- [nl2uri](../nl2uri) · [uri3](../uri3)
- Org status: [`../TODO_STATUS.md`](../TODO_STATUS.md)


## License

Licensed under Apache-2.0.
