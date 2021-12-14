package karma

import (
	"log"
	"math"
)

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
