package karma

import (
	"bufio"
	"encoding/csv"
	"fmt"
	"os"
	"strconv"
	"time"
)

func (mp *MyPV) CheckLoop(csvPath_qx string, csvPath_code string, csvPath_comb string, csvPath_expense string, csvPath_check string, csvPath_result string, intRate float64) {

	var s_time string                                                                  // 경과시간을 기록할 변수
	mp.initCombQx()                                                                    // 결합위험률 초기화
	mp.readCSV(csvPath_qx, csvPath_code, csvPath_comb, csvPath_expense, csvPath_check) // csv 파일 읽기

	csv_result, err := os.Create(csvPath_result) // 결과를 저장할 csv 파일 경로 열기
	if err != nil {
		panic(err)
	}

	csv_writer := csv.NewWriter(bufio.NewWriter(csv_result)) // writer 설정

	mp.setInterestRate(intRate) // 이자율 설정

	s_time = fmt.Sprintf("검증 Loop 시작 - %d:%d:%d", time.Now().Hour(), time.Now().Minute(), time.Now().Second())
	fmt.Println(s_time)

	for i, row := range mp.csv.csv_Check {

		mp.setContractInfo(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7]) // 계약정보 세팅
		mp.setCoverageInfo()                                                               // 담보정보 세팅
		mp.setExpense()                                                                    // 사업비세팅
		mp.makeCombQx()                                                                    // 결합위험률 생성
		mp.QxMapping()                                                                     // Qx mapping
		mp.initSymbols()                                                                   // 기수 초기화
		mp.calcSymbols()                                                                   // 기수 계산
		mp.calc_P()                                                                        // 순보험료 계산
		mp.calc_V()                                                                        // 준비금 계산

		// 결과 기록
		csv_writer.Write(mp.wrapUpResult())

		if (i+1)%5000 == 0 { // 5000 회 loop 돌 때마다 시간 print
			s_time = fmt.Sprintf("%d 번째 case -  %d:%d:%d", i+1, time.Now().Hour(), time.Now().Minute(), time.Now().Second())
			fmt.Println(s_time)
		}

	}

	s_time = fmt.Sprintf("검증 Loop 종료 - %d:%d:%d", time.Now().Hour(), time.Now().Minute(), time.Now().Second())
	fmt.Println(s_time)

	csv_writer.Flush() // writer 종료
}

// --------------- 결과 정리 --------------- //
func (mp *MyPV) wrapUpResult() []string {
	var wrapUp []string
	wrapUp = append(wrapUp, strconv.Itoa(mp.result.NP12))
	wrapUp = append(wrapUp, strconv.Itoa(mp.result.G12))
	for i := 0; i < 6; i++ {
		wrapUp = append(wrapUp, strconv.Itoa(mp.result.tVx[mp.contractInfo.x+i]))
	}
	return wrapUp
}
