# NoSQL

No SQL databases and datastores comprises different categories. In this document you will find a summary on each type and its own best use cases

## Wide-column store

It's a data store that use columns to store data. Each column is grouped to related columns, through a row id, and constitue a column family.
An example could be good to clarify the concept:

Standard relational table:
     col1  col2  col3  col4
row1  a     1           1
row2  b     1     2     2
row3  a           3     1

Is translated to wide-colum store as follows


row1 -> (col1->a, col2->1, col4->1)
row2 -> (col1->b, col2->1, col3->2, col4->2)
row3 -> (col1->a, col3->3, col4->1)

Some examples of datastores that implement wide column store are Cassandra or HBase

Benefits:

- High performance and highly scalable architecture
- Fast to load and query

## Document databases

They use a common format (like JSON or XML) to model documents to store data. Each document will have an arbitrary schema, and can differ from one to another. This kind of stores allows to index common fields for faster performance.

They offer a reasonable good performance, and they are usually a straighforward replacement for a traditional relational database. 

Some examples of Document databases are MongoDB and CouchBase

## Key-value data store

They store data in unique key-value pairs. It works like a dictionary. This makes querying a key-value data store fast because of its simple model.

Some examples of Key-value data stores are Redis and Memcached.

## Graph database

Nodes and relationships are the bases of graph databases. A node represents an entity, and a relationship represents how two nodes are associated. They are usually the best approach for highly related domains, where entities are usually queried with others related.

Some examples of graph databases are Neo4j and JanusGraph
