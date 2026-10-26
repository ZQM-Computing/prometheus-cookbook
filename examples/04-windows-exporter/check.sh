#!/bin/bash
# 04-windows-exporter checks against a DEV windows_exporter on localhost.
# Expected: /metrics answers 200 and exposes windows_ series.
set -e
curl -sf -o /dev/null -w 'metrics: %{http_code}\n' http://localhost:9182/metrics
COUNT=$(curl -s http://localhost:9182/metrics | grep -c '^windows_')
echo "windows_ series lines: $COUNT"
test "$COUNT" -gt 0
# Failure behavior:
# - Exporter down: curl fails with connection refused.
# - Wrong port: connection refused, or an unexpected service answers.
#   The exporter is :9182 on Node-1 and Node-3 per the fleet record.
