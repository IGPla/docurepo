package main

import "fmt"

func main(){
	fmt.Println(maxfunc(10, 15))
}

func maxfunc(num1, num2 int) int {
     var result int
     if(num1 > num2) {
       result = num1
     } else {
       result = num2
     }
     return result
}
