# Event sourcing

It tries to solve the problem to reliably/atomically update the database and publish events in a microservices architecture.

The proposed solution in event sourcingis to persist the state of a business entity as a sequence of state-changing events. Whenever the state of a business entity changes, a new event is appened to the list of events. Since saving an event is a single operation, is inherently atomic. The application reconstructs an entity's current state by replaying the events.

Applications presists events in an event store. THe store has an API for adding and retrieving an entitiy's events. The event store also behaves like a message broker. When a service saves an event in the event store, it is delivered to all interested subscribers.

It is a basic tool for Saga pattern

## Example

"Customers and orders" problem is a good example of an application that can be built using Event Sourcing. Each order will be stored as a chain of different events instead of a given model in a relational database. 

## Benefits

- Because it persists events rather than domain objects, it mostrly avoids the object-relational impedance mismatch problem
- Provides 100% reliable audit log

## Drawbacks

- Unfamiliar style of programming and step learning curve
- Event store is difficult to query
