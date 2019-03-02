# Event loop and reactor

## Event loop

It waits for and dispatches events or messages in a program. 

It works by making a request to some internal or external event provider and it calls the relevant event handler.

The event loop almost always operates asynchronously with the message originator.

## Reactor

It's a design pattern for event handling. It handles requests delivered concurrently to a service handler by one or more inputs. The service handler then demultiplexes the incoming requests and dispatches them synchronously to the associated request handlers.
