package karma

import (
	"fmt"
	"log"
)

// --------------- 모든 결과 print --------------- //
func (mp *MyPV) PrintAll(coverage string, x string, sex string, n string, m string, AMT string, injure string, driver string, i float64) {
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

// --------------- 계약정보 출력 --------------- //
func (mp *MyPV) printContractInfo() {
	s := fmt.Sprintf("담보명 : %s | 담보키 : %s | 가입연령 : %d |  성별코드 : %d |보험기간 : %d | 납입기간 : %d | 가입금액 : %.0f | 상해급수 : %d | 운전자급수 : %d",
		mp.contractInfo.coverage, mp.contractInfo.coverageKey, mp.contractInfo.x, mp.contractInfo.sex, mp.contractInfo.n, mp.contractInfo.m,
		mp.contractInfo.AMT, mp.contractInfo.injure, mp.contractInfo.driver)
	fmt.Println(s)
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

// --------------- 사업비 print --------------- //
func (mp *MyPV) printExpense() {
	var s_expense string
	e := mp.contractInfo.expense
	s_expense = fmt.Sprintf("alpha1 : %0.4f | alpha3 : %0.4f | beta1 : %0.4f | beta2 : %0.4f | gamma : %0.4f | ce : %0.4f | S : %0.4f",
		e.alpha1, e.alpha3, e.beta1, e.beta2, e.gamma, e.ce, e.S)
	fmt.Println(" =============== 사업비 ================== ")
	fmt.Println(s_expense)
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
