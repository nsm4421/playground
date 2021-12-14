package karma

import (
	"log"
	"strconv"
)

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
			mp.contractInfo.expense.S, _ = strconv.ParseFloat(row[11], 64)
			mappinged = true
			break
		}
	}
	if !mappinged {
		log.Fatal(mp.contractInfo.coverageKey, " 담보 사업비가 mapping 되지 않음")
	}
}
