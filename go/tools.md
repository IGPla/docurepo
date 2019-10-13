# Go common utilities

## Test

Go test have a lot of different capabilities in order not only to test code but to test reliability, find race conditions and many other uses

### Stress testing

In order to run a test many times, you can do it sequentially or in parallel

Sequential

```
go test ./... -count=100
```

Parallel

```
GO111MODULE=on go get golang.org/x/tools/cmd/stress

# Compile binary first
go test -c -o=/tmp/foo.test .

# Run stress tool
stress -p=4 /tmp/foo.test
```

### Trace

Trace information about current test execution

Generation

```
go test ./... -trace=/tmp/trace.out
```

Check

```
go tool trace /tmp/trace.out
```

### Race detector

In order to detect race conditions, you can enable race detector during tests execution

```
go test ./... -race
```

### Coverage

Generate and check test coverage

Quick summary

```
go test ./... -cover
```

Generation

```
go test ./... -coverprofile=/tmp/cover.out
```

Check

```
go tool cover -func=/tmp/cover.out
```

### Profiling

Generate and view profiling, based on tests. Several profiling views are available, and all them will be viewed in the following commands. Note that you may only generate and view one or few of them. It would be better to use them with benchmarks, as they are more realistic cases based on your code than tests.

Generation

```
go test ./... -outputdir=/tmp -blockprofile=block.out -cpuprofile=cpu.out -memprofile=mem.out -mutexprofile=mutex.out
```

Check

```
go tool pprof /tmp/block.out
go tool pprof /tmp/cpu.out
go tool pprof /tmp/mem.out
go tool pprof /tmp/mutex.out
```

### Benchmarking

Benchmark your application. It requires to write specific benchmark code

Call

```
go test ./... -bench=.
```

If memory must be benchmarked too

```
go test ./... -bench=. -benchmem
```

## Go modules

Modules is the new way (Go 1.12+) to develop go projects. It allows to put any project at any folder in your filesystem and keep track of all pinned dependencies

To initialize a module

```
go mod init my/module/name
```

## Linters and static analysis

### Static analysis

Golang implements go vet in the standard tools

```
go vet ./...
```

### Linter

Go lint is a linter tool for source code

To install

```
go get -u golang.org/x/lint/golint
```

To use

```
golint ./...
```

### Online checker

A tool that runs different linters and checkers against a repository 

```
https://goreportcard.com
```

## Go extra tools

Standard Golang github account holds supplementary tools and libraries

```
https://github.com/golang
```
