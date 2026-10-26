#!/bin/bash
# 01-scrape-config checks. Run from this directory against a DEV Prometheus.
# Expected: promtool check passes; /-/healthy and /-/ready both answer 200.
set -e
promtool check config prometheus.yml
curl -sf -o /dev/null -w 'healthy: %{http_code}\n' http://localhost:9090/-/healthy
curl -sf -o /dev/null -w 'ready: %{http_code}\n' http://localhost:9090/-/ready
curl -s 'http://localhost:9090/api/v1/targets?state=active' | grep -o '"health":"up"' | wc -l
# Expected: the last line prints 2 (prometheus self + windows_exporter), both up.
# Failure behavior:
# - promtool check fails with a file/line error if the YAML is malformed.
# - A down target shows "health":"down" here and up{job="..."} == 0 in PromQL.
