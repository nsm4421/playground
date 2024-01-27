package karma

// ========================== Struct 정의 ========================== //

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
	S      float64
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
