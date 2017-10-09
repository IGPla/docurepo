package main

import "strings"
import "fmt"

var print = fmt.Println

func main() {
	print("Repeat: ", strings.Repeat("abc", 3))
	print("Split: ", strings.Split("abc|def", "|"))
	print("Contains: ", strings.Contains("test", "tt"))
}
