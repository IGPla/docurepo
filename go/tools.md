# # Go common utilities

## Trace

Trace information about current test execution

Generation

```
go test ./... -trace=/tmp/trace.out
```

Check

```
go tool trace /tmp/trace.out
```

## Coverage

Generate and check test coverage

Generation

```
go test ./... -coverprofile=/tmp/cover.out
```

Check

```
go tool cover -func=/tmp/cover.out
```

## Profiling

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

## Benchmarking

Benchmark your application. It requires to write specific benchmark code

Call

```
go test ./... -bench=.
```

If memory must be benchmarked too

```
go test ./... -bench=. -benchmem
```


