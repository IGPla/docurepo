package main

import "fmt"

func main() {
	fmt.Println("Before")
	panic("a problem")
	fmt.Println("After")
}
