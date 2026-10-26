#!/bin/bash
# 02-promql: run the Section A queries against a DEV Prometheus and assert shape.
# Expected: each query returns resultType "vector" with at least one series.
set -e
for q in 'up' 'up{job="windows_exporter"} == 0' 'scrape_duration_seconds{job="windows_exporter"}'; do
  echo "--- $q"
  curl -sG 'http://localhost:9090/api/v1/query' --data-urlencode "query=$q" \
    | grep -o '"resultType":"vector"'
done
# Note: the == 0 query returns an EMPTY vector when everything is up.
# That is the healthy outcome, not an error; the grep above still matches
# resultType, and the result array is empty.
# Failure behavior:
# - Bad PromQL: the API returns status "error" with an error message naming
#   the parse position; the grep finds no resultType line and the script exits nonzero.
# - Server down: curl fails (connection refused) and the script exits nonzero.
