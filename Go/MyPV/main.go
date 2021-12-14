package main

import (
	karma "my-pv/src"
)

func main() {

	var mp karma.MyPV

	mp.CheckLoop("./Data/Qx.csv", "./Data/Code.csv", "./Data/Comb.csv", "./Data/Expense.csv", "./Data/Check.csv", "./result.csv", 0.025)
}
