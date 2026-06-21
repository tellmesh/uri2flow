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
sumd_declared_file('app.doql.less', 'doql').
sumd_declared_file('testql-scenarios/generated-cli-tests.testql.toon.yaml', 'testql').
sumd_declared_file('testql-scenarios/generated-from-pytests.testql.toon.yaml', 'testql').
sumd_declared_file('project/map.toon.yaml', 'analysis').
sumd_declared_file('project/logic.pl', 'analysis').
sumd_declared_file('project/calls.toon.yaml', 'analysis').
sumd_interface('cli', 'argparse').
sumd_interface('cli', '').

