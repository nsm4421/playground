package karma

import "strconv"

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
