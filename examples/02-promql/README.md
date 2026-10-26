# 02-promql — PromQL queries for host and service health

**Evidence:** design-only, gate 1 target. Not runtime-validated on the fleet.
**Versions:** Prometheus 3.15.1, windows_exporter 0.32.0 (fleet record).

## What it demonstrates

Three query shapes: target health (`up`), down-only filtering (`== 0`), and
scrape latency (`scrape_duration_seconds`). All three use only universal
series, so they run against any Prometheus.

## Run

```bash
bash query.sh
```

## Expected output

- Each query returns `resultType: "vector"`.
- `up` returns one series per target with value `1` when healthy.
- The `== 0` query returns an **empty** vector when everything is up — that
  is the healthy outcome, not an error.

## Failure behavior

- Bad PromQL: the API returns `status: "error"` with a parse position; the
  script exits nonzero.
- Server down: curl fails with connection refused.

## To confirm at validation

- The Section B candidate series in `queries.promql`
  (`windows_cpu_time_total` and its `mode` label) against a live
  windows_exporter 0.32.0 `/metrics` endpoint — the fleet record proves the
  endpoint answers, not these exact series names. Section B is commented out
  until that check lands.
