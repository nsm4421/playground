Attribute VB_Name = "A_변수선언"
Option Explicit


Public riskRateDictMale As Object
Public riskRateDictFemale As Object

' 가입자 정보
Public x As Integer
Public sex As Integer

' 계약정보
Public n As Long
Public m As Long
Public m_ As Long       '납입주기

' key
Public cov As String
Public sub1 As Integer
Public sub2 As Integer
Public sub3 As Integer
Public KEY As String

' 할인율
Public exp_i As Double
Public exp_v As Double

' 사업비
Public amt As Long
Public alpha1 As Double
Public alpha2 As Double
Public beta1 As Double
Public beta2 As Double
Public beta_ As Double      ' Beta Prime
Public beta5 As Double
Public ce As Double     ' 손해조사비
Public gamma As Double

' 위험률
Public WxKey(10) As String  ' 납입면제율 위험률 코드
Public Wx(10, 120) As Double    ' 납입면제
Public Invalid(10) As Integer   ' 무효해지기간
Public NonCov(12) As Integer   ' 부담보기간
Public QxKey(12) As String
Public Qx(12, 120) As Double
Public Pay(12) As Double   ' 지급률
Public ReducRate(12) As Double   '  감액률
Public ReducPeriod(12) As Double   ' 감액기간

Public apply_Bx As String
Public BxKey(12) As String
Public Bx(12, 120) As Double

' 계산기수
Public lx_(120) As Double   ' 납입자수
Public lx(12, 120) As Double    '유지자수
Public Dx_(120) As Double
Public Dx(120) As Double
Public Nx_(120) As Double
Public Nx(120) As Double
Public Cx(12, 120) As Double
Public Mx(12, 120) As Double
Public SUMx(160) As Double
Public Nstar As Double  ' 납입기수

' 보험료
Public NP As Double     ' 연납 순보험료
Public NP_month As Double     ' 월납 순보험료
Public NP_std As Double      ' 기준연납순보험료
Public G As Double      ' 월납영업보험료
Public BetaP As Double      ' 연납베타순보험료


' 준비금, 환급금
Public tVx(160) As Double
Public Srate As Double
Public tWx(160) As Double




