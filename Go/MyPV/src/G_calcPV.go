package karma

import "math"

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
