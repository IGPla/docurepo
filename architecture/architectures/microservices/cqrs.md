# CQRS

Command Query Responsibility Segregation offers a solution for the given problem:

How to implement a query that retrieves data from multiple services in a microservice architecture?

The solution is to define a view database, which is a read-only replica that is designed to support that query. The application keeps the replica up to date by subcribing to domain events published by the services that owns the data.

It is often used with event sourcing

## Benefits

- Supports multuiple denormalized views that are scalable and performant
- Improved separation of concerns imply simpler commands and query models
- It is necessary in an event sourced architecture

## Drawbacks

- Increased complexity
- Potential code duplication
- Replication lag / eventually consistent views
