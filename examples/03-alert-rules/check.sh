#!/bin/bash
# 03-alert-rules checks. Run from this directory. No live server needed.
# Expected: both promtool commands print SUCCESS.
set -e
promtool check rules rules.yml
promtool test rules rules_test.yml
# Failure behavior:
# - Bad expression: promtool check rules fails naming the rule and the parse error.
# - Wrong expected alert (labels, annotations, or firing time): promtool test
#   rules fails showing the expected-vs-actual alert diff.
# Note: the test's eval_time (10m) assumes the 5m `for:` duration elapses
# after the series starts at 0; if promtool's firing-time accounting differs
# on your version, adjust eval_time — that is a validation item, not a pass.
