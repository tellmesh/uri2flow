# uri2flow v0.1

Compact URI flow to workflow graph compiler for uri3/nl2uri pipelines

## Contents

- [Metadata](#metadata)
- [Architecture](#architecture)
- [Interfaces](#interfaces)
- [Configuration](#configuration)
- [Dependencies](#dependencies)
- [Deployment](#deployment)
- [Environment Variables (`.env.example`)](#environment-variables-envexample)
- [Release Management (`goal.yaml`)](#release-management-goalyaml)
- [Code Analysis](#code-analysis)
- [Source Map](#source-map)
- [Call Graph](#call-graph)
- [Test Contracts](#test-contracts)
- [Intent](#intent)

## Metadata

- **name**: `uri2flow`
- **version**: `0.1.2`
- **python_requires**: `>=3.10`
- **license**: Apache-2.0
- **ai_model**: `openrouter/qwen/qwen3-coder-next`
- **ecosystem**: SUMD + DOQL + testql + taskfile
- **generated_from**: pyproject.toml, testql(2), app.doql.less, goal.yaml, .env.example, src(7 mod), project/(3 analysis files)

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

## Interfaces

### CLI Entry Points

- `uri2flow`

### testql Scenarios

#### `testql-scenarios/generated-cli-tests.testql.toon.yaml`

```toon markpact:testql path=testql-scenarios/generated-cli-tests.testql.toon.yaml
# SCENARIO: CLI Command Tests
# TYPE: cli
# GENERATED: true

CONFIG[2]{key, value}:
  cli_command, python -m uri2flow
  timeout_ms, 10000

# Test 1: CLI help command
SHELL "python -m uri2flow --help" 5000
ASSERT_EXIT_CODE 0
ASSERT_STDOUT_CONTAINS "usage"

# Test 2: CLI version command
SHELL "python -m uri2flow --version" 5000
ASSERT_EXIT_CODE 0

# Test 3: CLI main workflow (dry-run)
SHELL "python -m uri2flow --help" 10000
ASSERT_EXIT_CODE 0
```

#### `testql-scenarios/generated-from-pytests.testql.toon.yaml`

```toon markpact:testql path=testql-scenarios/generated-from-pytests.testql.toon.yaml
# SCENARIO: Auto-generated from Python Tests
# TYPE: integration
# GENERATED: true

CONFIG[2]{key, value}:
  base_url, ${api_url:-http://localhost:8101}
  timeout_ms, 10000

# Converted 36 assertions from pytest
ASSERT[36]{field, operator, expected}:
  flow.id, ==, "weather-health"
  flow.steps[-1].uri, ==, "browser://chrome/page/open"
  flow.steps[-1].payload.url, ==, "http://localhost:8101/health"
  graph.nl2uri.kind, ==, "workflow_graph"
  validate_workflow_graph(graph), ==, []
  nodes[0].uri, ==, "agent://weather-generator"
  nodes[2].payload.url, ==, "http://localhost:8101/health"
  len(flow.steps), ==, 3
  flow.steps[1].payload.url, ==, "http://x"
  flow.steps[2].after, ==, ["open"]
  defaults.operation, ==, "read"
  defaults.kind, ==, "query"
  graph.nl2uri.kind, ==, "workflow_graph"
  nodes[0].operation, ==, "generate"
  nodes[0].kind, ==, "command"
  nodes[1].depends_on, ==, [nodes[0]["id"]]
  nodes[2].payload.url, ==, "http://localhost:8101/health"
  nodes[2].operation, ==, "open"
  flow.id, ==, "weather-health"
  flow.steps[-1].uri, ==, "browser://chrome/page/open"
  flow.steps[-1].payload.url, ==, "http://localhost:8101/health"
  graph.nl2uri.kind, ==, "workflow_graph"
  validate_workflow_graph(graph), ==, []
  nodes[0].uri, ==, "agent://weather-generator"
  nodes[2].payload.url, ==, "http://localhost:8101/health"
  len(flow.steps), ==, 3
  flow.steps[1].payload.url, ==, "http://x"
  flow.steps[2].after, ==, ["open"]
  defaults.operation, ==, "read"
  defaults.kind, ==, "query"
  graph.nl2uri.kind, ==, "workflow_graph"
  nodes[0].operation, ==, "generate"
  nodes[0].kind, ==, "command"
  nodes[1].depends_on, ==, [nodes[0]["id"]]
  nodes[2].payload.url, ==, "http://localhost:8101/health"
  nodes[2].operation, ==, "open"
```

## Configuration

```yaml
project:
  name: uri2flow
  version: 0.1.2
  env: local
```

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

## Deployment

```bash markpact:run
pip install uri2flow

# development install
pip install -e .[dev]
```

## Environment Variables (`.env.example`)

| Variable | Default | Description |
|----------|---------|-------------|
| `OPENROUTER_API_KEY` | `*(not set)*` | Required: OpenRouter API key (https://openrouter.ai/keys) |
| `LLM_MODEL` | `openrouter/qwen/qwen3-coder-next` | Model (default: openrouter/qwen/qwen3-coder-next) |
| `PFIX_AUTO_APPLY` | `true` | true = apply fixes without asking |
| `PFIX_AUTO_INSTALL_DEPS` | `true` | true = auto pip/uv install |
| `PFIX_AUTO_RESTART` | `false` | true = os.execv restart after fix |
| `PFIX_MAX_RETRIES` | `3` |  |
| `PFIX_DRY_RUN` | `false` |  |
| `PFIX_ENABLED` | `true` |  |
| `PFIX_GIT_COMMIT` | `false` | true = auto-commit fixes |
| `PFIX_GIT_PREFIX` | `pfix:` | commit message prefix |
| `PFIX_CREATE_BACKUPS` | `false` | false = disable .pfix_backups/ directory |

## Release Management (`goal.yaml`)

- **versioning**: `semver`
- **commits**: `conventional` scope=`uri2flow`
- **changelog**: `keep-a-changelog`
- **build strategies**: `python`, `nodejs`, `rust`
- **version files**: `VERSION`, `pyproject.toml:version`, `uri2flow/__init__.py:__version__`

## Code Analysis

### `project/map.toon.yaml`

```toon markpact:analysis path=project/map.toon.yaml
# uri2flow | 24f 1082L | python:20,shell:3,less:1 | 2026-06-21
# stats: 60 func | 4 cls | 24 mod | CC̄=4.0 | critical:5 | cycles:0
# alerts[5]: CC parse_flow=12; CC _node_from_step=11; CC validate_flow=11; CC _parse_step=10; CC validate_flow_document=10
# hotspots[5]: _parse_step fan=11; _find_repo_root fan=10; load_flow fan=8; cmd_expand fan=7; expand_flow fan=7
# evolution: baseline
# Keys: M=modules, D=details, i=imports, e=exports, c=classes, f=functions, m=methods
M[24]:
  app.doql.less,39
  examples/33_office_workflows/run.sh,42
  project.sh,59
  tests/__init__.py,1
  tests/conftest.py,59
  tests/integration/__init__.py,1
  tests/integration/test_flow_to_workflow_execution.py,39
  tests/test_cli.py,13
  tests/test_expand_branching_flow.py,14
  tests/test_expand_linear_flow.py,15
  tests/test_flow_defaults.py,58
  tests/test_parser_forms.py,16
  tests/test_uri2flow_markpact_loader.py,125
  tree.sh,2
  uri2flow/__init__.py,17
  uri2flow/cli.py,76
  uri2flow/expander.py,82
  uri2flow/loaders/__init__.py,20
  uri2flow/loaders/markpact_loader.py,24
  uri2flow/models.py,48
  uri2flow/parser.py,100
  uri2flow/resolver.py,128
  uri2flow/utils.py,39
  uri2flow/validator.py,65
D:
  tests/__init__.py:
  tests/conftest.py:
    e: _hypervisor_root,repo_root
    _hypervisor_root()
    repo_root()
  tests/integration/__init__.py:
  tests/integration/test_flow_to_workflow_execution.py:
    e: test_compact_flow_to_dry_run,test_branching_flow_has_expected_edges,test_nl2uri_flow_expands_and_validates
    test_compact_flow_to_dry_run(repo_root)
    test_branching_flow_has_expected_edges(repo_root)
    test_nl2uri_flow_expands_and_validates()
  tests/test_cli.py:
    e: test_cli_expand
    test_cli_expand(repo_root;tmp_path)
  tests/test_expand_branching_flow.py:
    e: test_expand_branching_flow
    test_expand_branching_flow(repo_root)
  tests/test_expand_linear_flow.py:
    e: test_expand_linear_flow
    test_expand_linear_flow(repo_root)
  tests/test_flow_defaults.py:
    e: setup_function,test_pattern_match_hypervisor_run,test_pattern_match_hypervisor_restart,test_pattern_match_browser_open,test_pattern_match_dom_extract,test_pattern_match_screen_observe,test_pattern_match_input_type,test_scheme_default_for_http,test_fallback_for_unknown_scheme
    setup_function()
    test_pattern_match_hypervisor_run()
    test_pattern_match_hypervisor_restart()
    test_pattern_match_browser_open()
    test_pattern_match_dom_extract()
    test_pattern_match_screen_observe()
    test_pattern_match_input_type()
    test_scheme_default_for_http()
    test_fallback_for_unknown_scheme()
  tests/test_parser_forms.py:
    e: test_accepts_string_and_mapping_forms
    test_accepts_string_and_mapping_forms()
  tests/test_uri2flow_markpact_loader.py:
    e: _markpact_ref,test_is_markpact_registry,test_extract_markpact_flow_blocks,test_load_markpact_flow_dict,test_load_flow_markpact_ref,test_expand_flow_markpact_ref,test_markpact_flow_requires_fragment_when_ambiguous,test_markpact_flow_matches_yaml_flow,test_resolve_markpact_ref,test_uri2flow_expand_cli,test_missing_flow_fragment_raises,test_missing_markpact_readme_raises
    _markpact_ref(repo_root;fragment)
    test_is_markpact_registry()
    test_extract_markpact_flow_blocks()
    test_load_markpact_flow_dict(repo_root)
    test_load_flow_markpact_ref(repo_root)
    test_expand_flow_markpact_ref(repo_root)
    test_markpact_flow_requires_fragment_when_ambiguous(tmp_path)
    test_markpact_flow_matches_yaml_flow(repo_root)
    test_resolve_markpact_ref(repo_root)
    test_uri2flow_expand_cli(repo_root;tmp_path)
    test_missing_flow_fragment_raises(repo_root)
    test_missing_markpact_readme_raises(repo_root)
  uri2flow/__init__.py:
  uri2flow/cli.py:
    e: cmd_validate,cmd_expand,cmd_print,build_parser,main
    cmd_validate(args)
    cmd_expand(args)
    cmd_print(args)
    build_parser()
    main(argv)
  uri2flow/expander.py:
    e: _node_from_step,_edges_from_depends,expand_flow,dump_yaml
    _node_from_step(step;previous_id;used)
    _edges_from_depends(nodes)
    expand_flow(flow)
    dump_yaml(data)
  uri2flow/loaders/__init__.py:
  uri2flow/loaders/markpact_loader.py:
  uri2flow/models.py:
    e: FlowStep,FlowDocument
    FlowStep:
    FlowDocument: to_dict(0)
  uri2flow/parser.py:
    e: _as_list,_parse_step,parse_flow,load_flow,FlowParseError
    FlowParseError:
    _as_list(value)
    _parse_step(raw)
    parse_flow(data)
    load_flow(path)
  uri2flow/resolver.py:
    e: _find_repo_root,_pattern_to_regex,_match_pattern,_load_flow_defaults_config,_defaults_from_entry,_defaults_from_scheme,_defaults_from_patterns,_fallback_defaults,default_operation_for_uri,clear_defaults_cache,OperationDefaults
    OperationDefaults:
    _find_repo_root(start)
    _pattern_to_regex(pattern)
    _match_pattern(pattern;uri)
    _load_flow_defaults_config()
    _defaults_from_entry(entry)
    _defaults_from_scheme(scheme)
    _defaults_from_patterns(uri)
    _fallback_defaults()
    default_operation_for_uri(uri)
    clear_defaults_cache()
  uri2flow/utils.py:
    e: slugify,scheme_of,path_parts,node_id_from_uri
    slugify(value)
    scheme_of(uri)
    path_parts(uri)
    node_id_from_uri(uri;used)
  uri2flow/validator.py:
    e: validate_flow_document,validate_expanded_flow,validate_flow
    validate_flow_document(data)
    validate_expanded_flow(data)
    validate_flow(path)
```

### `project/logic.pl`

```prolog markpact:analysis path=project/logic.pl
% ── Project Metadata ─────────────────────────────────────
project_metadata('uri2flow', '0.1.2', 'python').

% ── Project Files ────────────────────────────────────────
project_file('app.doql.less', 39, 'less').
project_file('examples/33_office_workflows/run.sh', 42, 'shell').
project_file('project.sh', 59, 'shell').
project_file('tests/__init__.py', 1, 'python').
project_file('tests/conftest.py', 59, 'python').
project_file('tests/integration/__init__.py', 1, 'python').
project_file('tests/integration/test_flow_to_workflow_execution.py', 39, 'python').
project_file('tests/test_cli.py', 13, 'python').
project_file('tests/test_expand_branching_flow.py', 14, 'python').
project_file('tests/test_expand_linear_flow.py', 15, 'python').
project_file('tests/test_flow_defaults.py', 58, 'python').
project_file('tests/test_parser_forms.py', 16, 'python').
project_file('tests/test_uri2flow_markpact_loader.py', 125, 'python').
project_file('tree.sh', 2, 'shell').
project_file('uri2flow/__init__.py', 17, 'python').
project_file('uri2flow/cli.py', 76, 'python').
project_file('uri2flow/expander.py', 82, 'python').
project_file('uri2flow/loaders/__init__.py', 20, 'python').
project_file('uri2flow/loaders/markpact_loader.py', 24, 'python').
project_file('uri2flow/models.py', 48, 'python').
project_file('uri2flow/parser.py', 100, 'python').
project_file('uri2flow/resolver.py', 128, 'python').
project_file('uri2flow/utils.py', 39, 'python').
project_file('uri2flow/validator.py', 65, 'python').

% ── Python Functions ─────────────────────────────────────
python_function('tests/conftest.py', '_hypervisor_root', 0, 7, 6).
python_function('tests/conftest.py', 'repo_root', 0, 1, 1).
python_function('tests/integration/test_flow_to_workflow_execution.py', 'test_compact_flow_to_dry_run', 1, 4, 5).
python_function('tests/integration/test_flow_to_workflow_execution.py', 'test_branching_flow_has_expected_edges', 1, 5, 1).
python_function('tests/integration/test_flow_to_workflow_execution.py', 'test_nl2uri_flow_expands_and_validates', 0, 3, 4).
python_function('tests/test_cli.py', 'test_cli_expand', 2, 4, 3).
python_function('tests/test_expand_branching_flow.py', 'test_expand_branching_flow', 1, 6, 1).
python_function('tests/test_expand_linear_flow.py', 'test_expand_linear_flow', 1, 7, 1).
python_function('tests/test_flow_defaults.py', 'setup_function', 0, 1, 1).
python_function('tests/test_flow_defaults.py', 'test_pattern_match_hypervisor_run', 0, 4, 1).
python_function('tests/test_flow_defaults.py', 'test_pattern_match_hypervisor_restart', 0, 3, 1).
python_function('tests/test_flow_defaults.py', 'test_pattern_match_browser_open', 0, 3, 1).
python_function('tests/test_flow_defaults.py', 'test_pattern_match_dom_extract', 0, 3, 1).
python_function('tests/test_flow_defaults.py', 'test_pattern_match_screen_observe', 0, 3, 1).
python_function('tests/test_flow_defaults.py', 'test_pattern_match_input_type', 0, 4, 1).
python_function('tests/test_flow_defaults.py', 'test_scheme_default_for_http', 0, 3, 1).
python_function('tests/test_flow_defaults.py', 'test_fallback_for_unknown_scheme', 0, 3, 1).
python_function('tests/test_parser_forms.py', 'test_accepts_string_and_mapping_forms', 0, 4, 2).
python_function('tests/test_uri2flow_markpact_loader.py', '_markpact_ref', 2, 2, 0).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_is_markpact_registry', 0, 3, 1).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_extract_markpact_flow_blocks', 0, 4, 2).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_load_markpact_flow_dict', 1, 3, 3).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_load_flow_markpact_ref', 1, 4, 2).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_expand_flow_markpact_ref', 1, 5, 3).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_markpact_flow_requires_fragment_when_ambiguous', 1, 1, 3).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_markpact_flow_matches_yaml_flow', 1, 2, 2).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_resolve_markpact_ref', 1, 3, 3).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_uri2flow_expand_cli', 2, 4, 4).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_missing_flow_fragment_raises', 1, 1, 3).
python_function('tests/test_uri2flow_markpact_loader.py', 'test_missing_markpact_readme_raises', 1, 1, 2).
python_function('uri2flow/cli.py', 'cmd_validate', 1, 2, 4).
python_function('uri2flow/cli.py', 'cmd_expand', 1, 3, 7).
python_function('uri2flow/cli.py', 'cmd_print', 1, 1, 4).
python_function('uri2flow/cli.py', 'build_parser', 0, 1, 5).
python_function('uri2flow/cli.py', 'main', 1, 1, 3).
python_function('uri2flow/expander.py', '_node_from_step', 3, 11, 3).
python_function('uri2flow/expander.py', '_edges_from_depends', 1, 4, 2).
python_function('uri2flow/expander.py', 'expand_flow', 1, 6, 7).
python_function('uri2flow/expander.py', 'dump_yaml', 1, 1, 1).
python_function('uri2flow/parser.py', '_as_list', 1, 5, 4).
python_function('uri2flow/parser.py', '_parse_step', 1, 10, 11).
python_function('uri2flow/parser.py', 'parse_flow', 1, 12, 7).
python_function('uri2flow/parser.py', 'load_flow', 1, 4, 8).
python_function('uri2flow/resolver.py', '_find_repo_root', 1, 9, 10).
python_function('uri2flow/resolver.py', '_pattern_to_regex', 1, 4, 7).
python_function('uri2flow/resolver.py', '_match_pattern', 2, 2, 3).
python_function('uri2flow/resolver.py', '_load_flow_defaults_config', 0, 4, 7).
python_function('uri2flow/resolver.py', '_defaults_from_entry', 1, 3, 4).
python_function('uri2flow/resolver.py', '_defaults_from_scheme', 1, 3, 4).
python_function('uri2flow/resolver.py', '_defaults_from_patterns', 1, 7, 6).
python_function('uri2flow/resolver.py', '_fallback_defaults', 0, 4, 5).
python_function('uri2flow/resolver.py', 'default_operation_for_uri', 1, 3, 4).
python_function('uri2flow/resolver.py', 'clear_defaults_cache', 0, 1, 1).
python_function('uri2flow/utils.py', 'slugify', 1, 2, 3).
python_function('uri2flow/utils.py', 'scheme_of', 1, 1, 1).
python_function('uri2flow/utils.py', 'path_parts', 1, 4, 4).
python_function('uri2flow/utils.py', 'node_id_from_uri', 2, 5, 7).
python_function('uri2flow/validator.py', 'validate_flow_document', 1, 10, 7).
python_function('uri2flow/validator.py', 'validate_expanded_flow', 1, 2, 5).
python_function('uri2flow/validator.py', 'validate_flow', 1, 11, 4).

% ── Python Classes ───────────────────────────────────────
python_class('uri2flow/models.py', 'FlowStep').
python_class('uri2flow/models.py', 'FlowDocument').
python_method('FlowDocument', 'to_dict', 0, 11, 2).
python_class('uri2flow/parser.py', 'FlowParseError').
python_class('uri2flow/resolver.py', 'OperationDefaults').

% ── Dependencies ─────────────────────────────────────────

% ── Makefile Targets ─────────────────────────────────────

% ── Taskfile Tasks ───────────────────────────────────────

% ── Environment Variables ────────────────────────────────
env_variable('OPENROUTER_API_KEY', '*(not set)*', 'Required: OpenRouter API key (https://openrouter.ai/keys)').
env_variable('LLM_MODEL', 'openrouter/qwen/qwen3-coder-next', 'Model (default: openrouter/qwen/qwen3-coder-next)').
env_variable('PFIX_AUTO_APPLY', 'true', 'true = apply fixes without asking').
env_variable('PFIX_AUTO_INSTALL_DEPS', 'true', 'true = auto pip/uv install').
env_variable('PFIX_AUTO_RESTART', 'false', 'true = os.execv restart after fix').
env_variable('PFIX_MAX_RETRIES', '3', '').
env_variable('PFIX_DRY_RUN', 'false', '').
env_variable('PFIX_ENABLED', 'true', '').
env_variable('PFIX_GIT_COMMIT', 'false', 'true = auto-commit fixes').
env_variable('PFIX_GIT_PREFIX', 'pfix:', 'commit message prefix').
env_variable('PFIX_CREATE_BACKUPS', 'false', 'false = disable .pfix_backups/ directory').

% ── TestQL Scenarios ─────────────────────────────────────
testql_scenario('generated-cli-tests.testql.toon.yaml', 'cli').
testql_scenario('generated-from-pytests.testql.toon.yaml', 'integration').

% ── Semantic Facts from SUMD.md ──────────────────────────
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

## Intent

Compact URI flow to workflow graph compiler for uri3/nl2uri pipelines
