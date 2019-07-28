# Golang best practices

In this document you will find a compilation of my best practices for Go projects

## Static code analyzers

Always use a static code analyzer (such as Go vet, included in Go standard tools) that will help you write maintainable and correct code, based on common best practices
There are other alternatives such as GolangCI

## Format code

Use always the built in code formatter gofmt. It will keep your code clear and consistent.

## Always return error as the last value

It's a common practice to keep errors as the last value

## Build always a constructor

Use the NewT pattern to create constructors for all your structs. It will guarantee that your data is always controlled in a way that was intended to.

## Use interfaces whenever possible

Interfaces allow your code to be maintainable and testable, and they come with a cheap cost (in terms of performance)

## Avoid global states

Pass loggers, configs and similar dependencies to contructor functions. Don't take them from a global variable (global state makes code untestable)

## Chain errors

If you have several errors chained, use errors.Wrap to chain them. It will provide a stack trace of all errors with the 

## Use table tests

Table tests are an strategy where you define all your test instances for a given test case in a table, and iterate it in order to apply each instance to all assertiongs

## Use stretchr/testify

It provides several utils that will help you to have more robust / easy to code tests (asserts, requires, mocks...)

## Write mocks/stubs in the testing package

Always keep track of all mocks an stubs in your testing package 

## Black box testing (when possible)

It's a good practice to perform black box testing (test a given package from another package) to ensure that external package API will perform as expected

## Stress the use of defer

Use defer when possible, guaranteeing that your code will be completed (all open resources will be closed)

## Channels / mutex

Channels are a good abstraction model, and they are the preferred use for goroutines. However, there will be situations where a struct with a mutex will be simpler and faster. Simpler and faster implementations are always preferred over complex and hard to understand ones.

## Use context.Context for arbitrary data on middlewares

Take context.Context as the first parameter when writing a middleware library, so people can pass arbitrary data through your API

## Take context.Context for cancellation

When you're dealing with asynchronous code, take context.Context as the first parameter and make your code respect its cancellation

## Let only producers close a channel

And try to provide consumers with read-only channels

## Use Go modules for dependency management

It's the community preferred way to deal with dependencies

## Avoid reflection

Whenever possible

## Test and benchmark your code

Test for validity, benchmark to be sure that the performance is what you expect

## More links on best practices

Below you can find several links on best practices that are worth to read

https://dave.cheney.net/practical-go/presentations/qcon-china.html
https://peter.bourgon.org/go-best-practices-2016/
