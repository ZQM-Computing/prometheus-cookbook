# 01-scrape-config — scrape jobs for Prometheus itself and windows_exporter

**Evidence:** design-only, gate 1 target. Not runtime-validated on the fleet.
**Versions:** Prometheus 3.15.1, windows_exporter 0.32.0 (fleet record, Node-1 and Node-3).

## What it demonstrates

Two scrape jobs: Prometheus scraping itself on `:9090` and windows_exporter on
`:9182`. Both targets are up on Node-1 and Node-3 per the fleet record.

## Run

```bash
promtool check config prometheus.yml
bash check.sh
```

## Expected output

- `promtool check config` passes with no errors.
- `/-/healthy` and `/-/ready` both answer HTTP 200.
- The active-targets query counts 2 series with `"health":"up"`.

## Failure behavior

- Malformed YAML: `promtool check config` fails naming the file and line.
- A down target: the targets query shows `"health":"down"`, and
  `up{job="windows_exporter"} == 0` in PromQL (see `02-promql`).

## To confirm at validation

- `/-/healthy` vs `/-/ready` semantics on Prometheus 3.15.1 (which gate the
  server reports while still loading).
- That a dev instance on `localhost` binds exactly as the fleet's tailnet
  instances do (fleet bindings are tailnet-scoped; this example is localhost).
