# SQL

Structured Query Language: Way to store data, in a structured way, with all facilities to query, insert, update and modify that data.

## Concepts

- Integrity: ensures integrity of data
  - Entity: no duplicates
  - Domain: restricting colummn type, format, range of values...
  - Referential: rows cannot be deleted while referenced by other records
  - User-defined: specific business defined rules
- Normalization: efficiently organizing data in a database, removing redundant data and ensuring data dependencies make sense (reducing amount of space a database consumes). More information in http://phlonx.com/resources/nf3/
  - First normal form
  - Second normal form
  - Third normal form

## Syntax

- Each command will ends with semicolon

## Data types

- Exact numeric
  - bigint, int, smallint, tinyint, bit
  - decimal, numeric
  - money, smallmoney
- Approximate numeric
  - float, real
- Date / time
  - datetime, smalldatetime, date, time
- Strings
  - char, varchar, text
- Unicode strings
  - nchar, nvarchar, ntext
- Binary 
  - binary, varbinary, image

## Operators

All common operators for numeric (+, -, *, /) and comparison (=, !=, <, !<...)

Logical operators: ALL (compare value to all values), AND, ANY, BETWEEN, EXISTS (searchs the presense of a tow in a table that meets a criterion), IN, NOT, OR, IS NULL, UNIQUE

## Commands

### Data definition language

- CREATE: creates table, view or other objects

```
CREATE DATABASE mydb;
CREATE TABLE mytable (
	column1 bigint,
	column2 varchar(12) NOT NULL,
	...
	PRIMARY KEY(column1)
);
```

- ALTER: modifies db object (such as a table)

```
ALTER TABLE mytable ADD mycolumn3 text;
ALTER TABLE mytable DROP COLUMN mycolumn1;
ALTER TABLE mytable MODIFY COLUMN mycolumn2 varchar(30) NOT NULL;
```

- USE: selects a database

```
USE mydb;
```

- SHOW: list objects

```
SHOW DATABASES;
```

- DROP: deletes table, view or other objects

```
DROP TABLE mytable;
```

- TRUNCATE: delete all data from an object

```
TRUNCATE TABLE mytable;
```


### Data manipulation

- SELECT: query db

```
SELECT col1, col2 FROM mytable WHERE col1 = 5;
```

- INSERT: insert record

```
INSERT INTO mytable (col1, col2) VALUES (val1, val2);
```

- UPDATE: modifies records

```
UPDATE mytable SET col1 = val1, col2 = val2 WHERE col1 < 10;
```

- DELETE: deletes records

```
DELETE FROM mytable WHERE col1 > 20;
```

### Data control language

- GRANT: gives privileges to a user
- REVOKE: removes privileges granted to a user

## Constraints

- NOT NULL
- DEFAULT
- UNIQUE
- PRIMARY Key
- FOREIGN Key
- CHECK: ensures that all values in a column satisfy certain conditions
- INDEX: software structure to enhance queries over a given field (increasing cost on inserts / updates)

## Select

Select is the main use, and the richest command in SQL.

SELECT [DISTINCT] {selectors} FROM {tables} [WHERE {conditions}] [GROUP BY {group\_cols}] [ORDER BY {order\_cols}]

- selectors: can be column names, expressions and *

```
SELECT *
SELECT col1, col2
SELECT col1 as mycol, 2+3 as a_sum
```

- tables: tables to search records

```
SELECT * FROM mytable1, mytable2;
```

- conditions: conditions to choose which records to retrieve

```
SELECT * FROM mytable WHERE (col1 > 20 AND col2 = "HAR") OR col1 = 15;
```

- order_cols: columns to be ordered by. Optional. It can be set as ASC (ascendent order) or DESC (descendent order). It accepts conditionals

```
SELECT * FROM mytable ORDER BY col1, col2 ASC;
SELECT * FROM mytable ORDER BY (CASE col1 WHEN 2 THEN 1, WHEN 5 then 2, WHEN 10 then 3 ELSE 4 END) ASC, col2 DESC;
```

- group_cols: columns to be grouped. Its useful to use in conjunction with aggregation commands like COUNT

```
SELECT col1, SUM(col2) FROM mytable GROUP BY col1;
```

HAVING conditions is a common keyword used in conjunction with GROUP BY, that allows to filter groups

```
SELECT col1, SUM(col2) FROM mytable GROUP BY col1 HAVING SUM(col2) > 10;
```

- DISTINCT: remove duplicate records

### Where

It's a must to list the main options that can be used in where. We will show the most common apart from basic ones (comparisons, ands and ors)

- LIKE: selects the records that match a wildcard part of the like parameter
  - col1 LIKE 'XXX%': col1 match XXX plus 0, 1 or more characters
  - col1 LIKE 'XXX_': col1 match XXX plus 1 character
  - col1 LIKE '%XXX%': col1 match 0, 1 or more characters plus XXX plus 0, 1 or more characters
- TOP, LIMIT: Not all RDBMS accept both. They all do the same: limit the output of the SELECT query.
  - SELECT * FROM mytable LIMIT 3;
  - SELECT TOP 3 * FROM mytable;
- NULL: to check for nulls, use IS NULL or IS NOT NULL
  
### Joins

A whole chapter must be used to explore joins. It is used to combine two or more tables in query. It combines fields between tables and then output the records that match that combinations.

```
SELECT col1, col2 FROM table1, table2 WHERE table1.col1 = table2.colx;
```

If there are several matches for a given record on left table, it will appear duplicated for each match on right table.

Types of join:

- INNER JOIN: returns rows when there's a match in both tables
- LEFT JOIN: returns all rows from the left table, even if there are not matches in the right table. So, if there's a match, records of left table and right table will be filled; if not, records of left table will still appear, and fields from right table will be NULL
- RIGHT JOIN: same as previous one, but for right table
- FULL JOIN: return rows when there is a match in one of the tables
- SELF JOIN: is used to join a table to itself
- CARTESIAN JOIN: cartesian product of the sets of records from two or more joined tables

Examples of join:

```
SELECT t1.col1, t2.col2 FROM t1 INNER JOIN t2 ON t1.colx = t2.coly;
SELECT t1.col1, t2.col2 FROM t1 LEFT JOIN t2 ON t1.colx = t2.coly;
```

### Unions

Combines results of two or more SELECT statements without duplicating records

```
SELECT col1 FROM t1 
UNION
SELECT col2 FROM t2;
```

### Alias

Use alias to rename (or give a name) to select items. Keyword is AS

```
SELECT col1 AS mycol FROM mytable;
```

## Indexes

Use indexes to create a software index over a column (or columns) that will enhance queries on that column. It comes at cost of longer inserts/updates (they must recalculate the index on every change)

You can create index

```
CREATE INDEX myindex ON mytable (col1);
```

Unique indexes does not allow any duplicate values 

```
CREATE UNIQUE INDEX myindex ON mytable (col1);
```

And drop index

```
DROP INDEX myindex;
```

## View

It's a SQL statement stored in the database, with an associated name. It's a kind of virtual tables.

A view can be created

```
CREATE VIEW myview AS
SELECT col1, col2
FROM t1
WHERE col1 > 3;
```

And queried

```
SELECT * FROM myview;
```

## Transactions

Unit of work that must be accomplished in a logical order.

Properties (ACID):

- Atomicity
- Consistency
- Isolation
- Durability

Control:

- COMMIT: save changes
- ROLLBACK: discard changes
- SAVEPOINT: creates a point in which to ROLLBACK
- SET TRANSACTION: places a name on a transaction

```
DELETE FROM customers WHERE age = 25;
ROLLBACK;

DELETE FROM customers WHERE age = 25;
COMMIT;

SAVEPOINT mysavepoint;
ROLLBACK TO mysavepoint;

RELEASE SAVEPOINT mysavepoint;
```

## Dates

There are several functions to work with dates and times. Some of them are listed below:

- CURRENT_DATE (CURDATE): returns the current date
- DATE_ADD: adds two dates
- DAYNAME: name of the weeekday

## Subquery

Query inside another query. 

```
SELECT col1 
FROM t1
WHERE col1 IN (
	SELECT id
	FROM t2
	WHERE col2 > 10
)
```

They can be used in conjunction of INSERT and UPDATE statements

## Sequences

A set of integers that are generated in order, on demand. Very usefull to be used as primary keys.

```
CREATE TABLE mytable (
	id INT NOT NULL AUTO_INCREMENT,
	...
	PRIMARY KEY (id)
);
```

## Tips

- Indexes should not be used on small tables
- Don't use indexes on tables with frequent large updates/insert
- Don't use indexes on columns with high number of NULL values

