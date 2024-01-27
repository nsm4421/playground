package main

import (
	"bufio"
	"encoding/csv"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
	"time"
)

func main() {

	var mp MyPV // 검증모듈

	mp.checkLoop("./data/Qx.csv", "./data/Code.csv", "./data/Comb.csv", "./data/Expense.csv", "./data/Check.csv", "./result.csv", 0.025)
	time.Sleep(100000000000)

}

// --------------- Struct 정의 --------------- //

// csv files
type csvData struct {
	csv_Qx      [][]string
	csv_Code    [][]string
	csv_Check   [][]string
	csv_Comb    [][]string
	csv_Expense [][]string
}

// 계약정보
type contractInfo struct {
	coverageKey string  // 담보키
	coverage    string  // 담보코드
	x           int     // 가입연령
	sex         int     //성별
	n           int     // 보험기간
	m           int     //납입기간
	AMT         float64 // 가입금액
	injure      int     //상해급수
	driver      int     // 운전자급수
	i           float64 //이자율
	v           float64 // 할인율
	expense     expense
}

// 사업비
type expense struct {
	alpha1 float64
	alpha3 float64
	beta1  float64
	beta2  float64
	gamma  float64
	ce     float64
	Srate  float64
}

// 위험률 배열
type qx_arr struct {
	qx [120]float64
}

// 탈퇴율(exit), 급부율(benefit), 납면율(grant)
type Qx struct {
	Ex     [10]qx_arr
	Bx     [10]qx_arr
	Gx     qx_arr
	combQx combQx
}

// 담보정보
type coverageInfo struct {
	numBenefit    int         // 급부개수
	exitCode      [10]string  //탈퇴율코드
	exitType      [10]string  //탈퇴율Type
	nonCov        [10]int     //부담보기간
	benefitCode   [10]string  //급부율코드
	benefitType   [10]string  //급부율Type
	payRate       [10]float64 //지급률
	reduceRate    [10]float64 //감액률
	reducePeriod  [10]int     //감액기간
	grantCode     string      //납면율코드
	grantType     string      //납면율Type
	invalidPeriod int         //무효해지기간
}

// 기수식
type symbols struct {
	lx      [10][120]float64
	lxPrime [120]float64
	Dx      [120]float64
	DxPrime [120]float64
	Nx      [120]float64
	NxPrime [120]float64
	Cx      [10][120]float64
	Mx      [10][120]float64
	SUMx    [120]float64
}

// 계산결과
type result struct {
	NP1_full    float64 // 年납 순보 (full)
	NP12_full   float64 // 月납 순보 (full)
	G1_full     float64 // 年납 영보 (full)
	G12_full    float64 // 月납 영보 (full)
	NP1         int     // 年납 순보 (round)
	NP12        int     // 月납 순보 (round)
	G1          int     // 年납 영보 (round)
	G12         int     // 月납 영보 (round)
	tVx_full    [120]float64
	tVx         [120]int
	alpha_std   int // 표준 알파
	alpha_apply int // 적용 알파
}

// 결합위험률
type combQx struct {
	qx map[string]qx_arr
}

// 검증모듈
type MyPV struct {
	csv          csvData      // 데이터 (csv파일)
	contractInfo contractInfo // 계약정보
	coverageInfo coverageInfo // 급부정보
	Qx           Qx           //탈퇴율, 급부율, 납면율
	symbols      symbols      // 기수식
	result       result       //계산결과
}

// --------------- 모든 결과 print --------------- //
func (mp *MyPV) printAll(coverage string, x string, sex string, n string, m string, AMT string, injure string, driver string, i float64) {
	// setting & calculation
	mp.setContractInfo(coverage, x, sex, n, m, AMT, injure, driver) // 계약정보 setting
	mp.setCoverageInfo()                                            // 담보정보 setting
	mp.setInterestRate(i)                                           // 이자율 setting
	mp.setExpense()
	mp.initCombQx()        // combQx 초기화
	mp.makeCombQx()        // 결합위험률 생성
	mp.QxMapping()         // 탈퇴율/급부율/납면율 mapping
	mp.calcSymbols()       //기수계산
	mp.calc_P()            //순보험료계산
	mp.calc_V()            //준비금계산
	mp.printContractInfo() // 계약정보 print
	mp.printCoverageInfo() // 담보정보 print
	mp.printQx()           // 탈퇴율/급부율/납면율 mapping
	mp.printSymbol("lx")   // 기수식 print
	mp.printSymbol("l'x")
	mp.printSymbol("Dx")
	mp.printSymbol("D'x")
	mp.printSymbol("Cx")
	mp.printSymbol("Mx")
	mp.printSymbol("SUMx")
	mp.printExpense() // 사업비
	mp.printResult()  // 보험료,준비금
}

// --------------- CSV 파일 읽기 --------------- //

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

// --------------- 검증 Loop --------------- //

func (mp *MyPV) checkLoop(csvPath_qx string, csvPath_code string, csvPath_comb string, csvPath_expense string, csvPath_check string, csvPath_result string, intRate float64) {

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

// --------------- 예정이율 세팅 --------------- //
func (mp *MyPV) setInterestRate(i float64) {
	mp.contractInfo.i = i
	mp.contractInfo.v = 1 / (1 + i)
}

// --------------- 계약정보 세팅 --------------- //
func (mp *MyPV) setContractInfo(coverage string, x string, sex string, n string, m string, AMT string, injure string, driver string) {
	mp.contractInfo.coverage = coverage
	mp.contractInfo.x, _ = strconv.Atoi(x)
	mp.contractInfo.sex, _ = strconv.Atoi(sex)
	mp.contractInfo.n, _ = strconv.Atoi(n)
	mp.contractInfo.m, _ = strconv.Atoi(m)
	mp.contractInfo.AMT, _ = strconv.ParseFloat(AMT, 64)
	mp.contractInfo.injure, _ = strconv.Atoi(injure)
	mp.contractInfo.driver, _ = strconv.Atoi(driver)
	// 담보키 매핑
	if mp.contractInfo.injure != 0 {
		mp.contractInfo.coverageKey = mp.contractInfo.coverage + "_" + injure
	} else if mp.contractInfo.driver != 0 {
		mp.contractInfo.coverageKey = mp.contractInfo.coverage + "_" + driver
	} else {
		mp.contractInfo.coverageKey = mp.contractInfo.coverage
	}
}

// --------------- 계약정보 출력 --------------- //
func (mp *MyPV) printContractInfo() {
	s := fmt.Sprintf("담보명 : %s | 담보키 : %s | 가입연령 : %d |  성별코드 : %d |보험기간 : %d | 납입기간 : %d | 가입금액 : %.0f | 상해급수 : %d | 운전자급수 : %d",
		mp.contractInfo.coverage, mp.contractInfo.coverageKey, mp.contractInfo.x, mp.contractInfo.sex, mp.contractInfo.n, mp.contractInfo.m,
		mp.contractInfo.AMT, mp.contractInfo.injure, mp.contractInfo.driver)
	fmt.Println(s)
}

// --------------- 담보정보 mapping --------------- //
func (mp *MyPV) setCoverageInfo() {

	bNum := 0
	mp.coverageInfo.numBenefit = 0

	for _, row := range mp.csv.csv_Code {
		if row[0] == mp.contractInfo.coverageKey {
			bNum, _ = strconv.Atoi(row[1]) // 급부번호
			// 납면
			if bNum == 99 {
				mp.coverageInfo.grantCode = row[10]
				mp.coverageInfo.grantType = row[11]
				mp.coverageInfo.invalidPeriod, _ = strconv.Atoi(row[12])
				break
			} else {
				// 탈퇴
				mp.coverageInfo.exitCode[bNum] = row[2]
				mp.coverageInfo.exitType[bNum] = row[3]
				mp.coverageInfo.nonCov[bNum], _ = strconv.Atoi(row[4])
				if bNum != 0 {
					// 급부지급
					mp.coverageInfo.numBenefit += 1
					mp.coverageInfo.benefitCode[bNum] = row[5]
					mp.coverageInfo.benefitType[bNum] = row[6]
					mp.coverageInfo.payRate[bNum], _ = strconv.ParseFloat(row[7], 64)
					mp.coverageInfo.reduceRate[bNum], _ = strconv.ParseFloat(row[8], 64)
					mp.coverageInfo.reducePeriod[bNum], _ = strconv.Atoi(row[9])
				}
			}
		}
	}

	if mp.coverageInfo.numBenefit == 0 { // 급부를 못 물면 에러 출력
		log.Fatal(mp.contractInfo.coverageKey, "에 해당하는 급부 개수가 0개")
	}
}

// --------------- 담보정보 출력 --------------- //
func (mp *MyPV) printCoverageInfo() {
	for i := 0; i < mp.coverageInfo.numBenefit+1; i++ {
		// 탈퇴정보
		s_exit := fmt.Sprintf("Exit(%d) | ExitCode : %s | ExitType : %s | NonCov : %d",
			i, mp.coverageInfo.exitCode[i], mp.coverageInfo.exitType[i], mp.coverageInfo.nonCov[i])
		// 급부정보
		s_benefit := fmt.Sprintf("Benefit(%d) | BenefitCode : %s | BenefitType : %s | PayRate : %0.3f | ReduceRate : %0.3f | ReducePeriod : %d",
			i, mp.coverageInfo.benefitCode[i], mp.coverageInfo.benefitType[i], mp.coverageInfo.payRate[i], mp.coverageInfo.reduceRate[i],
			mp.coverageInfo.reducePeriod[i])
		fmt.Println(s_exit)
		if i != 0 {
			fmt.Println(s_benefit)
		}
	}
	// 납면정보
	s_grant := fmt.Sprintf("Grant | GrantCode : %s | GrantType : %s | InvalidPeriod : %d",
		mp.coverageInfo.grantCode, mp.coverageInfo.grantType, mp.coverageInfo.invalidPeriod)
	fmt.Println(s_grant)
}

// --------------- 사업비 세팅 --------------- //
func (mp *MyPV) setExpense() {
	mappinged := false
	for _, row := range mp.csv.csv_Expense {

		if row[0] == mp.contractInfo.coverageKey {
			mp.contractInfo.expense.alpha1, _ = strconv.ParseFloat(row[mp.contractInfo.n], 64)
			mp.contractInfo.expense.alpha3, _ = strconv.ParseFloat(row[6], 64)
			mp.contractInfo.expense.alpha3 = mp.contractInfo.expense.alpha3 / 1000 // 대천알파
			mp.contractInfo.expense.beta1, _ = strconv.ParseFloat(row[7], 64)
			mp.contractInfo.expense.beta2, _ = strconv.ParseFloat(row[8], 64)
			mp.contractInfo.expense.gamma, _ = strconv.ParseFloat(row[9], 64)
			mp.contractInfo.expense.ce, _ = strconv.ParseFloat(row[10], 64)
			mp.contractInfo.expense.Srate, _ = strconv.ParseFloat(row[11], 64)
			mappinged = true
			break
		}
	}
	if !mappinged {
		log.Fatal(mp.contractInfo.coverageKey, " 담보 사업비가 mapping 되지 않음")
	}
}

// --------------- 사업비 print --------------- //
func (mp *MyPV) printExpense() {
	var s_expense string
	e := mp.contractInfo.expense
	s_expense = fmt.Sprintf("alpha1 : %0.4f | alpha3 : %0.4f | beta1 : %0.4f | beta2 : %0.4f | gamma : %0.4f | ce : %0.4f | S : %0.4f",
		e.alpha1, e.alpha3, e.beta1, e.beta2, e.gamma, e.ce, e.Srate)
	fmt.Println(" =============== 사업비 ================== ")
	fmt.Println(s_expense)
}

// --------------- 위험률키로 위험률배열 채우기 --------------- //
func (qx_arr *qx_arr) getQxWithKey(csv_qx [][]string, riskKey string, sex int) {
	var x int
	var q float64

	if riskKey == "" {
		for t := 0; t < 120; t++ {
			qx_arr.qx[t] = 0.
		}
	} else {
		for i, row := range csv_qx {
			if riskKey == row[0] {
				if row[1] == "ZZ" { // 단일률
					q, _ = strconv.ParseFloat(row[1+sex], 64)
					for x = 0; x < 120; x++ {
						qx_arr.qx[x] = q
					}
					break
				} else {
					x, _ = strconv.Atoi(row[1])
					q, _ = strconv.ParseFloat(row[1+sex], 64)
					qx_arr.qx[x] = q
				}
			} else {
				// break 조건
				if i > 0 {
					if (csv_qx[i-1][0] == riskKey) && (csv_qx[i][0] != riskKey) {
						break
					}
				}
			}
		}
	}
}

// --------------- 결합위험률  --------------- //
func (mp *MyPV) initCombQx() {
	mp.Qx.combQx.qx = map[string]qx_arr{}
}

func (mp *MyPV) makeCombQx() {

	var qx1, qx2, qx_comb qx_arr
	var rKey1, rKey2, rCombKey string

	for i, row := range mp.csv.csv_Comb {
		// break 조건
		if i > 0 {
			if (mp.csv.csv_Comb[i-1][0] == mp.contractInfo.coverageKey) && (row[0] != mp.contractInfo.coverageKey) {
				break
			}
		}
		if row[0] == mp.contractInfo.coverageKey {

			rKey1 = row[3]
			period1, _ := strconv.ParseFloat(row[4], 64)
			rKey2 = row[5]
			period2, _ := strconv.ParseFloat(row[6], 64)
			rCombKey = row[1]

			comb_q1, exists1 := mp.Qx.combQx.qx[rKey1]

			comb_q2, exists2 := mp.Qx.combQx.qx[rKey2]

			if exists1 {
				qx1 = comb_q1

			} else {
				qx1.getQxWithKey(mp.csv.csv_Qx, rKey1, mp.contractInfo.sex)

			}

			if exists2 {
				qx2 = comb_q2
			} else {
				qx2.getQxWithKey(mp.csv.csv_Qx, rKey2, mp.contractInfo.sex)
			}

			if row[2] == "1" {
				qx_comb = sumQx(mp.contractInfo.x, mp.contractInfo.n, qx1, qx2, period1, period2)
				mp.Qx.combQx.qx[rCombKey] = qx_comb
			} else {
				qx_comb = productQx(mp.contractInfo.x, mp.contractInfo.n, qx1, qx2, period1, period2)
				mp.Qx.combQx.qx[rCombKey] = qx_comb
			}
		}
	}

}

func sumQx(x int, n int, qx1 qx_arr, qx2 qx_arr, period1 float64, period2 float64) qx_arr {
	var qx_comb qx_arr
	for t := x; t < x+n+1; t++ {
		if t == x {
			qx_comb.qx[t] = qx1.qx[t]*(1-period1/12) + qx2.qx[t]*(1-period2/12)
		} else {
			qx_comb.qx[t] = qx1.qx[t] + qx2.qx[t]
		}
	}
	return qx_comb
}

func productQx(x int, n int, qx1 qx_arr, qx2 qx_arr, period1 float64, period2 float64) qx_arr {
	var qx_comb qx_arr
	for t := x; t < x+n+1; t++ {
		if t == x {
			qx_comb.qx[t] = 1 - (1-qx1.qx[t]*(1-period1/12))*(1-qx2.qx[t]*(1-period2/12))
		} else {
			qx_comb.qx[t] = 1 - (1-qx1.qx[t])*(1-qx2.qx[t])
		}
	}
	return qx_comb
}

// --------------- 탈퇴율(Ex), 급부율(Bx), 납면율(Gx) mapping --------------- //
func (mp *MyPV) QxMapping() {

	sex := mp.contractInfo.sex
	injure := mp.contractInfo.injure
	driver := mp.contractInfo.driver
	numBenefit := mp.coverageInfo.numBenefit
	haveToMakeCombQx := false

	var eCode, bCode, gCode, eKey, bKey, gKey string

	for i := 0; i < numBenefit+1; i++ {

		// 탈퇴위험률키(exit) mapping
		eCode = mp.coverageInfo.exitCode[i]
		switch mp.coverageInfo.exitType[i] {
		case "I":
			eKey = eCode + "_" + strconv.Itoa(injure)
		case "D":
			eKey = eCode + "_" + strconv.Itoa(driver)
		case "C":
			haveToMakeCombQx = true
			eKey = eCode
		default:
			eKey = eCode
		}

		// 탈퇴 배열 채우기
		if haveToMakeCombQx {
			mp.Qx.Ex[i] = mp.Qx.combQx.qx[eKey]
			haveToMakeCombQx = false
		} else {
			mp.Qx.Ex[i].getQxWithKey(mp.csv.csv_Qx, eKey, sex)
		}

		if i > 0 {
			// 급부율(benefit) 위험률키 mapping
			bCode = mp.coverageInfo.benefitCode[i]
			switch mp.coverageInfo.benefitType[i] {
			case "I":
				bKey = bCode + "_" + strconv.Itoa(injure)
			case "D":
				bKey = bCode + "_" + strconv.Itoa(driver)
			case "C":
				haveToMakeCombQx = true
				bKey = bCode
			default:
				bKey = bCode
			}

			// 급부율 배열 채우기
			if haveToMakeCombQx {
				mp.Qx.Bx[i] = mp.Qx.combQx.qx[bKey]
				haveToMakeCombQx = false
			} else {
				mp.Qx.Bx[i].getQxWithKey(mp.csv.csv_Qx, bKey, sex)
			}
		}
	}

	// 납면(grant) 위험률키 mapping
	gCode = mp.coverageInfo.grantCode
	switch mp.coverageInfo.grantType {
	case "I":
		gKey = gCode + "_" + strconv.Itoa(injure)
	case "D":
		gKey = gCode + "_" + strconv.Itoa(driver)
	case "C":
		haveToMakeCombQx = true
		gKey = gCode
	default:
		gKey = gCode
	}

	// 납면 위험률 배열 채우기
	if haveToMakeCombQx {
		mp.Qx.Gx = mp.Qx.combQx.qx[gKey]
	} else {
		mp.Qx.Gx.getQxWithKey(mp.csv.csv_Qx, gKey, sex)
	}

}

func (mp *MyPV) printQx() {
	x := mp.contractInfo.x
	n := mp.contractInfo.n

	for i := 0; i < mp.coverageInfo.numBenefit+1; i++ {
		fmt.Println(" =============== 탈퇴율 ================== ")
		fmt.Println(mp.Qx.Ex[i].qx[x : x+n+1])
	}
	for i := 1; i < mp.coverageInfo.numBenefit+1; i++ {
		fmt.Println(" =============== 급부율 ================== ")
		fmt.Println(mp.Qx.Bx[i].qx[x : x+n+1])
	}
	fmt.Println(" =============== 납면율 ================== ")
	fmt.Println(mp.Qx.Gx.qx[x : x+n+1])
}

// --------------- 기수식 초기화 --------------- //
func (mp *MyPV) initSymbols() {
	for t := 0; t < 120; t++ {
		for i := 0; i < 10; i++ {
			mp.symbols.lx[i][t] = 0
			mp.symbols.Cx[i][t] = 0
			mp.symbols.Mx[i][t] = 0
		}
		mp.symbols.lxPrime[t] = 0
		mp.symbols.Dx[t] = 0
		mp.symbols.DxPrime[t] = 0
		mp.symbols.NxPrime[t] = 0
		mp.symbols.SUMx[t] = 0
		mp.result.tVx_full[t] = 0
		mp.result.tVx[t] = 0
	}
}

// --------------- 기수식 계산 --------------- //
func (mp *MyPV) calcSymbols() {

	if mp.contractInfo.v == 0 {
		log.Fatal("이자율이 세팅되지 않음")
	}

	x := mp.contractInfo.x
	n := mp.contractInfo.n

	numBenefit := mp.coverageInfo.numBenefit

	// lx 계산
	for bNum := 0; bNum < numBenefit+1; bNum++ {
		mp.symbols.lx[bNum][x] = 100000
		for t := x; t < x+n+1; t++ {
			if t == x {
				mp.symbols.lx[bNum][t+1] = mp.symbols.lx[bNum][t] * (1 - mp.Qx.Ex[bNum].qx[t]*float64(1-mp.coverageInfo.nonCov[bNum]/12))
			} else {
				mp.symbols.lx[bNum][t+1] = mp.symbols.lx[bNum][t] * (1 - mp.Qx.Ex[bNum].qx[t])
			}
		}
	}

	// l'x
	mp.symbols.lxPrime[x] = 100000
	for t := x; t < x+n+1; t++ {
		if t == x {
			mp.symbols.lxPrime[t+1] = mp.symbols.lxPrime[t] * (1 - mp.Qx.Gx.qx[t]*float64(1-mp.coverageInfo.invalidPeriod/12))
		} else {
			mp.symbols.lxPrime[t+1] = mp.symbols.lxPrime[t] * (1 - mp.Qx.Gx.qx[t])
		}
	}

	// Dx, D'x
	for t := x; t < x+n+1; t++ {
		mp.symbols.Dx[t] = mp.symbols.lx[0][t] * math.Pow(mp.contractInfo.v, float64(t-x))
		mp.symbols.DxPrime[t] = mp.symbols.lxPrime[t] * math.Pow(mp.contractInfo.v, float64(t-x))
	}

	// Cx
	for bNum := 1; bNum < numBenefit+1; bNum++ {
		for t := x; t < x+n+1; t++ {
			mp.symbols.Cx[bNum][t] = mp.symbols.lx[bNum][t] * mp.Qx.Bx[bNum].qx[t] * math.Pow(mp.contractInfo.v, float64(t-x)+0.5)
		}
	}

	// Mx
	for bNum := 1; bNum < numBenefit+1; bNum++ {
		mp.symbols.Mx[bNum][x+n] = mp.symbols.Cx[bNum][x+n]
		for t := x + n - 1; t >= x; t-- {
			mp.symbols.Mx[bNum][t] = mp.symbols.Cx[bNum][t] + mp.symbols.Mx[bNum][t+1]
		}
	}

	// Nx, N'x
	mp.symbols.Nx[x+n] = mp.symbols.Dx[x+n]
	mp.symbols.NxPrime[x+n] = mp.symbols.DxPrime[x+n]
	for t := x + n - 1; t >= x; t-- {
		mp.symbols.Nx[t] = mp.symbols.Dx[t] + mp.symbols.Nx[t+1]
		mp.symbols.NxPrime[t] = mp.symbols.DxPrime[t] + mp.symbols.NxPrime[t+1]
	}

	// SUMx
	for bNum := 1; bNum < numBenefit+1; bNum++ {
		for t := x; t < x+n+1; t++ {
			if t < mp.coverageInfo.reducePeriod[bNum] {
				mp.symbols.SUMx[t] += mp.coverageInfo.payRate[bNum] * ((1-mp.coverageInfo.reduceRate[bNum])*(mp.symbols.Mx[bNum][t]-mp.symbols.Mx[bNum][x+mp.coverageInfo.reducePeriod[bNum]]) +
					(mp.symbols.Mx[bNum][x+mp.coverageInfo.reducePeriod[bNum]] - mp.symbols.Mx[bNum][x+n]))
			} else {
				mp.symbols.SUMx[t] += mp.coverageInfo.payRate[bNum] * (mp.symbols.Mx[bNum][t] - mp.symbols.Mx[bNum][x+n])
			}
		}
	}
}

// --------------- 기수식 출력 --------------- //
func (mp *MyPV) printSymbol(symbol string) {
	x := mp.contractInfo.x
	n := mp.contractInfo.n
	numBenefit := mp.coverageInfo.numBenefit

	switch symbol {
	case "lx":
		fmt.Println(" =============== lx ================== ")
		for i := 0; i < numBenefit+1; i++ {
			fmt.Println(mp.symbols.lx[i][x : x+n+1])
		}
	case "l'x":
		fmt.Println(" =============== l'x ================== ")
		fmt.Println(mp.symbols.lxPrime[x : x+n+1])
	case "Dx":
		fmt.Println(" =============== Dx ================== ")
		fmt.Println(mp.symbols.Dx[x : x+n+1])
	case "D'x":
		fmt.Println(" =============== D'x ================== ")
		fmt.Println(mp.symbols.DxPrime[x : x+n+1])
	case "Cx":
		fmt.Println(" =============== Cx ================== ")
		for i := 1; i < numBenefit+1; i++ {
			fmt.Println(mp.symbols.Cx[i][x : x+n+1])
		}
	case "Mx":
		fmt.Println(" =============== Mx ================== ")
		for i := 1; i < numBenefit+1; i++ {
			fmt.Println(mp.symbols.Mx[i][x : x+n+1])
		}
	case "SUMx":
		fmt.Println(" =============== SUMx ================== ")
		fmt.Println(mp.symbols.SUMx[x : x+n+1])
	default:
		log.Fatal("잘못된 기수 입력")
	}
}

// --------------- 납입기수 계산 --------------- //

func (mp *MyPV) calc_N(mPrime float64) float64 {
	x := mp.contractInfo.x
	m := mp.contractInfo.m
	return mPrime * ((mp.symbols.Nx[x] - mp.symbols.Nx[x+m]) - (mPrime-1)/(2*mPrime)*(mp.symbols.Dx[x]-mp.symbols.Dx[x+m]))
}

// --------------- 보험료 계산 --------------- //

func (mp *MyPV) calc_P() {

	x := mp.contractInfo.x
	n := mp.contractInfo.n
	m := mp.contractInfo.m
	AMT := mp.contractInfo.AMT
	s := mp.symbols
	e := mp.contractInfo.expense

	// 年납 보험료
	mPrime := 1.
	Nstar := mp.calc_N(mPrime)
	mp.result.NP1_full = s.SUMx[x] / Nstar
	mp.result.NP1 = int(math.Round(mp.result.NP1_full * AMT))
	mp.result.G1_full = (mp.result.NP1_full + e.alpha3*s.DxPrime[x]/Nstar + e.beta2*(s.Nx[x+m]-s.Nx[x+n])/Nstar) / (1 - e.alpha1*s.DxPrime[x]/(Nstar/mPrime) - e.beta1 - e.ce - e.gamma)
	mp.result.G1 = int(math.Round(mp.result.G1_full * AMT))

	// 月납 보험료
	mPrime = 12.
	Nstar = mp.calc_N(mPrime)
	mp.result.NP12_full = s.SUMx[x] / Nstar
	mp.result.NP12 = int(math.Round(mp.result.NP12_full * AMT))
	mp.result.G12_full = (mp.result.NP12_full + e.alpha3*s.DxPrime[x]/Nstar + e.beta2*(s.Nx[x+m]-s.Nx[x+n])/Nstar) / (1 - e.alpha1*s.DxPrime[x]/(Nstar/mPrime) - e.beta1 - e.ce - e.gamma)
	mp.result.G12 = int(math.Round(mp.result.G12_full * AMT))
}

// --------------- 준비금 계산 --------------- //
func (mp *MyPV) calc_V() {
	x := mp.contractInfo.x
	n := mp.contractInfo.n
	m := mp.contractInfo.m
	NP1_full := mp.result.NP1_full
	AMT := mp.contractInfo.AMT
	for t := x; t < x+n+1; t++ {
		mp.result.tVx_full[t] = (mp.symbols.SUMx[t] - NP1_full*(mp.symbols.NxPrime[t]-mp.symbols.NxPrime[x+m])) / mp.symbols.Dx[t]
		mp.result.tVx[t] = int(math.Round(mp.result.tVx_full[t] * AMT))
	}
}

// --------------- 계산결과 출력 --------------- //

func (mp *MyPV) printResult() {
	x := mp.contractInfo.x
	n := mp.contractInfo.n
	r := mp.result

	s_NP := fmt.Sprintf("年납순보(full) : %0.5f원 | 月납순보(full) :  %0.5f원 | 年납순보 : %d원 | 月납순보 : %d원",
		r.NP1_full, r.NP12_full, r.NP1, r.NP12)
	fmt.Println(" =============== 순보험료 ================== ")
	fmt.Println(s_NP)

	s_G := fmt.Sprintf("年납영보(full) : %0.5f원 | 月납영보(full) :  %0.5f원 | 年납영보 : %d원 | 月납영보 : %d원",
		r.G1_full, r.G12_full, r.G1, r.G12)
	fmt.Println(" =============== 영업보험료 ================== ")
	fmt.Println(s_G)

	fmt.Println(" =============== 준비금 ================== ")
	fmt.Println("준비금(full) | ", r.tVx_full[x:x+n+1])
	fmt.Println("준비금 | ", r.tVx[x:x+n+1])
}
