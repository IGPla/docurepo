# HADOOP

## Description

Ecosystem to perform big data analysis (cut data into small portions to compute them in a parallel/distributed way)

## Base packages

- Common: utilities, libraries and modules, all required to start Hadoop
- YARN: job scheduling and cluster resource management
- HDFS: distributed file system
- MapReduce: algorithm for parallel processing of large data sets

## Other components and tools:

- Hadoop streaming: utility to code MapReduce in other languages than Java (Python, C...)
- Hive and Hue: code SQL and it will translate to MapReduce jobs
- Pig: high level environment to code MapReduce
- Sqoop: bidirectional data tranference between Hadoop and relational databases
- Oozle: manage Hadoop work flow.
- HBase: nosql database, key-value store. Like a dictionary in Python
- FlumeNG: real time loader to move your data to Hadoop. Store data in HDFS and HBase.
- Whirr: Hadoop cloud cluster management.
- Mahout: machine learning in Hadoop.
- Fuse: manage HDFS like a normal file system (expose commands like ls, rm...)
- Zookeeper: manage cluster synchronization 

## MapReduce framework

- JobTracker: single master. Responsible for resource management, tracking resource consumption/availability, scheduling jobs to slaves, monitoring, re-executing failed tasks. Single point of failure
- TaskTracker: one slave per cluster-node. Responsible of executing tasks, provide task-status information

## HDFS

- File is split into several blocks, and those blocks are stored in a set of DataNodes.
- NameNode determines the mapping of blocks to DataNodes
  - Manages filesystem namespace
  - Regulates client's access to files
  - Executes filesystem operations such as renaming, closing/opening files
- DataNode takes care of read and write operations, block creation, deletion and replication based on instructions given by NameNode
  - Perform block creation/deletion and replication 
- Block: file segments (each file is splitted into segments), of BLOCKSIZE (64MB by default). This is the minimum amount of data HDFS can read or write
- Fault detection and recovery
- Allows huge datasets


## Steps

- Submit a job to the Hadoop job client (providing the location of the input and output files in HDFS, providing the java classes in the form of jar containing the implementation of map and reduce functions, provide the job configuration with all parameters) 
- Hadoop job client submits the job and configuration to JobTracker, and it distributes the software/configuration to slaves, scheduling tasks, monitoring them and providing status and diagnostic information to job client
- TaskTrackers execute the task and output of the reduce function is stored into the output files

## Setup

TODO: to be completed. Basic setup and use from docker

## Hadoop operation modes

- Standalone: by default, run as a single java process
- Pseudo distributed: distributed simulation on single machine. Useful for development
- Fully distributed: minimum of two machines in a cluster, production environment

