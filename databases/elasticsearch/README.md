# ES

## Quickstart

The best quickstart is to deploy an elasticsearch cluster/node using docker. 

```
# This examples use ES version 6.5.1 - Change it by your desired version
docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:6.5.1
```

## Concepts

- Near real time: not real time indexing (latency between insert and objects to be available for query)
- Cluster: one or more nodes running Elasticsearch and sharing the same dataset
- Node: single server that is part of a cluster
- Index: collection of documents (like a table in SQL DBs if if has a single type, or like a database if you use different types in the same index)
- Type: logical partition/categorization of an index. It allows to store different types of documents in the same index (deprecated, only 1 type allowed right now per index)
- Document: basic unit of information. Like a row in SQL DBs. It will be stored as JSON
- Shards: a method to split data across servers. It will allow to have virtually sequential access to all your data, even if they are stored splited into different servers. Index level. Horizontal scalling feature. Allows for parallel processing 
- Replication: high availability mechanism that replicate a server into different locations. It allows to scale out searches and provide a failover mechanism when any node is not reliable

## REST

Elasticsearch provides a REST API to perform all data manipulation/search tasks, as well as some clients for different programming languages.

Summarized Operations allowed on REST API

- Check node/cluster/index (health, status, statistics)
- Administer node/cluster/index
- Perform CRUD operations
- Perform searches (paging, sorting, filtering, aggregations...)

Useful endpoints (with examples using curl)

- Cluster
  - Health
```
curl -XGET http://localhost:9200/_cat/health?v
```
  - List nodes
```
curl -XGET http://localhost:9200/_cat/nodes?v
```
  - List indice
```
curl -XGET http://localhost:9200/_cat/indices?v
```

- Index
  - Creation
```
# Create an index called myindex
curl -XPUT http://localhost:9200/myindex?pretty
```
  - Deletion
```
curl -XDELETE http://localhost:9200/myindex?pretty
```

- Document
  - Indexing (create/replace document). Id is optional (if not provided, elasticsearch will generate a random one for you and will be returned in response). Use POST instead of PUT if you call this function without an id
```
# Create or replace a given document, identifyied by 1
curl -XPUT http://localhost:9200/myindex/_doc/1?pretty -d '{"field1": "val1", "field2": "val2"}' -H "Content-Type: application/json"
```
  - Update (just update some fields)
```
curl -XPOST http://localhost:9200/myindex/_doc/1/_update?pretty -d '{"doc": {"field1": "val3"}}' -H "Content-Type: application/json"
```
  - Deletion
```
curl -XDELETE http://localhost:9200/myindex/_doc/1?pretty
```
- Batch processing: perform several actions in an efficient way
```
# Index a documents, update another one, delete another one
curl -XPOST http://localhost:9200/myindex/_doc/_bulk?pretty -H "Content-Type: application/json" -d'
{"index":{"_id":"3"}}
{"field1":"a","field2":"b"}
{"update":{"_id": 2}}
{"doc":{"field1":"valX"}}
{"delete":{"_id":"1"}}
'
```
  
- Searching (query, filter, group...)

  - Search can be performed both in querystring and in request body
```
# Match all documents, sort by field 1, ascending
## Querystring flavor
curl -XGET "http://localhost:9200/myindex/_search?q=*&sort=field1:asc&pretty"
## Request body flavor
curl -XGET "http://localhost:9200/myindex/_search" -H 'Content-Type: application/json' -d'
{
  "query": { "match_all": {} },
  "sort": [
    { "field1": "asc" }
  ]
}
'
```

  - Results: result's main fields explained
    - took: time in milliseconds took to execute the search
    - timed_out: yes/no
    - \_shards: how many shards were searched
    - hits: search results
    - hits.total: total number of documents
    - hits.hits: actual array of results (paginated results always)
    - hits.sort: sort key for results
    - hits.\_score: how well match results the query

## Query DSL

Main useful keywords to use on your queries

Just define 3 concepts

- Query: parameters that must match all returned hits
- Filter: filter over the returned hits, that does not affect to final score
- Aggregation: group data to get statistics

Overview of main keywords and their use in searches

- query: query definition
  - match_all: match all documents
  - match: define conditions to match for this query
  - bool: introduce a boolean condition in query
    - must: logical AND
    - should: logical OR
    - must_not: logical AND of NOTs ((NOT a) AND (NOT b) AND ...)
    - filter: restrict the results without affecting final query score. Usually useful on date/numeric range filtering
      - range: filter a range of values for a given field
- size: number of hits returned by your search (defaults to 10)
- from: window from where to start reaching results. It's used for pagination (size=10, from=0 -> 1rst page; size=10, from=10 -> 2nd page)
- sort: sort documents by this key
  - order: asc / desc
- \_source: list, restrict to fields inside list the returned hits (useful to retrieve only part of each document)
  
- aggs: beginning of aggregations definition. They can be nested 
  - custom name: here you define the name of your aggregation. Is custom and you can decide what's in
    - terms: define the terms that will group your data (similar concept as group by + count in SQL)
	  - field: define the field by you will group
	  - order: define the field (or aggregation, as all aggregations will be treat as fields) by which it will be sorted
	- avg: averages a field value
	  - field: define the field that would be averaged
	- range: group by a range of values
	  - field: define the field to be processed in range
	  - ranges: array of dicts, each dict will contain a "from" and "to" keywords, defining the exact range
  
* Buckets: another type of aggregation, this time grouping documents into a common category instead of giving an statistic from them.
  
Some examples

```
# Must match two conditions (AND), 2nd page, sorted by "field1"
curl -XGET "http://localhost:9200/myindex/_search" -H 'Content-Type: application/json' -d'
{
  "query": {
    "bool": {
      "must": [
        { "match": { "field1": "X1" } },
        { "match": { "field2": "X2" } }
      ]
    }
  },
  "size": 10,
  "from": 10,
  "sort": {"field1": {"order": "asc"}}
}
'

# Same query, but it's enough to match just one condition (OR)
curl -XGET "http://localhost:9200/myindex/_search" -H 'Content-Type: application/json' -d'
{
  "query": {
    "bool": {
      "should": [
        { "match": { "field1": "X1" } },
        { "match": { "field2": "X2" } }
      ]
    }
  },
  "sort": {"field1": {"order": "asc"}}
}
'

# Query to another index, showing aggregation. This time, group by ranges, group by gender and averages balance
curl -X GET "http://localhost:9200/myindex2/_search" -H 'Content-Type: application/json' -d'
{
  "size": 0,
  "aggs": {
    "group_by_age": {
      "range": {
        "field": "age",
        "ranges": [
          {
            "from": 20,
            "to": 30
          },
          {
            "from": 30,
            "to": 40
          },
          {
            "from": 40,
            "to": 50
          }
        ]
      },
      "aggs": {
        "group_by_gender": {
          "terms": {
            "field": "gender.keyword"
          },
          "aggs": {
            "average_balance": {
              "avg": {
                "field": "balance"
              }
            }
          }
        }
      }
    }
  }
}
'
```
