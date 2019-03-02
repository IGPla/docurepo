# InfluxDB

InfluxDB is a time series database. It is meant to be used as a backing store for any use case involving large amounts of timestamped data.

## Installation

Docker usage is the most straightforward way to use influxdb

```
docker run --name influxdb -p 8086:8086 -v local_influxdb_db:/var/lib/influxdb influxdb
```

## Usage

In this section we've compiled several useful and common commands. To type them, just use influx CLI (type "influx" in your docker command line)

### Database

- Create new database

```
create database mydb
```

- Show databases

```
show databases
```

- Use database

```
use mydb
```

### Data manipulation

A little bit explanation about data organization. In each database, we will store several "time series". Time series have zero to many points, one for each discrete sample of the metric. Each point consist of a timestamp, a measurement, at least one key-value field and zero or more tags (tags contains metadata about the value)

Each time series will have several fields. Each field can be of different types. Some of them are:
- Double: any number is got as double (for example, 45)
- Integer: followed by i (for example. 45i)
- String: between double quotes (for example, "my value")
- Boolean: T or F

The data format is as follows:

```
<measurement>[,<tag-key>=<tag-value>...] <field-key>=<field-value>[,<field2-key>=<field2-value>...] [unix-nano-timestamp]
```

The following line is an example

```
temperature,machine=unit42,type=assembly external=25,internal=37 1434067467000000000
```

Where we can see a measurement (temperature) with 2 tags (machine and type), 2 fields (external and internal) and a timestamp

- Insert (if no timestamp is provided, local current timestamp will be assigned)
```
insert cpu,host=server1,region=spain value=0.51
```

### Querying data

InfluxDB query language is quite similar to SQL

Following is a simple example, where we select 2 tags and 1 field from cpu measurements with a condition on "value"

```
select "host", "region", "value" from "cpu" where "value" > 0.1
```

The following is another query that filter by time (from last week onwards) and limit to 10 records

```
select * from "cpu" where "region" = 'spain' and time > now() - 7d limit 10
```

* Special note: string query values must be single quoted
