# uri2flow v0.1

SUMD - Structured Unified Markdown Descriptor for AI-aware project refactorization

## Contents

- [Metadata](#metadata)
- [Architecture](#architecture)
- [Dependencies](#dependencies)
- [Source Map](#source-map)
- [Call Graph](#call-graph)
- [Test Contracts](#test-contracts)
- [Refactoring Analysis](#refactoring-analysis)
- [Intent](#intent)

## Metadata

- **name**: `uri2flow`
- **version**: `0.1.2`
- **python_requires**: `>=3.10`
- **license**: Apache-2.0
- **ai_model**: `openrouter/qwen/qwen3-coder-next`
- **ecosystem**: SUMD + DOQL + testql + taskfile
- **generated_from**: pyproject.toml, testql(2), app.doql.less, goal.yaml, .env.example, src(7 mod), project/(5 analysis files)

## Architecture

```
SUMD (description) → DOQL/source (code) → taskfile (automation) → testql (verification)
```

### DOQL Application Declaration (`app.doql.less`)

```less markpact:doql path=app.doql.less
// LESS format — define @variables here as needed

app {
  name: uri2flow;
  version: 0.1.2;
}

dependencies {
  runtime: "PyYAML>=6.0, uri2pact, uri2ops, uri3";
  dev: "pytest>=8.0, goal>=2.1.0, costs>=0.1.20, pfix>=0.1.60";
  test: pytest>=8.0;
  jsonschema: jsonschema>=4.0;
}

interface[type="cli"] {
  framework: argparse;
}
interface[type="cli"] page[name="uri2flow"] {
  entry: uri2flow.cli:main;
}

env_vars {
  keys: OPENROUTER_API_KEY, LLM_MODEL, PFIX_AUTO_APPLY, PFIX_AUTO_INSTALL_DEPS, PFIX_AUTO_RESTART, PFIX_MAX_RETRIES, PFIX_DRY_RUN, PFIX_ENABLED, PFIX_GIT_COMMIT, PFIX_GIT_PREFIX, PFIX_CREATE_BACKUPS;
}

deploy {
  target: pip;
}

environment[name="local"] {
  runtime: python;
  env_file: .env;
  template_file: .env.example;
  python_version: >=3.10;
  vars: LLM_MODEL, OPENROUTER_API_KEY, PFIX_AUTO_APPLY, PFIX_AUTO_INSTALL_DEPS, PFIX_AUTO_RESTART, PFIX_CREATE_BACKUPS, PFIX_DRY_RUN, PFIX_ENABLED, PFIX_GIT_COMMIT, PFIX_GIT_PREFIX, PFIX_MAX_RETRIES;
  runtime_llm: OPENROUTER_API_KEY;
  runtime_pfix: PFIX_AUTO_APPLY, PFIX_AUTO_INSTALL_DEPS, PFIX_AUTO_RESTART, PFIX_CREATE_BACKUPS, PFIX_DRY_RUN, PFIX_ENABLED, PFIX_GIT_COMMIT, PFIX_GIT_PREFIX, PFIX_MAX_RETRIES;
}
```

### Source Modules

- `uri2flow.cli`
- `uri2flow.expander`
- `uri2flow.models`
- `uri2flow.parser`
- `uri2flow.resolver`
- `uri2flow.utils`
- `uri2flow.validator`

## Dependencies

### Runtime

```text markpact:deps python
PyYAML>=6.0
uri2pact
uri2ops
uri3
```

### Development

```text markpact:deps python scope=dev
pytest>=8.0
goal>=2.1.0
costs>=0.1.20
pfix>=0.1.60
```

## Source Map

*Top 5 modules by symbol density — signatures for LLM orientation.*

### `uri2flow.resolver` (`uri2flow/resolver.py`)

```python
def _find_repo_root(start)  # CC=9, fan=10
def _pattern_to_regex(pattern)  # CC=4, fan=7
def _match_pattern(pattern, uri)  # CC=2, fan=3
def _load_flow_defaults_config()  # CC=4, fan=7
def _defaults_from_entry(entry)  # CC=3, fan=4
def _defaults_from_scheme(scheme)  # CC=3, fan=4
def _defaults_from_patterns(uri)  # CC=7, fan=6
def _fallback_defaults()  # CC=4, fan=5
def default_operation_for_uri(uri)  # CC=3, fan=4
def clear_defaults_cache()  # CC=1, fan=1
class OperationDefaults:
```

### `uri2flow.cli` (`uri2flow/cli.py`)

```python
def cmd_validate(args)  # CC=2, fan=4
def cmd_expand(args)  # CC=3, fan=7
def cmd_print(args)  # CC=1, fan=4
def build_parser()  # CC=1, fan=5
def main(argv)  # CC=1, fan=3
```

### `uri2flow.expander` (`uri2flow/expander.py`)

```python
def _node_from_step(step, previous_id, used)  # CC=11, fan=3 ⚠
def _edges_from_depends(nodes)  # CC=4, fan=2
def expand_flow(flow)  # CC=6, fan=7
def dump_yaml(data)  # CC=1, fan=1
```

### `uri2flow.parser` (`uri2flow/parser.py`)

```python
def _as_list(value)  # CC=5, fan=4
def _parse_step(raw)  # CC=10, fan=11 ⚠
def parse_flow(data)  # CC=12, fan=7 ⚠
def load_flow(path)  # CC=4, fan=8
class FlowParseError:
```

### `uri2flow.utils` (`uri2flow/utils.py`)

```python
def slugify(value)  # CC=2, fan=3
def scheme_of(uri)  # CC=1, fan=1
def path_parts(uri)  # CC=4, fan=4
def node_id_from_uri(uri, used)  # CC=5, fan=7
```

## Call Graph

*29 nodes · 35 edges · 6 modules · CC̄=4.7*

### Hubs (by degree)

| Function | CC | in | out | total |
|----------|----|----|-----|-------|
| `_parse_step` *(in uri2flow.parser)* | 10 ⚠ | 1 | 29 | **30** |
| `_find_repo_root` *(in uri2flow.resolver)* | 9 | 1 | 19 | **20** |
| `parse_flow` *(in uri2flow.parser)* | 12 ⚠ | 3 | 16 | **19** |
| `build_parser` *(in uri2flow.cli)* | 1 | 1 | 14 | **15** |
| `validate_flow_document` *(in uri2flow.validator)* | 10 ⚠ | 2 | 9 | **11** |
| `load_flow` *(in uri2flow.parser)* | 4 | 3 | 8 | **11** |
| `expand_flow` *(in uri2flow.expander)* | 6 | 2 | 8 | **10** |
| `_load_flow_defaults_config` *(in uri2flow.resolver)* | 4 | 3 | 7 | **10** |

```toon markpact:analysis path=project/calls.toon.yaml
# code2llm call graph | /home/tom/github/tellmesh/uri2flow
# generated in 0.02s
# nodes: 29 | edges: 35 | modules: 6
# CC̄=4.7

HUBS[20]:
  uri2flow.parser._parse_step
    CC=10  in:1  out:29  total:30
  uri2flow.resolver._find_repo_root
    CC=9  in:1  out:19  total:20
  uri2flow.parser.parse_flow
    CC=12  in:3  out:16  total:19
  uri2flow.cli.build_parser
    CC=1  in:1  out:14  total:15
  uri2flow.validator.validate_flow_document
    CC=10  in:2  out:9  total:11
  uri2flow.parser.load_flow
    CC=4  in:3  out:8  total:11
  uri2flow.expander.expand_flow
    CC=6  in:2  out:8  total:10
  uri2flow.resolver._load_flow_defaults_config
    CC=4  in:3  out:7  total:10
  uri2flow.resolver._defaults_from_entry
    CC=3  in:3  out:7  total:10
  uri2flow.resolver._pattern_to_regex
    CC=4  in:1  out:8  total:9
  uri2flow.cli.cmd_expand
    CC=3  in:0  out:8  total:8
  uri2flow.utils.node_id_from_uri
    CC=5  in:1  out:7  total:8
  uri2flow.resolver._defaults_from_patterns
    CC=7  in:1  out:7  total:8
  uri2flow.resolver._defaults_from_scheme
    CC=3  in:1  out:5  total:6
  uri2flow.parser._as_list
    CC=5  in:1  out:5  total:6
  uri2flow.resolver._fallback_defaults
    CC=4  in:1  out:5  total:6
  uri2flow.utils.slugify
    CC=2  in:2  out:4  total:6
  uri2flow.validator.validate_flow
    CC=11  in:1  out:5  total:6
  uri2flow.validator.validate_expanded_flow
    CC=2  in:0  out:5  total:5
  uri2flow.utils.path_parts
    CC=4  in:1  out:4  total:5

MODULES:
  uri2flow.cli  [5 funcs]
    build_parser  CC=1  out:14
    cmd_expand  CC=3  out:8
    cmd_print  CC=1  out:4
    cmd_validate  CC=2  out:4
    main  CC=1  out:3
  uri2flow.expander  [4 funcs]
    _edges_from_depends  CC=4  out:2
    _node_from_step  CC=11  out:3
    dump_yaml  CC=1  out:1
    expand_flow  CC=6  out:8
  uri2flow.parser  [4 funcs]
    _as_list  CC=5  out:5
    _parse_step  CC=10  out:29
    load_flow  CC=4  out:8
    parse_flow  CC=12  out:16
  uri2flow.resolver  [9 funcs]
    _defaults_from_entry  CC=3  out:7
    _defaults_from_patterns  CC=7  out:7
    _defaults_from_scheme  CC=3  out:5
    _fallback_defaults  CC=4  out:5
    _find_repo_root  CC=9  out:19
    _load_flow_defaults_config  CC=4  out:7
    _match_pattern  CC=2  out:3
    _pattern_to_regex  CC=4  out:8
    default_operation_for_uri  CC=3  out:4
  uri2flow.utils  [4 funcs]
    node_id_from_uri  CC=5  out:7
    path_parts  CC=4  out:4
    scheme_of  CC=1  out:1
    slugify  CC=2  out:4
  uri2flow.validator  [3 funcs]
    validate_expanded_flow  CC=2  out:5
    validate_flow  CC=11  out:5
    validate_flow_document  CC=10  out:9

EDGES:
  uri2flow.validator.validate_flow_document → uri2flow.parser.parse_flow
  uri2flow.validator.validate_expanded_flow → uri2flow.validator.validate_flow_document
  uri2flow.validator.validate_expanded_flow → uri2flow.expander.expand_flow
  uri2flow.validator.validate_flow → uri2flow.parser.load_flow
  uri2flow.validator.validate_flow → uri2flow.validator.validate_flow_document
  uri2flow.cli.cmd_validate → uri2flow.validator.validate_flow
  uri2flow.cli.cmd_validate → uri2flow.expander.dump_yaml
  uri2flow.cli.cmd_expand → uri2flow.expander.expand_flow
  uri2flow.cli.cmd_expand → uri2flow.expander.dump_yaml
  uri2flow.cli.cmd_print → uri2flow.parser.load_flow
  uri2flow.cli.cmd_print → uri2flow.expander.dump_yaml
  uri2flow.cli.main → uri2flow.cli.build_parser
  uri2flow.expander._node_from_step → uri2flow.resolver.default_operation_for_uri
  uri2flow.expander._node_from_step → uri2flow.utils.node_id_from_uri
  uri2flow.expander.expand_flow → uri2flow.parser.load_flow
  uri2flow.expander.expand_flow → uri2flow.expander._node_from_step
  uri2flow.expander.expand_flow → uri2flow.expander._edges_from_depends
  uri2flow.expander.expand_flow → uri2flow.parser.parse_flow
  uri2flow.parser._parse_step → uri2flow.parser._as_list
  uri2flow.parser.load_flow → uri2flow.parser.parse_flow
  uri2flow.utils.node_id_from_uri → uri2flow.utils.path_parts
  uri2flow.utils.node_id_from_uri → uri2flow.utils.scheme_of
  uri2flow.utils.node_id_from_uri → uri2flow.utils.slugify
  uri2flow.resolver._match_pattern → uri2flow.resolver._pattern_to_regex
  uri2flow.resolver._load_flow_defaults_config → uri2flow.resolver._find_repo_root
  uri2flow.resolver._defaults_from_scheme → uri2flow.resolver._defaults_from_entry
  uri2flow.resolver._defaults_from_scheme → uri2flow.resolver._load_flow_defaults_config
  uri2flow.resolver._defaults_from_patterns → uri2flow.resolver._match_pattern
  uri2flow.resolver._defaults_from_patterns → uri2flow.resolver._defaults_from_entry
  uri2flow.resolver._defaults_from_patterns → uri2flow.resolver._load_flow_defaults_config
  uri2flow.resolver._fallback_defaults → uri2flow.resolver._defaults_from_entry
  uri2flow.resolver._fallback_defaults → uri2flow.resolver._load_flow_defaults_config
  uri2flow.resolver.default_operation_for_uri → uri2flow.resolver._defaults_from_patterns
  uri2flow.resolver.default_operation_for_uri → uri2flow.resolver._defaults_from_scheme
  uri2flow.resolver.default_operation_for_uri → uri2flow.resolver._fallback_defaults
```

## Test Contracts

*Scenarios as contract signatures — what the system guarantees.*

### Cli (1)

**`CLI Command Tests`**

### Integration (1)

**`Auto-generated from Python Tests`**

## Refactoring Analysis

*Pre-refactoring snapshot — use this section to identify targets. Generated from `project/` toon files.*

### Call Graph & Complexity (`project/calls.toon.yaml`)

```toon markpact:analysis path=project/calls.toon.yaml
# code2llm call graph | /home/tom/github/tellmesh/uri2flow
# generated in 0.02s
# nodes: 29 | edges: 35 | modules: 6
# CC̄=4.7

HUBS[20]:
  uri2flow.parser._parse_step
    CC=10  in:1  out:29  total:30
  uri2flow.resolver._find_repo_root
    CC=9  in:1  out:19  total:20
  uri2flow.parser.parse_flow
    CC=12  in:3  out:16  total:19
  uri2flow.cli.build_parser
    CC=1  in:1  out:14  total:15
  uri2flow.validator.validate_flow_document
    CC=10  in:2  out:9  total:11
  uri2flow.parser.load_flow
    CC=4  in:3  out:8  total:11
  uri2flow.expander.expand_flow
    CC=6  in:2  out:8  total:10
  uri2flow.resolver._load_flow_defaults_config
    CC=4  in:3  out:7  total:10
  uri2flow.resolver._defaults_from_entry
    CC=3  in:3  out:7  total:10
  uri2flow.resolver._pattern_to_regex
    CC=4  in:1  out:8  total:9
  uri2flow.cli.cmd_expand
    CC=3  in:0  out:8  total:8
  uri2flow.utils.node_id_from_uri
    CC=5  in:1  out:7  total:8
  uri2flow.resolver._defaults_from_patterns
    CC=7  in:1  out:7  total:8
  uri2flow.resolver._defaults_from_scheme
    CC=3  in:1  out:5  total:6
  uri2flow.parser._as_list
    CC=5  in:1  out:5  total:6
  uri2flow.resolver._fallback_defaults
    CC=4  in:1  out:5  total:6
  uri2flow.utils.slugify
    CC=2  in:2  out:4  total:6
  uri2flow.validator.validate_flow
    CC=11  in:1  out:5  total:6
  uri2flow.validator.validate_expanded_flow
    CC=2  in:0  out:5  total:5
  uri2flow.utils.path_parts
    CC=4  in:1  out:4  total:5

MODULES:
  uri2flow.cli  [5 funcs]
    build_parser  CC=1  out:14
    cmd_expand  CC=3  out:8
    cmd_print  CC=1  out:4
    cmd_validate  CC=2  out:4
    main  CC=1  out:3
  uri2flow.expander  [4 funcs]
    _edges_from_depends  CC=4  out:2
    _node_from_step  CC=11  out:3
    dump_yaml  CC=1  out:1
    expand_flow  CC=6  out:8
  uri2flow.parser  [4 funcs]
    _as_list  CC=5  out:5
    _parse_step  CC=10  out:29
    load_flow  CC=4  out:8
    parse_flow  CC=12  out:16
  uri2flow.resolver  [9 funcs]
    _defaults_from_entry  CC=3  out:7
    _defaults_from_patterns  CC=7  out:7
    _defaults_from_scheme  CC=3  out:5
    _fallback_defaults  CC=4  out:5
    _find_repo_root  CC=9  out:19
    _load_flow_defaults_config  CC=4  out:7
    _match_pattern  CC=2  out:3
    _pattern_to_regex  CC=4  out:8
    default_operation_for_uri  CC=3  out:4
  uri2flow.utils  [4 funcs]
    node_id_from_uri  CC=5  out:7
    path_parts  CC=4  out:4
    scheme_of  CC=1  out:1
    slugify  CC=2  out:4
  uri2flow.validator  [3 funcs]
    validate_expanded_flow  CC=2  out:5
    validate_flow  CC=11  out:5
    validate_flow_document  CC=10  out:9

EDGES:
  uri2flow.validator.validate_flow_document → uri2flow.parser.parse_flow
  uri2flow.validator.validate_expanded_flow → uri2flow.validator.validate_flow_document
  uri2flow.validator.validate_expanded_flow → uri2flow.expander.expand_flow
  uri2flow.validator.validate_flow → uri2flow.parser.load_flow
  uri2flow.validator.validate_flow → uri2flow.validator.validate_flow_document
  uri2flow.cli.cmd_validate → uri2flow.validator.validate_flow
  uri2flow.cli.cmd_validate → uri2flow.expander.dump_yaml
  uri2flow.cli.cmd_expand → uri2flow.expander.expand_flow
  uri2flow.cli.cmd_expand → uri2flow.expander.dump_yaml
  uri2flow.cli.cmd_print → uri2flow.parser.load_flow
  uri2flow.cli.cmd_print → uri2flow.expander.dump_yaml
  uri2flow.cli.main → uri2flow.cli.build_parser
  uri2flow.expander._node_from_step → uri2flow.resolver.default_operation_for_uri
  uri2flow.expander._node_from_step → uri2flow.utils.node_id_from_uri
  uri2flow.expander.expand_flow → uri2flow.parser.load_flow
  uri2flow.expander.expand_flow → uri2flow.expander._node_from_step
  uri2flow.expander.expand_flow → uri2flow.expander._edges_from_depends
  uri2flow.expander.expand_flow → uri2flow.parser.parse_flow
  uri2flow.parser._parse_step → uri2flow.parser._as_list
  uri2flow.parser.load_flow → uri2flow.parser.parse_flow
  uri2flow.utils.node_id_from_uri → uri2flow.utils.path_parts
  uri2flow.utils.node_id_from_uri → uri2flow.utils.scheme_of
  uri2flow.utils.node_id_from_uri → uri2flow.utils.slugify
  uri2flow.resolver._match_pattern → uri2flow.resolver._pattern_to_regex
  uri2flow.resolver._load_flow_defaults_config → uri2flow.resolver._find_repo_root
  uri2flow.resolver._defaults_from_scheme → uri2flow.resolver._defaults_from_entry
  uri2flow.resolver._defaults_from_scheme → uri2flow.resolver._load_flow_defaults_config
  uri2flow.resolver._defaults_from_patterns → uri2flow.resolver._match_pattern
  uri2flow.resolver._defaults_from_patterns → uri2flow.resolver._defaults_from_entry
  uri2flow.resolver._defaults_from_patterns → uri2flow.resolver._load_flow_defaults_config
  uri2flow.resolver._fallback_defaults → uri2flow.resolver._defaults_from_entry
  uri2flow.resolver._fallback_defaults → uri2flow.resolver._load_flow_defaults_config
  uri2flow.resolver.default_operation_for_uri → uri2flow.resolver._defaults_from_patterns
  uri2flow.resolver.default_operation_for_uri → uri2flow.resolver._defaults_from_scheme
  uri2flow.resolver.default_operation_for_uri → uri2flow.resolver._fallback_defaults
```

### Code Analysis (`project/analysis.toon.yaml`)

```toon markpact:analysis path=project/analysis.toon.yaml
# code2llm | 30f 1805L | yaml:15,python:10,shell:3,toml:1,json:1 | 2026-06-21
# generated in 0.01s
# CC̅=4.7 | critical:0/31 | dups:0 | cycles:0

HEALTH[0]: ok

REFACTOR[0]: none needed

PIPELINES[7]:
  [1] Src [validate_expanded_flow]: validate_expanded_flow → validate_flow_document → parse_flow → _parse_step → ...(1 more)
      PURITY: 100% pure
  [2] Src [cmd_validate]: cmd_validate → validate_flow → load_flow → parse_flow → ...(2 more)
      PURITY: 100% pure
  [3] Src [cmd_expand]: cmd_expand → expand_flow → load_flow → parse_flow → ...(2 more)
      PURITY: 100% pure
  [4] Src [cmd_print]: cmd_print → load_flow → parse_flow → _parse_step → ...(1 more)
      PURITY: 100% pure
  [5] Src [main]: main → build_parser
      PURITY: 100% pure
  [6] Src [to_dict]: to_dict
      PURITY: 100% pure
  [7] Src [clear_defaults_cache]: clear_defaults_cache
      PURITY: 100% pure

LAYERS:
  uri2flow/                       CC̄=4.7    ←in:0  →out:0
  │ resolver                   127L  1C   10m  CC=9      ←1
  │ parser                      99L  1C    4m  CC=12     ←3
  │ expander                    81L  0C    4m  CC=11     ←2
  │ cli                         75L  0C    5m  CC=3      ←0
  │ validator                   64L  0C    3m  CC=11     ←1
  │ models                      47L  2C    1m  CC=11     ←0
  │ uri_flow.schema.json        40L  0C    0m  CC=0.0    ←0
  │ utils                       38L  0C    4m  CC=5      ←2
  │ markpact_loader             23L  0C    0m  CC=0.0    ←0
  │ __init__                    19L  0C    0m  CC=0.0    ←0
  │ __init__                    16L  0C    0m  CC=0.0    ←0
  │
  ./                              CC̄=0.0    ←in:0  →out:0
  │ !! goal.yaml                  525L  0C    0m  CC=0.0    ←0
  │ pyproject.toml              68L  0C    0m  CC=0.0    ←0
  │ project.sh                  59L  0C    0m  CC=0.0    ←0
  │ tree.sh                      1L  0C    0m  CC=0.0    ←0
  │
  examples/                       CC̄=0.0    ←in:0  →out:0
  │ run.sh                      41L  0C    0m  CC=0.0    ←0
  │ bank_batch_transfer.yaml    28L  0C    0m  CC=0.0    ←0
  │ portal_zus_form.yaml        28L  0C    0m  CC=0.0    ←0
  │ supplier_report_monthly.yaml    28L  0C    0m  CC=0.0    ←0
  │
  contracts/                      CC̄=0.0    ←in:0  →out:0
  │ hypervisor_dashboard_agent.yaml    55L  0C    0m  CC=0.0    ←0
  │ remote_deploy_agent.yaml    53L  0C    0m  CC=0.0    ←0
  │ screenshot_analysis_agent.yaml    42L  0C    0m  CC=0.0    ←0
  │ user_agent.yaml             38L  0C    0m  CC=0.0    ←0
  │ schema_collab_agent.yaml    36L  0C    0m  CC=0.0    ←0
  │ gnome_programmer_agent.yaml    35L  0C    0m  CC=0.0    ←0
  │ codex_uri_smoke_agent.yaml    30L  0C    0m  CC=0.0    ←0
  │ codex_nl_plan_agent.yaml    30L  0C    0m  CC=0.0    ←0
  │ codex_nl_smoke_agent.yaml    29L  0C    0m  CC=0.0    ←0
  │ invoices_agent.yaml         28L  0C    0m  CC=0.0    ←0
  │ weather_map_agent.yaml      22L  0C    0m  CC=0.0    ←0
  │

COUPLING: no cross-package imports detected

EXTERNAL:
  validation: run `vallm batch .` → validation.toon
  duplication: run `redup scan .` → duplication.toon
```

### Duplication (`project/duplication.toon.yaml`)

```toon markpact:analysis path=project/duplication.toon.yaml
# redup/duplication | 0 groups | 10f 589L | 2026-06-21

SUMMARY:
  files_scanned: 10
  total_lines:   589
  dup_groups:    0
  dup_fragments: 0
  saved_lines:   0
  scan_ms:       2995
```

### Evolution / Churn (`project/evolution.toon.yaml`)

```toon markpact:analysis path=project/evolution.toon.yaml
# code2llm/evolution | 31 func | 7f | 2026-06-21
# generated in 0.00s

NEXT[1] (ranked by impact):
  [1] !! SPLIT           goal.yaml
      WHY: 525L, 0 classes, max CC=0
      EFFORT: ~4h  IMPACT: 0


RISKS[1]:
  ⚠ Splitting goal.yaml may break 0 import paths

METRICS-TARGET:
  CC̄:          4.7 → ≤3.3
  max-CC:      12 → ≤6
  god-modules: 1 → 0
  high-CC(≥15): 0 → ≤0
  hub-types:   0 → ≤0

PATTERNS (language parser shared logic):
  _extract_declarations() in base.py — unified extraction for:
    - TypeScript: interfaces, types, classes, functions, arrow funcs
    - PHP: namespaces, traits, classes, functions, includes
    - Ruby: modules, classes, methods, requires
    - C++: classes, structs, functions, #includes
    - C#: classes, interfaces, methods, usings
    - Java: classes, interfaces, methods, imports
    - Go: packages, functions, structs
    - Rust: modules, functions, traits, use statements

  Shared regex patterns per language:
    - import: language-specific import/require/using patterns
    - class: class/struct/trait declarations with inheritance
    - function: function/method signatures with visibility
    - brace_tracking: for C-family languages ({ })
    - end_keyword_tracking: for Ruby (module/class/def...end)

  Benefits:
    - Consistent extraction logic across all languages
    - Reduced code duplication (~70% reduction in parser LOC)
    - Easier maintenance: fix once, apply everywhere
    - Standardized FunctionInfo/ClassInfo models

HISTORY:
  (first run — no previous data)
```

## Intent

Compact URI flow to workflow graph compiler for uri3/nl2uri pipelines
