# Saga pattern

This patterns helps to solve the problem that arises in a microservices context, once an operation involves transactions from severl different services. Basically, it explains a way to maintain data consistency across services.

The solution here is to implement each business transaction that spans multiple services as a saga. A saga is a sequence of local transactions. Each local transaction updates the database an publishes a message or event to trigger the next transaction in the saga. If a local transaction fails, the saga executes a series of compensating transaction that undo the changes that were made by the preceding local transactions.

## Coordination

There are two ways of coordination sagas

- Choreography: each local transaction publishes domain events that trigger local transactions in other services
- Orchestration: an orchestrator tells the participants what local transactions to execute

## Benefits

- It enables an application to maintain data consistency across multiple services without using distributed transactions

## Drawbacks

- The programming model is more complex.
- A single service must atomically update its database and publish an event. It cannot use the traditional mechanism of a distributed transaction that spans the database and the message broker
