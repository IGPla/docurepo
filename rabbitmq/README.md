# RabbitMQ

## Installation

Add RabbitMQ repository public key

```
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
```

Add APT repository

```
echo 'deb http://www.rabbitmq.com/debian/ testing main' | tee /etc/apt/sources.list.d/rabbitmq.list
```

Install it

```
apt-get update && apt-get install rabbitmq-server -y
```

## Management

Main management command

```
service rabbitmq-server start/stop/status
```

### Configuration

RabbitMQ allows configuration through environment variables, configuration file and runtime parameters.

Useful environment variables:

- RABBITMQ_NODE_PORT (default 5672): node port
- RABBITMQ_NODE_IP_ADDRESS (default binded to all network interfaces) : node ip
- RABBITMQ_NODE_NAME (default rabbit@HOSTNAME): node name, unique, identifier in cluster
- RABBITMQ_CONF_ENV_FILE: path to env file (another way to define all environment variables)

More information in https://www.rabbitmq.com/configure.html

### Concepts

- Producer: entity that sends messages
- Consumer: entity that receives messages created by producers
- Queue: basic storage box for messages. It's essentially a message buffer
- Exchange: entity that receives messages from producers and publish them to queues. There is a default exchange, "". Types:
  - direct: a message goes to queues whose binding key exactly matches the routing key of the message
  - topic: arbitrary routing keys (each one must be a list of words delimited by dots). Limited to 255 bytes. Same as direct by with wildcards (* for 1 word, # for 0 or more words)
  - headers: same as topic, but instead of using routing key, it uses message headers
  - fanout: broadcasts all the messages it receives to all queues it knows
- Messages can never be sent directly to the queue; they must allways go through an exchange
- delivery_mode: manages persistence of messages
  - 2: message is persistent
- Message ack: if a consumer dies before sending back ack, message is rescheduled to another worker.
  - no_ack = True -> disables message ack
- Quality of service: TODO
- Binding: is the relationship between an exchange and a queue

## Defaults

RabbitMQ has several defaults.

- Port 4369: epmd, peer discovery service

## Utils

- rabbitmq environment: shows all configured values in rabbitmq
- rabbitmq list_queues: list existing queues
- rabbitmq list_exchanges: list existing exchanges
- rabbitmq list_binding: list existing bindings

## Usage

Several languages are supported through official plugins. Here will be shown all examples in python.

#### Persistence

- Queue index: responsible for maintaining knowledge. One queue index per queue
- Message store: key-value store for messages, shared among all queues in the server.

### Working code examples

For python, just install rabbitmq python client "pika" (pip install pika)

Common import

```
import pika
```

#### Deliver each message to exaclty one consumer

This case, only 1 queue is defined, and each message is consumed for one consumer.

```
P -> Q -> C1
       -> C2
```

Producer

```
connection = pika.BlockingConnection(pika.ConnectionParameters(host="RABBITMQ_SERVER_HOST"))
channel = connection.channel()
queue_name = "QUEUE_NAME"
channel.queue_declare(queue=queue_name, durable=True)
channel.basic_publish(exchange='',
	routing_key=queue_name,
	body="SAMPLE MESSAGE",
	properties=pika.BasicProperties(
		delivery_mode=2
	))
connection.close()
```

Consumer

```
connection = pika.BlockingConnection(pika.ConnectionParameters(host='RABBITMQ_SERVER_HOST'))
channel = connection.channel()
queue_name = "QUEUE_NAME"
channel.queue_declare(queue=queue_name, durable=True)

def callback(ch, method, properties, body):
    ## CALLBACK BODY. DO WHATEVER YOU WANT WITH MESSAGE (body)
	ch.basic_ack(delivery_tag = method.delivery_tag)
	
channel.basic_qos(prefetch_count=1)
channel.basic_consume(callback,
                      queue=queue_name)
channel.start_consuming()
```

- For "basic_consume" to work, queue must exist.
- Consumer exposes a callback function to consume all data provided by queue. It does that in a never ending loop

#### Publish/Subscribe: each message to all consumers

This case, 1 exchange publish to N queues (1 per consumer) the same message. Then each consume will consume the same message

```
P -> E -> Q1 -> C1
       -> Q2 -> C2
```


Producer

```
connection = pika.BlockingConnection(pika.ConnectionParameters(host='RABBITMQ_SERVER_HOST'))
channel = connection.channel()

exchange = 'EXCHANGE_NAME'

channel.exchange_declare(exchange=exchange,
                         exchange_type='fanout')

message = "test message"
channel.basic_publish(exchange=exchange,
                      routing_key='',
                      body=message)
connection.close()
```

Consumer

```
connection = pika.BlockingConnection(pika.ConnectionParameters(host='RABBITMQ_SERVER_HOST'))
channel = connection.channel()

exchange = 'EXCHANGE_NAME'

channel.exchange_declare(exchange=exchange,
                         exchange_type='fanout')

result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

channel.queue_bind(exchange=exchange,
                   queue=queue_name)

def callback(ch, method, properties, body):
	## Do something with body

channel.basic_consume(callback,
                      queue=queue_name,
                      no_ack=True)

channel.start_consuming()
```

#### Routing: routing keys filters messages

Routing allows to send messages filtered by keys. That keys allows segmentation about which messages should or should not be delivered to a given consumer

```
P -> E -(key1)> Q1 -> C1
       -(key2)> Q2 -> C2
       -(key3)> Q2 -> C2
       -(key4)> Q1 -> C1
```

Producer

```
connection = pika.BlockingConnection(pika.ConnectionParameters(host='RABBITMQ_SERVER_HOST'))
channel = connection.channel()

exchange = "EXCHANGE_NAME"

channel.exchange_declare(exchange=exchange,
                         exchange_type='direct')
message1 = 'test message'
key1 = 'testkey1'
channel.basic_publish(exchange=exchange,
                      routing_key=key1,
                      body=message1)
message2 = 'test message 2'
key2 = 'testkey2'
channel.basic_publish(exchange=exchange,
                      routing_key=key2,
                      body=message2)
connection.close()
```

Consumer

```
connection = pika.BlockingConnection(pika.ConnectionParameters(host='RABBITMQ_SERVER_HOST'))
channel = connection.channel()

exchange = "EXCHANGE_NAME"

channel.exchange_declare(exchange=exchange,
                         exchange_type='direct')

result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

key = "testkey1"

channel.queue_bind(exchange=exchange,
	               queue=queue_name,
                   routing_key=key)

def callback(ch, method, properties, body):
	## Do something with body

channel.basic_consume(callback,
                      queue=queue_name,
                      no_ack=True)

channel.start_consuming()
```

#### Topics

Topics are a way to categorize messages and receive full or partial categories. Each routing key now will have a list of names, dot separated, and will allow wildcards

```
P -> E -(a.b.c)> Q1 -> C1
       -(a.b.*)> Q2 -> C2
       -(a.b.d)> Q2 -> C2
       -(a.#)> Q1 -> C1
```

Producer

```
connection = pika.BlockingConnection(pika.ConnectionParameters(host='RABBITMQ_SERVER_HOST'))
channel = connection.channel()

exchange = "EXCHANGE_NAME"

channel.exchange_declare(exchange=exchange,
                         exchange_type='topic')

routing_key = "a.b.c.d"
message = "test message"
channel.basic_publish(exchange=exchange,
                      routing_key=routing_key,
                      body=message)
connection.close()
```

Consumer

```
connection = pika.BlockingConnection(pika.ConnectionParameters(host='RABBITMQ_SERVER_HOST'))
channel = connection.channel()

exchange = "EXCHANGE_NAME"

channel.exchange_declare(exchange=exchange,
                         exchange_type='topic')

result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

channel.queue_bind(exchange=exchange,
	               queue=queue_name,
                   routing_key="a.b.#")
	
def callback(ch, method, properties, body):
    ## Do something with body

channel.basic_consume(callback,
                      queue=queue_name,
                      no_ack=True)

channel.start_consuming()
```
