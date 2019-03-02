# SOLID

It's an acronym for the first five object-oriented design principles

- S - Single responsibility principle
- O - Open-closed principle
- L - Liskov substitution principle
- I - Interface segregation principle
- D - Dependency Inversion Principle

## Single responsibility principle

A class should have one and only one job

## Open-closed principle

Objects or entities should be open for extension but closed for modification (a class should be easily extendable without modifying the class itself)

## Liskov substitution principle

Let q(x) be a property provable about objects x of type T. Then q(y) should be provable for objects y of type S, being S a subtype of T. Basically, it means that a derived class should be substitutable for their base class. 

Base classes then must define the methods that will be implemented in derived classes. That methods should be always meaningful, so derived classes should not have methods unimplemented or raise exceptions on non-meaningful methods (for example, the method "fly" in the bird class does not match any functionality in a "penguin" subclass, and then, fly method should be a method of another subclass called "fly capable birds" that penguin will not inherit from)

## Interface segregation principle

A client should never be forced to implement an interface that it doesn't use. Client shouldn't be forced to depend on methods they do not use. It means that each client should be exposed to exact contract it needs, without unneeded methods.

## Dependency inversion principle

High-level modules, which provide complex logic, should be easily reusable and unaffected by changes in low-level modules, which provide utility features. To achieve that, you need to introduce an abstraction that decouples the high-level and low-level modules from each other. 
