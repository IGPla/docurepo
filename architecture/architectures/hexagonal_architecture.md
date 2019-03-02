# Hexagonal architecture

The main goal of this architecture is to allow that a given application will be used in the same way by users, other programs, tests, scripts and all actors involved in their life cycle, being that application developed and tested isolately. It is achieved by decoupling the base implementation (domain) from the use cases. Each use case will define a port. Thus, our domain will expose an API, and each port will interface with it to define an external usage (through HTTP, SOAP or whatever format is required), that will be used by external agents through adapters (that will be the provided libraries /protocols to use a given port)

## Concepts

Also known as Ports and Adapters architecture, this compilation of good practices define the boundaries of your software through the following concepts:

- Domain: decoupled logic. Here lies your application, and defines a common interface for all ports 
- Port: public interface definition
- Adapter: Specialization of a port for a given context

They used all together enforce the separation and encapsulation of the logic in different application layers. It enhances the testability of the code and allows to grow in a cleaner manner.

It is also well known that fits very well in Domain Driven Design principles.
