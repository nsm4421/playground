package main

import (
	"fmt"
	"log"
	"os"

	"github.com/go-gota/gota/dataframe"
)

func main() {

	const csvFilePath = "./iris.csv"     // csv 파일 경로
	csvFile, err := os.Open(csvFilePath) // csv 파일 열기
	if err != nil {                      // csv 파일 여는 도중 오류가 생기면
		log.Fatal(err) // error 출력
	}
	defer csvFile.Close()

	// (1) csv ---> dataframe
	df := dataframe.ReadCSV(csvFile)
	// fmt.Println(df)

	// (2) shape
	// fmt.Println(df.Dims())

	// (3) Columns
	// fmt.Println(df.Names())

	// (4) Slicing - filtering with specific row
	// filter := dataframe.F{
	// 	Colname:    "variety",
	// 	Comparator: "==",
	// 	Comparando: "Setosa",
	// }
	// setosaData := df.Filter(filter)
	// if setosaData.Err != nil {
	// 	log.Fatal(setosaData.Err)
	// }
	// fmt.Println(setosaData)
	// fmt.Println(setosaData.Dims())

	// filter := dataframe.F{
	// 	Colname:    "sepal.width",
	// 	Comparator: ">",
	// 	Comparando: 3,
	// }
	// largerThanThree := df.Filter(filter)
	// if largerThanThree.Err != nil {
	// 	log.Fatal(largerThanThree.Err)
	// }
	// fmt.Println(largerThanThree)

	// (5) Select - select specific columns
	// selectedData := df.Select([]string{"sepal.width", "variety"})
	// fmt.Println(selectedData)

	// (6) Subset
	subsetData := df.Subset([]int{20: 30})
	fmt.Println(subsetData)

}
