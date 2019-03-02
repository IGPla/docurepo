# API Gateway

This pattern tries to solve the following problem:

How do the clients of a microservices-based application access all individual services?

Basically, it provides a single API entry point for all clients. The API gateway handles request in the following ways:

- They can be proxied/routed to the appropiate service
- They can be fan out to multiple services

## Benefits

- Insulates the clients from how the application is partitioned into microservices
- Insulates the clients from the problem of determining the locations of services instances
- Provides the optimal API for each client
- Reduces the number of requests/roundtrips
- Simplifies the client by moving logic for calling multiple services from client to API gateway

## Drawbacks

- Increased complexity
- Increased response time
- Potential single point of failure
