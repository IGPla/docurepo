# Design patterns

This is a quick overview of the main patterns, classified by type

## Creational patterns

Patterns that deal with object creation mechanisms

- Abstract factory: Provide an interface for creating families of related or dependent objects without specifying their concrete classes
- Builder: Separate the construction of a complex object from its representation so that the same construction process can create different representations
- Factory method: Define an interface for creating an object, but let subclasses decide which class to instantiate, allowing a class to defer instantiation to subclasses
- Object pool: Offer a significant performance boost; it is most effective when the cost of initializing an instance is high, the rate of instantiation of a class is high and the number of instantiations in use at any one time is low
- Prototype: Create new objects by copying a prototype with all specifications set.
- Singleton: Ensure a class has only one instance, and provide a global point to access to it

## Structural patterns

They exists to ease the design by identifying a simple way to realize relationships between entities.

- Adapter: Convert the interface of a class into another interface that a client expects. It lets classes work together that couldn't otherwise due to incompatible interfaces
- Bridge: Decouple an abstraction from its implementation, so that the two can vary independently. Publish interface in an inheritance hierarchy, and let implementation in its own inheritance hierarchy.
- Composite: Compose objects into tree structures to represent whole-part hierarchies. It leads to complex objects seen as tree-composed from other simpler objects
- Decorator: Attach additional responibilities to an object dynamically. It provides a flexible alternative to subclassing. It just wraps object with a decorator, providing pre and post conditions to the default functionality
- Facade: It defines a higher-level interface, unifying other lower-level interfaces that makes the subsystems easier to use
- Flyweight: Remove or reduce redundancy when a large number of objects with the same information exists. It decouples redundant information into another class and links it to concrete data being in the current objects, leading into a decrease of size of concrete objects.
- Private class data: Control write access to class attributes
- Proxy: An object representing another object. Provide a placeholder for another object to conrtol access to it. Very useful to encapsulate functionality into a set of rules on how to use it.

## Behavioral patterns

Identify common communication patterns between objects

- Chain of responsibility: Avoid coupling the sender and the receiver of a request by giving more than one object a chance to handle the request. It chains the request to each available object until one of them process the request.
- Command: Encapsulate a request as an object, allowing to encapsulate request data into methods, providing an abstract layer between the request and the client.
- Interpreter: Given a language, define a representation for its grammar along with an interpreter that uses the representation to interpret sentences in the language. It's useful to define, for example, a language to represent regular expressions
- Iterator: Provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation
- Mediator: Define an object that encapsulates how a set of objects interact. Promotes loose coupling by keeping objects from referring to each other explicitly, and it lets the developer vary their interaction independently
- Memento: Withour violating encapsulation, capture and externalize an object's internal state so that the object can be returned to this state later
- Null object: Encapsulate the abscense of an object by providing a substitutable alternative that offers suitable default do nothing behavior
- Observer: Given a dependency from A to B, instead of polling from A the changes on B, let B notify A when a change occurs.
- State: Allow an object to alter its behavior when its internal state changes. 
- Strategy: Define a family of algorithms, encapsulate each one, and make them intechangeable. It allows the algorithm vary independently from the clients that use it
- Template method: Define the skeleton of an algorithm in an operation, deferring some steps to client subclasses.

