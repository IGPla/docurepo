# Prometheus

Open source systems monitoring and alerting toolkit. It's main features comprises:
- Multidimensional time series data model
- Flexible query language
- Single server nodes are autonomous
- Time series collection happens via pull model over HTTP
- Pushing time series is supported via an intermediate gateway
- Targets are discovered via service discovery or static configuration

## Installation

Docker image is ready to be used

```
docker run --name prometheus -p 9090:9090 -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
```

## Configuration

Prometheus configuration can be done through configuration flags and a configuration file, and can reload its configuration at runtime.

### Command line flags

Configure immutable system parameters (such as storage locations, amount of data to keep on disk...). To check it all, run 

```
prometheus --help
```

in your Prometheus' deploy

### Configuration file

Defines everything related to scraping jobs. Following you can check a common template

```
global:
  # How frequently to scrape targets by default.
  [ scrape_interval: <duration> | default = 1m ]

  # How long until a scrape request times out.
  [ scrape_timeout: <duration> | default = 10s ]

  # How frequently to evaluate rules.
  [ evaluation_interval: <duration> | default = 1m ]

  # The labels to add to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
    [ <labelname>: <labelvalue> ... ]

# Rule files specifies a list of globs. Rules and alerts are read from
# all matching files.
rule_files:
  [ - <filepath_glob> ... ]

# A list of scrape configurations.
scrape_configs:
  [ - <scrape_config> ... ]

# Alerting specifies settings related to the Alertmanager.
alerting:
  alert_relabel_configs:
    [ - <relabel_config> ... ]
  alertmanagers:
    [ - <alertmanager_config> ... ]

# Settings related to the remote write feature.
remote_write:
  [ - <remote_write> ... ]

# Settings related to the remote read feature.
remote_read:
  [ - <remote_read> ... ]

```

Some of main concepts defined below:

- scrape\_config: this section specifies a set of targets and parameters describing how to scrape them
- tls\_config: allows configuring TLS connections
- *\_sd\_config: service discovery configuration for different services (like azure, consul...)

## Example

This example configures a basic scraping job for the same service (prometheus monitoring prometheus)

```
global:
  scrape_interval:     15s # By default, scrape targets every 15 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
    monitor: 'codelab-monitor'

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # Override the global default and scrape targets from this job every 5 seconds.
    scrape_interval: 5s

    static_configs:
      - targets: ['localhost:9090']
```

## Querying

There's an HTTP API, exposed on each Prometheus instance. 

### Instant queries

```
GET /api/v1/query
```

Accepting the following parameters:

- query=<string> (Prometheus expression query string, more on this below)
- time=<rfc3339 | unix_timestamp> (timestamps format)
- timeout=<duration>

Usage example with curl

```
curl 'http://localhost:9090/api/v1/query?query=up&time=2015-07-01T20:10:51.781Z'
```

### Range queries

```
GET /api/v1/query_range
```

Accepting the following parameters:

- query=<string> (Prometheus expression query string, more on this below)
- start=<rfc3339 | unix_timestamp> (timestamps format)
- end=<rfc3339 | unix_timestamp> (timestamps format)
- step=<duration> (query resolution step width)
- timeout=<duration>

Usage example with curl

```
curl 'http://localhost:9090/api/v1/query_range?query=up&start=2015-07-01T20:10:30.781Z&end=2015-07-01T20:11:00.781Z&step=15s'
```

### Other useful endpoints

```
GET /api/v1/series -> List of time series that match a certain label set
GET /api/v1/labels -> List of label names
GET /api/v1/label/<label_name>/values -> Querying label values
GET /api/v1/targets -> Overview of the current state of target discovery
GET /api/v1/rules -> List of alerting and recording rules that are loaded
GET /api/v1/alerts -> List of active alerts
GET /api/v1/targets/metadata -> Metadata about metrics currently scraped by targets
GET /api/v1/alertmanagers -> Overview of the current alertmanager discovery
GET /api/v1/status/config -> Currently loaded configuration file
GET /api/v1/status/flags -> Flag values that Prometheus was configured with
```

### Queries

Examples of queries:

- Return all time series with the metric http\_requests\_total

```
http_requests_total
```

- Same as above, filtered by job and handler

```
http_requests_total{job="apiserver", handler="/api/comments"}
```

## Instrumenting

Adding instrumentation to a given service for Prometheus is quite simple. There are a lot of libraries for many languages

https://prometheus.io/docs/instrumenting/clientlibs/

Basically, what each service will do is to expose an HTTP endpoint to be scraped by Prometheus.

Following example demonstrates how to instrument arbitrary metrics using Python

```
pip install prometheus_client
```

```
from prometheus_client.core import GaugeMetricFamily, CounterMetricFamily, REGISTRY
from prometheus_client import start_http_server
import time

class CustomCollector(object):
    def collect(self):
        yield GaugeMetricFamily('sample_gauge_metric', 'This is a text to understand what it does', value=10)
        c = CounterMetricFamily('sample_counter_metric', 'Another help text', labels=['a_label'])
        c.add_metric(['a_value_1'], 2.0)
        c.add_metric(['a_value_x'], 2.3)
        yield c

if __name__ == "__main__":
    REGISTRY.register(CustomCollector())
    start_http_server(8000)

    while True:
        time.sleep(1)
```

From this point, you can access to this output through http://localhost:8000 and check all metrics collected. Basically, you will find a sample\_gauge\_metric value and two sample\_counter\_metric values plus many other values given by the client library.

For more information about this Python plugin for Prometheus, please visit the following site: https://github.com/prometheus/client_python
