# Go lang

## Tools

```
go COMMAND PARAMS
```

- fmt: format syntax content in all sources in a given package
- doc: documents a project, based on comments in each source


## Comments

Like the ones in python, comments can be used to document code. It accepts C-like comments (// and /**/). Comments preceding top-level declarations will be used as documentation by godoc

### Base doc: https://golang.org
### Program structure

```
package main

import "fmt"

func main() {
     fmt.Printf("hello world \n")
}
```

### Only capital variables will be exported in a given package
### Single quotes -> rune (char)
### Double quotes -> string
### Start point for a project is package main
### Line separator is a statement terminator. No need of special characters like ";"
### Data types

```
uint8 uint16 uint32 uint64 int8...
float32 float64 complex64 complex128
byte == uint8
rune == int32
```

### Variable declaration

```
var i, j, j uint32
var x = 20.0
```

### Variable initialization

```
d = 3, f = 5
n := 3 ; initialization of n as int and value 3
```

### Constant

```
const myvarname int = 32
```

### Operators: like C

```
&& || < > <= | ^ -= *= ...
&myvar -> return the address of a given var
*var -> pointer to variable
```

Go allows to work with pointers and references, like C, in the same way

### If, else, else if, switch and select (select is like switch with case statements are channel communications)

```
switch i {
       case 1:
       	    // code
       case 5, 6, 7:
       	    // code
	    ...
}
```

### loops

```
for a := 0; a < 10; a++ {}
for a < b {}
for i,x := range numbers {}
break, continue, goto "statement"
```

### Functions

```
func func_name(param1, param2...) return type {
     // body
}
func myfunc(vara int, varb string) int {
     // code here
}
func max(num1, num2 int) int {
     var result int
     if(num1 > num2) {
       result = num1
     } else {
       result = num2
     }
     return result
}
```

### Variadic functions: any number of arguments

```
func sum(nums ...int) {
     total := 0
     for _, num := range nums {
     	 total += num
     }
     fmt.Println(total)
}
```

### Lambda funcs

```
a := func(a, b int) int{
  return a+b
}
a(1,2)
```

### Closures

```
func getSequence() func() int {
     i:=0
     return func() int {
     	    i += 1;
	    return i;
     }
}
```

### Method: special functions called from a given "receiver"

That functions have the following signature:
func (varname vartype) funcname() returntype {
...
}
where vartype will be the receiver. It's much like methods in a given class on OO programming

```
type Circle struct {
   x,y,radius float64
}
func(circle Circle) area() float64 {
   return math.Pi * circle.radius * circle.radius
}
circle := Circle{x:0, y:0, radius:5}
circle.area()
```

### String: readonly slice of bytes

```
var greeting = "Hello world"
stored as bytes, so accessing greeting[1] will output a byte (hex representation = 65)
```

### String length
```
len(myvar)
```

### "strings" package

join method to join several strings

### Arrays

```
var varname [SIZE] vartype
var a[3] int
```

it allows inline initialization

```
var b = []float32{1.0, 2.0, 3.1, 4.1, 5.2}
```

multidimensional arrays

```
var varname [SIZE1][SIZE2] vartype
```

### Pointers and references: same as C

```
var myvar int = 3
var myvarpointer *int = &myvar
*myvarpointer = 4
```

"new" keyword allows to create a new pointer

```
x_ptr := new(int)
```

It allways create the variable and returns a pointer, even with structs

### Structs

```
type struct_name struct {
     varname1 vartype
     varname2 vartype
     ...
}
var myvar strunct_name
myvar.varname1 = ...
```

Using pointers, structs must be acceed by "." operator

```
var myvar1 *struct_name
...
myvar1.varname1 = ...
```

### Slices: flexible arrays

The following slice has 3 members and capacity for 5

```
var numbers = make([]int, 3)
var numbers = make([]int,3,5)
```

Aux functions: len (length) and cap (capacity)

Unspecified size slice

```
var numbers []int
```

Initialization

```
numbers := []int{0,1,2,3,4,5,6,7,8}
```

This previous slice has len = 9 and cap = 9

Slices allow to use slice notation

```
numbers[2:4]
numbers[:5]
```

Append new items

```
append(numbers, 1)
append(numbers, 2,3,4)
```

Copy one slice to another

```
copy(numbers1, numbers)
  copy from last to first (numbers into numbers1). numbers1 must be initialized
```

### Range: create a sequence of numbers based on an iterable. It returns both 

```
data := []int{2,4,6,8}
for i, num:= range data {
    // here code
}
```

### Map: maps unique keys to values

```
var map_var map[key_data_type]val_data_type
var mymap map[string]string{"a": "b", "c": "d"}
var mymap make(map[string]string)
mymap["first"] = "Mad"
```

You can test if entry is present

```
val, ok := mymap["Second"]
```

To remove an entry, use "delete"

```
delete(mymap, "first")
```

### Type casting

```
var sum int = 3
var casted float32 = float32(sum)
```

### Interfaces: named collections of method signatures. Abstraction to use "interface" calls instead of single objects all (in the next example, measure receives geometry instead of rect and circle, so you can define measure once and use with both objects)

```
type geometry interface {
    area() float64
    perim() float64
}
type rect struct {
    width, height float64
}
type circle struct {
    radius float64
}
func (r rect) area() float64 {
    return r.width * r.height
}
func (r rect) perim() float64 {
    return 2*r.width + 2*r.height
}
func (c circle) area() float64 {
    return math.Pi * c.radius * c.radius
}
func (c circle) perim() float64 {
    return 2 * math.Pi * c.radius
}
func measure(g geometry) {
    fmt.Println(g)
    fmt.Println(g.area())
    fmt.Println(g.perim())
}
func main() {
    r := rect{width: 3, height: 4}
    c := circle{radius: 5}
    measure(r)
    measure(c)
}
```

### Errors: usually returned as last resturn value (Idiomatic)

```
import "errors"
func Sqrt(value float64)(float64, error) {
   if(value < 0){
      return 0, errors.New("Math: negative number passed to Sqrt")
   }
   return math.Sqrt(value)
}
result, err:= Sqrt(-1)

if err != nil {
   fmt.Println(err)
}
```

### Common modules: (https://golang.org/pkg/#stdlib)

### goroutine: lightweight thread of execution

```
func f(from string) {
     for i := 0; i < 3; i++ {
     	 fmt.Println(from, ":", i)
     }
}
func main() {
     f("direct")
     go f("goroutine")
     go f("goroutine2")
     fmt.Println("done")
}
```

### channel: pipes that connect concurrent goroutines

  - Creation

```
messages := make(chan string)
```

Default channels have no buffering. So they block until a receiver consumes the value

  - Use

```
go func() {
   messages <- "ping"
}()
msg := <- messages
fmt.Println(msg)
```

Buffered channels

```
messages := make(chan string, 2) // buffered for 2 strings
```

Sync

Example of a sync until go routing finish

```
func worker(done chan bool){
     // do some stuff
     done <- true
}
func main() {
     done := make(chan bool, 1)
     go worker(done)
     <- done
}
```

It's possible to define a channel direction in a given function

```
func f1(chan1 chan<- string) {
     // code
}

func f2(chan1 <-chan string) {
     // code
}
```

f1 has chan1 for input and f2 has chan1 for output

Select is used to work with multiple channels. It works like switch

```
c1 := make(chan string)
c2 := make(chan string)
go func() {
   time.Sleep(time.Second*1)
   c1 <- "one"
}()
go func() {
   time.Sleep(time.Second*2)
   c1 <- "two"
}()
for i := 0; i < 2; i++ {
    select {
    	   case msg1 := <-c1:
	   	fmt.Println(msg1)
	   case msg2 := <-c2:
	   	fmt.Println(msg)2
    }
}
```

Timeouts: used with select to provide a timeout way and discard the channel that has not responded in time

```
c1 := make(chan string)
go func() {
   time.Sleep(time.Second*2)
   c1 <- "result from func"
}()
select {
       case res := <-c1:
       	    fmt.Prinln(res)
       case <-time.After(time.Second*1):
       	    fmt.Println("TIMEOUT")
}
```

Using a default in select allows non-blocking channel operations

```
select {
       case res := <- c1:
       	    	fmt.Println("Success")
       default:
		fmt.Println("Fail")
}
```

Closing a channel

```
mychan := make(chan string, 5)
...
close(mychan)
val, more := <- mychan // more is false if channel is closed
```

We can use range with channels. It's useful to iterate through all values in a channel, until it closes. If channel is empty but open, it blocks until it gets more tokens

```
queue := make(chan string, 2)
queue <- "a"
queue <- "b"
close(queue)
for elem := range queue {
    fmt.Println(elem)
}
```

### Timers: execute some code in the future. It provides a channel that will be notified at the time specified.

```
timer1 := time.NewTimer(time.Second * 2)
<- timer1.C
```

it waits 2 seconds and then consume the channel token

### Tickers: used to do something repeatedly at regular intervals

```
ticker := time.NewTicker(time.Millisecond * 500)
go func() {
        for t := range ticker.C {
            fmt.Println("Tick at", t)
        }
    }()
time.Sleep(time.Millisecond * 1600)
ticker.Stop()
```

### Worker pools: just set up goroutines that consume channels and block until new work is attached. Using range, we can achieve that once the channel is closed, worker can finish and end the goroutine

### Rate limiting (used on goroutines, channels and tickers)

channels can be limited by buffering

goroutines can be limited by time package, Tick function

```
limiter := time.Tick(time.Millisecond * 200)
<- limiter
```

Previous code will send a tick through limiter channel once every 200 millisecond.

### Atomic counters: lock structures to manipulate counters through different goroutines

```
import "sync/atomic"

var ops uint64 = 0

for i := 0; i < 50; i++ {
	go func() {
		for {
			atomic.AddUint64(&ops, 1)
		}
	}
}
time.Sleep(time.Second*2)
opsFinal := atomic.LoadUint64(&ops)
```

### Mutex: generic lock to access data safely across multiple goroutines

```
import (
	"sync"
	"sync/atomic"
	"time"
	"math/rand"
)
...
    var state = make(map[int]int)
	var mutex = &sync.Mutex{}
	
    for r := 0; r < 100; r++ {
        go func() {
            total := 0
            for {
                key := rand.Intn(5)
                mutex.Lock()
                total += state[key]
                mutex.Unlock()
                time.Sleep(time.Millisecond)
            }
        }()
    }
```

### Sorting

```
import "sort"
...
strs := []string{"c", "a", "b"}
sort.Strings(strs)
...
ints := []int{5,2,3}
sort.Ints(ints)
```

By function

```
type ByLength []string

func (s ByLength) Len() int {
    return len(s)
}
func (s ByLength) Swap(i, j int) {
    s[i], s[j] = s[j], s[i]
}
func (s ByLength) Less(i, j int) bool {
    return len(s[i]) < len(s[j])
}

func main() {
    fruits := []string{"peach", "banana", "kiwi"}
    sort.Sort(ByLength(fruits))
    fmt.Println(fruits)
}
```
### Panic: abort a program

```
import "fmt"

func main() {
	fmt.Println("Before")
	panic("a problem")
	fmt.Println("After")
}
```

### Defer: ensure that a function is performed later in a program's execution (like finally in other languages)

```
import "fmt"
import "os"

func main() {
	f := createFile("/tmp/defer.txt")
    defer closeFile(f)
    writeFile(f)
}
func createFile(p string) *os.File {
    fmt.Println("creating")
    f, err := os.Create(p)
    if err != nil {
        panic(err)
    }
    return f
}
func writeFile(f *os.File) {
    fmt.Println("writing")
    fmt.Fprintln(f, "data")
}
func closeFile(f *os.File) {
    fmt.Println("closing")
    f.Close()
}
```

In the previous example, closeFile will be performed at the end of main() (after writeFile(f))

### String manipulations lie in "strings" package

### String formatting lies in "fmt.Printf" function


```
type point struct {
    x, y int
}
p := point{1, 2}
fmt.Printf("%v\n", p)
fmt.Printf("%+v\n", p)
fmt.Printf("%e\n", 123400000.0)
...
```

### Regular expressions lies in "regexp" package

```
import "regexp"
match, _ := regexp.MatchString("p([a-z]+)ch", "peach")
r, _ := regexp.Compile("p([a-z]+)ch")
r.MatchString("peach")
```

### JSON

```
import "encoding/json"
fltB, _ := json.Marshal(2.34)

byt := []byte(`{"num":6.13,"strs":["a","b"]}`)
var dat map[string]interface{}
if err := json.Unmarshal(byt, &dat); err != nil {
    panic(err)
}
```

### Time

Several functions from time package

```
import "time"
...
now := time.Now()
then := time.Date(2009, 11, 17, 20, 34, 58, 651387237, time.UTC)
then.Year()
then.Weekday()
...
diff := now.Sub(then)
diff.Hours()
diff.Nanoseconds()
...
```

To get time from epoch

```
time.Unix()
time.UnixNano()
```

Time parsing / formatting

```
/* Format t */
t := time.Now()
t.Format(time.RFC3339) 
t.Format("3:04PM")
t.Format("2006-01-02T15:04:05.999999-07:00")

/* Parse */
t1, e := time.Parse(
        time.RFC3339,
        "2012-11-01T22:08:41+00:00")
```

### Random

```
import "math/rand"
rand.Intn(100)
rand.Float64()
```

### Number parsing

```
import "strconv"
f, _ := strconv.ParseFloat("1.234", 64)
d, _ := strconv.ParseInt("0x1c8", 0, 64)
i, _ := strconv.ParseInt("123", 0, 64)
u, _ := strconv.ParseUint("789", 0, 64)
```

### URL parsing

```
import "net"
import "net/url"
...
s := "http://mydomain.com/path1/path2?arg1=val1"
u, err := url.Parse(s)
u.Scheme
host, port, _ := net.SplitHostPort(u.Host)
u.Path
...
```

### Hashing

```
import "crypto/sha1"
h := sha1.New()
s := "sha1 this string"
h.Write([]byte(s))
bs := h.Sum(nil)
fmt.Println(bs)
```

### Base64

```
import "encoding/base64"
data = "abcd$#"
enc := base64.stdEncoding.EncodeToString([]byte(data))
dec_bytes := base64.stdEncoding.DecodeString(enc)
dec = string(dec_bytes)
```

### File handling

```
import "io"
import "io/ioutil"
/* Read file in memory */
dat, err := ioutil.ReadFile("/tmp/dat") 
/* Read only 5 bytes */
b1 := make([]byte, 5)
f, err := os.Open("/tmp/dat")
n1, err := f.Read(b1)
/* Always check for errors returned when working with files */
if err != nil {
	panic(err)
}
/* Change video pointer */
f.Seek(6, 0)
/* Buffered reader */
br := bufio.NewReader(f)
b4, err := br.Peek(5) /* Readed 5 bytes */
/* Closing */
f.Close()
```

```
/* WriteFile shortcut */
d1 := []byte("hello\ngo\n")
err := ioutil.WriteFile("/tmp/dat1", d1, 0644)
/* Open and write (both bytes and string) */
f, err := os.Create("/tmp/dat2")
d2 := []byte{115, 111, 109, 101, 10}
n2, err := f.Write(d2)
n3, err := f.WriteString("writes\n")
/* Use of buffered writer */
w := bufio.NewWriter(f)
n4, err := w.WriteString("buffered\n")
```

### Command line args

```
import "os"
args := os.Args /* Include program name as first argument */
```

```
import "flag"
...
wordPtr := flag.String("word", "foo", "a string")
numbPtr := flag.Int("numb", 42, "an int")
boolPtr := flag.Bool("fork", false, "a bool")
flag.Parse()
*wordPtr
*numbPtr
*boolPtr
```

### Env vars

```
import "os"
os.Setenv("FOO", 1)
os.Getenv("BAR")
```

### Procs

Spawning

```
import "io/ioutil"
import "os/exec"
...
dateCmd := exec.Command("date")
dateOut, err := dateCmd.Output()
...
grepCmd := exec.Command("grep", "hello")
grepIn, _ := grepCmd.StdinPipe()
grepOut, _ := grepCmd.StdoutPipe()
grepCmd.Start()
grepCmd.Write([]byte("Hello grep\nbye bye\n"))
grepIn.Close()
grepBytes, _ := ioutil.ReadAll(greOut)
grepCmd.Wait()
...
lsCmd := exec.Command("bash", "-c", "ls -a -l -h")
lsOut, err := lsCmd.Output()
```

Replacing process by another one (like a fork)

```
binary, lookErr := exec.LookPath("ls")
args := []string{"ls", "-a", "-l", "-h"}
env := os.Environ()
execErr := syscall.Exec(binary, args, env)
```

### Signal handling

Handling system signals

```
import "os/signal"
import "syscall"

sigs := make(chan os.Signal, 1)
done := make(chan bool, 1)
signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)
go func() {
     sig := <-sigs
     fmt.Println()
     fmt.Println(sig)
     done <- true
}()
<-done
```

### Exit

When calling exit, defers will not be run

```
os.Exit(1)
```

### GO projects

- A tipical GO workspace contains the following folders:
  - src (source files)
  - pkg (package objects)
  - bin (executable commands=
- go tool builds source packages and installs the resulting binaries to the pkg and bin directories
- src directory tipically contains version control repositories
- So 1 workspace for all GO projects, and 1 subfolder under src for every GO project
- GOPATH env var specifies your workspace directory

```
export GOPATH=$(go env GOPATH)
```

- For convenience, add workspace's bin directory to PATH

```
export PATH=$PATH:$(go env GOPATH)/bin
```

- Import path: base path for a package in src. Must be unique to prevent collisions.
- To create a binary, just use go install relateive/to/src/path/to/your/package

```
mkdir $GOPATH/src/github.com/user/hello
```

```
go install github.com/user/hello
```

or

```
cd $GOPATH/src/github.com/user/hello
go install
```

- To write a library, just add a new project in src, and use go build instead of go install

```
package stringutil

func Reverse(s string) string {
	r := []rune(s)
	for i, j := 0, len(r)-1; i < len(r)/2; i, j = i+1, j-1 {
		r[i], r[j] = r[j], r[i]
	}
	return string(r)
}
```

```
go build github.com/user/stringutil
```

```
import "github.com/user/stringutil"
...
stringutil.Reverse("my string")
```

- Go convention is that package name is the last element of the import path

- Executable commands must always use package main

### Testing

- Just create a filename ending in _test.go
- To create a test file for the previous stringutil library

stringutils_test.go in the same folder

```
package stringutil

import "testing"

func TestReverse(t *testing.T) {
	cases := []struct {
		in, want string
	}{
		{"Hello, world", "dlrow ,olleH"},
		{"Hello, 世界", "界世 ,olleH"},
		{"", ""},
	}
	for _, c := range cases {
		got := Reverse(c.in)
		if got != c.want {
			t.Errorf("Reverse(%q) == %q, want %q", c.in, got, c.want)
		}
	}
}
```

To test it

```
go test github.com/user/stringutil
```

### Remote packages

- Go can work with remote packages (ie the ones that exists in a remote repository for example).

```
go get github.com/golang/example/hello
$GOPATH/bin/hello
```

### Sync goroutines

The best way to sync goroutines (to wait until all them finish) is to use WaitGroup

```
import "sync"

var waitgroup sync.WaitGroup

waitgroup.Add(1)
go func(){
	defer waitgroup.Done()
	....
}()
...
waitgroup.Wait()
```

### Getting help

To get help about a package or a given function, use godoc

```
godoc fmt Println
```

The previous example prints information about Println function in fmt package

### Common packages / common functions

#### Strings

```
import "strings"

strings.Contains("test", "es")
strings.HasPrefix("test", "te")
strings.Count("test", "t")
strings.Index("test", "s")
strings.Replace("aaaa", "a", "b", 2)
```

#### Files

```
# Common case: open, read and close
import "os"

# Open file
file, err := os.Open("myfile.txt")
if err != nil {
	...
}
# Defer file close
defer file.Close()
# Get file information
stat, err := file.Stat()
# Read the file
bs := make([]byte, stat.Size())
_, err = file.Read(bs)
str := string(bs)
```

```
# Shorter way
import "io/ioutil"

bs, err := ioutil.ReadFile("myfile.txt")
str := string(bs)
```

```
# Create file
import "os"

file, err := os.Create("myfile.txt")
defer file.Close()
file.WriteString("test")
```

```
# Get contents of a directory
import "os"

dir, err := os.Open(".")
defer dir.Close()
fileInfos, err := dir.Readdir(-1)
for _, fi := range fileInfos {
	...
}
```

```
# Recursive walk a folder
import "os"
import "path/filepath"

filepath.Walk(".", func(path string, info os.FileInfo, err error) error {
	...
})
```

#### Errors

Go has a built-in error type. We can create new ones.

```
import "errors"

err := errors.New("error message")
```

#### Other collections

Under "container" package, there are several containers like "list" (double-linked list)

```
import "container/list"

var mylist list.List
mylist.PushBack(10)
...
for e := mylist.Front(); e != nil; e = e.Next() {
	...
}
```

#### Sort

Sort package allows to sort arbitrary data.

#### Hashes and cryptography

- non-cryptographic
  - adler32, crc32, crc64, fnv
  
```
import "hash/crc32"

h := crc32.NewIEEE()
h.Write([]byte("test"))
v := h.Sum32()
```

- cryptographic

```
import "crypto/sha1"

h := sha1.New()
h.Write([]byte("test"))
v := h.Sum([]byte{})
```

#### TCP Server

```
import (
  "encoding/gob"
  "fmt"
  "net"
)

func server() {
  // listen on a port
  ln, err := net.Listen("tcp", ":9999")
  if err != nil {
    fmt.Println(err)
    return
  }
  for {
    // accept a connection
    c, err := ln.Accept()
    if err != nil {
      fmt.Println(err)
      continue
    }
    // handle the connection
    go handleServerConnection(c)
  }
}

func handleServerConnection(c net.Conn) {
  // receive the message
  var msg string
  err := gob.NewDecoder(c).Decode(&msg)
  if err != nil {
    fmt.Println(err)
  } else {
    fmt.Println("Received", msg)
  }

  c.Close()
}

func client() {
  // connect to the server
  c, err := net.Dial("tcp", "127.0.0.1:9999")
  if err != nil {
    fmt.Println(err)
    return
  }

  // send the message
  msg := "Hello World"
  fmt.Println("Sending", msg)
  err = gob.NewEncoder(c).Encode(msg)
  if err != nil {
    fmt.Println(err)
  }

  c.Close()
}

func main() {
  go server()
  go client()

  var input string
  fmt.Scanln(&input)
}
```

#### HTTP Server

```
import ("net/http" ; "io")

func hello(res http.ResponseWriter, req *http.Request) {
  res.Header().Set(
    "Content-Type",
    "text/html",
  )
  io.WriteString(
    res,
    `<DOCTYPE html>
<html>
  <head>
      <title>Hello World</title>
  </head>
  <body>
      Hello World!
  </body>
</html>`,
  )
}
func main() {
  http.HandleFunc("/hello", hello)
  http.ListenAndServe(":9000", nil)
}
```

#### RPC Server

```
import (
  "fmt"
  "net"
  "net/rpc"
)

type Server struct {}
func (this *Server) Negate(i int64, reply *int64) error {
  *reply = -i
  return nil
}

func server() {
  rpc.Register(new(Server))
  ln, err := net.Listen("tcp", ":9999")
  if err != nil {
    fmt.Println(err)
    return
  }
  for {
    c, err := ln.Accept()
    if err != nil {
      continue
    }
    go rpc.ServeConn(c)
  }
}
func client() {
  c, err := rpc.Dial("tcp", "127.0.0.1:9999")
  if err != nil {
    fmt.Println(err)
    return
  }
  var result int64
  err = c.Call("Server.Negate", int64(999), &result)
  if err != nil {
    fmt.Println(err)
  } else {
    fmt.Println("Server.Negate(999) =", result)
  }
}
func main() {
  go server()
  go client()

  var input string
  fmt.Scanln(&input)
}
```

#### Database drivers

continue from http://go-database-sql.org/importing.html



### Interesting links

https://golang.org/cmd/

https://golang.org/pkg/#stdlib

