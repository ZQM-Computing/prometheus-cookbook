# 03-alert-rules — recording and alerting rules

**Evidence:** design-only, gate 1 target. Not runtime-validated on the fleet.
**Versions:** Prometheus 3.15.1 (fleet record); promtool ships with Prometheus.

## What it demonstrates

- A recording rule (`job:up:sum`) and an alerting rule
  (`WindowsExporterDown`, `up == 0` for 5m, severity page) — the same shape
  as the fleet's service-down alert expression.
- An offline test: `promtool test rules` replays synthetic `up` series and
  asserts the alert fires with the expected labels and annotations.

## Run

```bash
bash check.sh
```

## Expected output

- `promtool check rules` prints SUCCESS.
- `promtool test rules` prints SUCCESS: the alert fires at the 10m eval time
  with instance `testhost:9182`, job `windows_exporter`, severity `page`.

## Failure behavior

- Bad expression: `promtool check rules` fails naming the rule and parse error.
- Wrong expected alert: `promtool test rules` fails with an
  expected-vs-actual diff.

## To confirm at validation

- Firing-time accounting on promtool 3.15.1 (the 10m eval_time assumes the
  5m `for:` duration elapses from the series start).
- That the fleet's 8 live rules and this dev file stay separate: this file
  never edits fleet rules, and wiring it into a server means adding a
  `rule_files` entry to that server's own config, which is a fleet action,
  not part of this pattern.
