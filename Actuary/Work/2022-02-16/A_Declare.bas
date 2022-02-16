Attribute VB_Name = "A_Declare"
Option Explicit

' ----------  Global 변수를 선언하는 부분  ----------
    
    Public QxDict As Object
    Public CovDict As Object
    
    Public x As Integer                           ' 가입연령
    Public n As Long                              ' 보험기간
    Public m As Long                              ' 납입기간
    Public mPrime As Long                         ' 납입주기
    
    
    ' 위험률 구분자
    Public sex As Integer          ' 성별
    Public Injure As Integer       ' 상해급수
    Public Driver As Integer       ' 운전자급수
    Public FirstJoinAge As Long    ' 최초가입연령
    Public Lawyer As Integer       ' 변호사 급수
    Public Grade As Integer        ' 물건급수
    
    
    ' 위험률키
    Public ExCode(10), BxCode(1 To 10), GxCode As String
    Public ExType(10), BxType(1 To 10), GxType As String
    Public ExKey(10), BxKey(1 To 10), GxKey As String
    
    
    ' 위험률
    Public Ex(10, 120) As Double
    Public Bx(1 To 10, 120) As Double
    Public Gx(120) As Double
    
    ' etc
    Public l0 As Long                           ' 계약초기 가입자수
    Public AMT As Long                          ' 가입금액
    Public sep As String
    
    ' Interst
    Public exp_i As Double                        ' 공시이율
    Public exp_v As Double
    
    ' Expense
    Public alpha1 As Double
    Public alpha3 As Double
    Public beta1 As Double
    Public beta2 As Double
    Public gamma As Double
    Public ce As Double
    
    ' 담보정보
    Public CoverageKey As String                    ' 담보키
    Public NumBenefit As Integer                    ' 급부개수
    Public MakeCombRiskRate As Boolean              ' 결합위험률생성여부
    Public UseSingleRate As Boolean                 ' 단일률적용여부
    Public NonCov(10) As Integer                    ' 부담보기간
    Public PayRate(1 To 10) As Double               ' 지급률
    Public ReducePeriod(1 To 10) As Integer         ' 감액기간
    Public ReduceRate(1 To 10) As Double            ' 감액률
    Public InvalidPeriod As Integer                 ' 무효해지기간
          
          
    ' 계산기수
    Public lxPrime(120) As Double                   ' 납입자수
    Public lx(10, 120) As Double                    ' 유지자수
    Public DxPrime(120) As Double
    Public Dx(120) As Double
    Public NxPrime(120) As Double
    Public Nx(120) As Double
    Public Cx(1 To 10, 120) As Double
    Public Mx(1 To 10, 120) As Double
    Public SUMx(120) As Double
    
    ' 보험료
    
        ' 순보험료
        Public NP_annual_full As Double
        Public NP_month_full As Double
        
        Public NP_annual_round As Long
        Public NP_month_round As Long
    
        '영업보험료
        Public G_annual_full As Double
        Public G_month_full As Double
        
        Public G_annual_round As Long
        Public G_month_round As Long
    
        
    ' 준비금, 환급금
    Public tVx_full(120) As Double
    Public tWx_full(120) As Double
    Public tVx_round(120) As Long
    Public tWx_round(120) As Long
    
    ' 표준알파, 적용알파
    Public alpha_std As Double
    Public alpha_apply As Double
    Public S As Double
    

    
