# MongoDB

## Concepts

- Database: container for collections. Own set of files in the filesystem.
- Collection: group of documents. Equivalent to RDBMS table
- Document: set of key-value pairs. Equivalent to RDBMS row, but schemaless.
- Field: key in a document. Equivalent to RDBMS column

## Install

The following snippet descibes a sample installation for debian linux, MongoDB version 3.4. For other platforms or versions, refer to official documentation. Common steps will be similar but versions may differ

```
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
apt-get update
apt-get install -y mongodb-org
```

## Data modeling

Modeling data in NoSQL environments usually leads to different approachs than traidtional ones from RDBMS. Joins do not exists, and simulate them can lead to scenarios with poor performance. Denormalization, replicating data where needed, and following a schema design based on use cases will output a fast and reliable data model.

## Document example

```
{
	_id: ObjectId(7df78ad8902c),
	title: 'my title',
	url: 'http://myurl.com',
	points: 45
}
```

_id is a 12 bytes hexadecimal number, unique for every document in a collection. If it is not provided, mongodb will create it
4 bytes timestamp, 3 bytes machine id, 2 bytes process id, 3 bytes incrementer

## Querying database

All starts with db.mycollections.find. It receives a dictionary with all conditions and outputs a list of matching documents

### Agg

#### Pipeline

Pipeline will work in ordered way, as defined. Take it into account to define a well path of aggregation (for example, filter before sort to get faster results)

db.collection.aggregate(...)

Main available parameters (more information in https://docs.mongodb.com/manual/reference/operator/aggregation-pipeline/)

- $match: match fields and values
- $limit: limits the number of documents
- $count: return the number of documents
- $group: group documents by a field
- $out: write the results into a collection
- $project: reshapes each document in the stream, adding/removing fields
- $sort: sort results by field

Examples:

We will use the following collection (named mycollection) to demonstrate aggregations

```
{
	"my_id_field": "A1",
	"field1": 200,
	"field2": "Ac"
},
{
	"my_id_field": "A1",
	"field1": 400,
	"field2": "Rj"
},
{
	"my_id_field": "A2",
	"field1": 100,
	"field2": "Rj"
},
{
	"my_id_field": "A1",
	"field1": 300,
	"field2": "Rj"
}
```

```
db.mycollection.aggregate([
	{$match: {field2: "Rj"}},
	{$group: {_id: "$my_id_field", mytotal: {$sum: $field1}}
]) 

Results are:

{
	"_id": "A1",
	"mytotal": 700
},
{
	"_id": "A2",
	"mytotal": 100
}

```


## Replication

Replication allows MongoDB to create an environment of high availability. It synchronizes data across multiple servers, providing redundancy and data availability. It is called "Replica sets" in MongoDB. In replica sets, one node is the primary and the others are secondaries. All data replicates from primary to secondaries. When a primary fails, election establishes a new primary. After the failed node recovers, it joins again to the replica set and works as a secondary node. 

Features: any node can be primary, write operations go to primary, automatic failover, automatic recovery

Start a replicaset

```
mongod --port 27017 --dbpath /tmp/db/data --replSet rs0
```

The previous example starts a replicaset rs0 on port 27017 


## Deployment

Automating your deployment will be the best way to keep out problems in your production environment. Load testing, monitoring and backups will be required to be resilent.

### Monitoring

Use mongostat and mongotop to keep system monitored

### Backups

Use mongodump and mongorestore to create backups and restore them

## Util commands

- mongo: mongo client. Start a shell connected to mongodb (more parameters exists to connect to remote mongodb instances)
- mongostat: will check status of all running mongod instances and will return information about database operations.
- mongotop: tracks and reports the read and write activity of MongoDB
- mongodump: creates a dump (all database, single database, single collection...)
- mongorestore: loads a dump into MongoDB

## Util client commands

### Database

- db.stats(): using it in mongo client, it shows stats about current database
- show dbs: show all databases
- use DATABASE_NAME: change to DATABASE_NAME database. If it does not exists, it will be automatically created
- db.dropDatabase(): drops the current database

### Collections

- db.createCollection(name, options): creates collection
- show collections: show collections in the current selected database
- db.mycollection.drop(): drop mycollection

### Documents

- db.mycollection.insert(...): insert a new document into mycollection. If it does not exists, it will be automatically created. Accepts a document or a list of documents
- db.mycollection.find(...): query data from mycollection
- db.mycollection.find(...).pretty(): shows query in a formatted way

