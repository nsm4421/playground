package karma

import "strconv"

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
