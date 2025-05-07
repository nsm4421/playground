package main

import (
	"fmt"
	"math"
)

// 최大 급부개수
const maxNumBenefit int = 10

// 한계연령
const w int = 120

type Symbol struct {
	x            int     // 가입연령
	n            int     // 보험기감
	nonCov       int     // 부담보기간
	v            float64 // 이자율
	numBenefit   int     // 급부개수
	lx           [maxNumBenefit][w]float64
	qx           [maxNumBenefit][w]float64 // 탈퇴율
	bx           [maxNumBenefit][w]float64 // 급부율
	Cx           [maxNumBenefit][w]float64
	Mx           [maxNumBenefit][w]float64
	SumX         [w]float64
	payRate      [maxNumBenefit]float64
	reduceRate   [maxNumBenefit]float64 // 감액률
	reducePeriod [maxNumBenefit]int     // 감액기간
}

func (s *Symbol) InitSymbols() {
	s.numBenefit = 1
	for i := 0; i < maxNumBenefit; i++ {
		for t := s.x; t < w; t++ {
			s.lx[i][t] = 0
			s.qx[i][t] = 0
			s.bx[i][t] = 0
			s.Cx[i][t] = 0
			s.Mx[i][t] = 0
		}
		s.SumX[i] = 0
		s.payRate[i] = 1
		s.reducePeriod[i] = 0
		s.reduceRate[i] = 0
	}
}

func (s *Symbol) Calc_lx() {
	for i := 0; i < s.numBenefit; i++ {
		s.lx[i][s.x] = 100000
		for t := s.x; t < s.x+s.n; t++ {
			if t == s.x {
				s.lx[i][t+1] = s.lx[i][t] * (1 - s.qx[i][s.x]*float64(1-s.nonCov/12))
			} else {
				s.lx[i][t+1] = s.lx[i][t] * (1 - s.qx[i][t])
			}
		}
	}
}

func (s *Symbol) Calc_Cx() {
	for i := 0; i < s.numBenefit; i++ {
		for t := s.x; t < s.x+s.n+1; t++ {
			s.Cx[i][t] = s.lx[i][t] * s.bx[i][t] * (math.Pow(s.v, float64(t-s.x)+0.5))
		}
	}
}

func (s *Symbol) Calc_Mx() {
	for i := 0; i < s.numBenefit; i++ {
		for t := s.x; t < s.x+s.n+1; t++ {
			for _, C := range s.Cx[i][t : s.x+s.n] {
				s.Mx[i][t] += C
			}
		}
	}
}

func (s *Symbol) Calc_SumX() {
	for i := 0; i < s.numBenefit; i++ {
		for t := s.x; t < s.x+s.n+1; t++ {
			if t == s.x {
				s.SumX[i] += s.payRate[i] * (1 - s.reduceRate[i]) * (s.Mx[i][t] - s.Mx[i][s.x+s.n])
			} else {
				s.SumX[i] += s.payRate[i] * (s.Mx[i][t] - s.Mx[i][s.x+s.n])
			}
		}
	}
}

func (s *Symbol) Calc_Symbol() {
	s.Calc_lx()
	s.Calc_Cx()
	s.Calc_Mx()
	s.Calc_SumX()
}

func main() {

	// 예제 데이터
	var qx [maxNumBenefit][w]float64
	var bx [maxNumBenefit][w]float64
	for t := 0; t < w; t++ {
		qx[0][t] = 0.1
		bx[0][t] = 0.1
	}

	// initialize
	symbol := Symbol{}
	symbol.InitSymbols()

	symbol.x = 40
	symbol.n = 5
	symbol.v = 1 / (1 + 0.025)
	symbol.qx = qx
	symbol.bx = bx

	symbol.Calc_Symbol()

	fmt.Println("lx : ", symbol.lx[0][40:45])
	fmt.Println("qx : ", symbol.qx[0][40:45])
	fmt.Println("bx : ", symbol.bx[0][40:45])
	fmt.Println("Cx : ", symbol.Cx[0][40:45])
	fmt.Println("Mx : ", symbol.Mx[0][40:45])
	fmt.Println("SUMx : ", symbol.Mx[0][40:45])

}
