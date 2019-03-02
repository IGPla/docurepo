# Domain driven design

DDD is an approach for software development, focused on a rich model, expresive and constantly evolving.

It empowers the concept of Ubiquitous language, between domain experts and software experts, providing an environment where missleading concepts will be avoided.

There are many architectures that use DDD concepts (for example, hexagonal architecture)

## Concepts

- Domain: topic/s or field/s where we build software
- Domain model: concepts, terms and key words about domain. It identifies the relations between entities in the domain, identify attributes and provide an structural view of domain
- Entities: Model objects that has an identity (for example, given a Person entity, even if two people have the same attributes, they will be different because they have different identities). Basically, they are not identified by their attributes but by their identity.
- Value objects: Model objects without an identity. For example, given a Color value, it will be meaningful by its RGB pointers, and not by an arbitrary identifier.
- Services: Operations, actions or activities that are not owned conceptually to any domain object
  - Domain services: responsibles of the specific domain behaviour (for example, create user)
  - Application services: responsibles to coordinate entities, value objects, domain services and infrastructure services (for example, perform a payment)
  - Infrastructure services: responsibles of operations that are not domain specific (for example, log transactions)
