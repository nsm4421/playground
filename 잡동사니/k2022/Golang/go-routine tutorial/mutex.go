package main

import (
	"fmt"
	"sync"
	"time"
)

type Wallet struct {
	money int
}

var wg sync.WaitGroup

var mx sync.Mutex

func main() {

	const n_iter = 1000
	wallet := Wallet{1000}

	wg.Add(n_iter)

	for i := 0; i < n_iter; i++ {
		go plusAndMinus(&wallet)
	}

	wg.Wait()

	fmt.Printf("남은 잔액은 %d", wallet.money)
}

func plusAndMinus(w *Wallet) {

	mx.Lock()
	defer mx.Unlock()

	if w.money < 1000 { // 돈이 1000원 미만이면 파산
		panic("파산")
	}

	w.money += 100               // 100원 +
	time.Sleep(time.Microsecond) // 0.1초 sleep
	w.money -= 100               // 100원 -

	wg.Done()
}
