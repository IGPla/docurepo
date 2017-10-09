package main

import "fmt"

func main() {
	mychan := make(chan int)
	mychan <- 10
	val := <- mychan
	fmt.Println(val)
}
