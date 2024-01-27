package karma

import (
	"bufio"
	"encoding/csv"
	"fmt"
	"log"
	"os"
)

func getDataFromCSV(csvPath string) [][]string {
	csvFile, err := os.Open(csvPath) // csv 파일 열기
	if err != nil {
		log.Fatal(err) // error 출력
	}
	defer csvFile.Close()
	reader := csv.NewReader(bufio.NewReader(csvFile))
	data, err := reader.ReadAll()
	if err != nil {
		log.Fatal(err)
	}
	return data[1:][:] // 머릿글 제거
}

func (mp *MyPV) readCSV(csvPath_qx string, csvPath_code string, csvPath_comb string, csvPath_expense string, csvPath_check string) {
	mp.csv.csv_Qx = getDataFromCSV(csvPath_qx)           // 위험률 csv
	mp.csv.csv_Code = getDataFromCSV(csvPath_code)       // 코드 csv
	mp.csv.csv_Check = getDataFromCSV(csvPath_check)     //  검증대상건 csv
	mp.csv.csv_Comb = getDataFromCSV(csvPath_comb)       // 결합위험률 csv
	mp.csv.csv_Expense = getDataFromCSV(csvPath_expense) // 사업비 csv
	s_path := fmt.Sprintf("위험률 csv : %s | 코드 csv : %s | 결합위험률 csv : %s | 사업비 csv : %s | 대상건 csv : %s | \n 파일을 읽음",
		csvPath_qx, csvPath_code, csvPath_comb, csvPath_expense, csvPath_check)
	fmt.Println(s_path)
}
