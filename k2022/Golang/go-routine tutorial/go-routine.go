package main

import (
	"fmt"
	"sync"
	"time"
)

var wg sync.WaitGroup

func main() {
	wg.Add(2)      // go-routine 2개 추가
	go task1(1000) // go-rotine 1
	go task2(1000) // go-routine 2
	wg.Wait()      // go-routine이 종료될 때까지 대기
}

func task1(n_iter int) {
	for i := 1; i < n_iter; i++ {
		fmt.Println("AAAAAAAAAAAAAAAAAAAA")
		time.Sleep(time.Millisecond * 100)
	}
	wg.Done() // go-routine 종료
}

func task2(n_iter int) {
	for i := 1; i < n_iter; i++ {
		fmt.Println("ZZZZZZZZZZZZZZZZZZZ")
		time.Sleep(time.Millisecond * 100)
	}
	wg.Done() // go-routine 종료
}
