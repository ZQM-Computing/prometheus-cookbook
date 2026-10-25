# Prometheus Cookbook

<!-- ZQM-START -->
<!-- markdownlint-disable MD033 -->
<p align="center">
  <strong>ZQM Computing — Geospatial Engineering & Scientific Computing</strong><br>
  <a href="https://github.com/ZQM-Computing">ZQM Computing</a>
</p>
<!-- markdownlint-enable MD033 -->
<!-- ZQM-END -->

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

A **Prometheus cookbook** for scrape jobs, PromQL, and alert rules with windows_exporter. Patterns are drawn from the ZQM fleet's Prometheus 3.15.1 installs and windows_exporter 0.32.0 metrics endpoints on Node-1 and Node-3. It is intended for Platform engineers who collect metrics from Windows hosts and services. Validate each pattern against your own data, software versions, and operating environment before adopting it.

## Repository role and status

**Status:** Active, public — seeding. Pattern passes land in follow-up work from fleet-verified setups; the tables below list what is planned, not what is already written.

**What this repository is:** Prometheus patterns — see the table below.

**What it contributes:** Part of the ZQM Computing geospatial portfolio. The umbrella index for the series is [geospatial-cookbooks](https://github.com/ZQM-Computing/geospatial-cookbooks).

**Standing:** This repository is maintained independently. Automated checks cover only the paths and environments configured in its workflows; they do not establish production readiness or operational certification.

## Who this is for

Platform engineers who collect metrics from Windows hosts and services.

## Prerequisites

- Prometheus 3.15.1
- windows_exporter 0.32.0
- Grafana for the dashboard pass (see grafana-cookbook)

## Patterns (planned)

| # | Example | What it will demonstrate |
|---|---------|--------------------------|
| 01 | `01-scrape-config` | Scrape jobs for Prometheus itself and windows_exporter |
| 02 | `02-promql` | PromQL queries for host and service health |
| 03 | `03-alert-rules` | Recording and alerting rules |
| 04 | `04-windows-exporter` | windows_exporter setup notes, including the listen-address flag (no telemetry.addr in 0.32.0) |

## Repository layout

```text
prometheus-cookbook/
├── examples/          # pattern passes, landing in follow-up work
├── README.md
└── LICENSE
```

## Roadmap

- First pattern pass: the first two table rows
- Second pass: the remaining rows, from fleet-verified setups

## Contributing

A contributing guide lands with the first pattern pass. Report security issues to <zqmcomputing@gmail.com> — please do not open a public issue for those.

## More from this series

- [grafana-cookbook](https://github.com/ZQM-Computing/grafana-cookbook) — Dashboards, datasources, and alerts for geospatial stacks
- [mosquitto-cookbook](https://github.com/ZQM-Computing/mosquitto-cookbook) — MQTT broker setup, listeners, and pub/sub patterns
- [nodered-cookbook](https://github.com/ZQM-Computing/nodered-cookbook) — Flow-based automation for geospatial and IoT triggers
