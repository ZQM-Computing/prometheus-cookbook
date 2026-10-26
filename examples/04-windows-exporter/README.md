# 04-windows-exporter — windows_exporter setup notes

**Evidence:** design-only, gate 1 target. Not runtime-validated on the fleet.
**Versions:** windows_exporter 0.32.0, Prometheus 3.15.1 (fleet record).

## What it demonstrates

How to confirm a windows_exporter is answering, and the two fleet-record
quirks that bite setup scripts:

1. **No `--telemetry.addr` in 0.32.0.** The listen address flag is
   `--web.listen-address` (fleet record: `--help` output is empty, and
   `--telemetry.addr` does not exist). Example: start with
   `--web.listen-address=:9182`.
2. **`/metrics` answers 200** on `:9182` on Node-1 and Node-3, with
   `windows_`-prefixed series.

## Run

```bash
bash check.sh
```

## Expected output

- `metrics: 200`.
- A positive count of `windows_` series lines.

## Failure behavior

- Exporter down: curl fails with connection refused.
- Wrong port: connection refused, or an unexpected service answers.

## To confirm at validation

- The exact enabled-collector list on 0.32.0 (fleet record proves the
  endpoint answers, not which collectors are enabled).
- The exact `--web.listen-address` spelling against a live 0.32.0 binary
  (fleet record says the flag exists; the binary's empty `--help` means the
  spelling cannot be re-derived from help text alone).
- Bind scope: this pattern probes localhost on a dev box. Fleet exporter
  bindings are tailnet-scoped per the fleet's private-binding rule; do not
  copy a localhost bind into a fleet service definition.
