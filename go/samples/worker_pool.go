package main

import "fmt"
import "time"

const num_workers int = 3;
const num_jobs int = 5;

func worker(workerid, jobs, results) {
	for j := range jobs {
		fmt.Println("Worker ", workerid, )
	}
}

func main(){
	jobs := make(chan int, 100)
	results := make(chan int, 100)
	
	for w := 1; w < num_workers; w++{
		go worker(w, jobs, results)
	}
}
