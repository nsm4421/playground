Attribute VB_Name = "a_전역변수"
Option Explicit

' ----------  Global 변수를 선언하는 부분  ----------
    
    ' 위험률 사전
    Public QxDict As Object
    
   
    ' S rate 사전
    Public SrateDict As Object

    ' 가입자 정보
    Public x As Integer                           ' 가입연령
    Public sex As Integer                        ' 성별
    
    ' 계약정보
    Public n As Long                             ' 보험기간
    Public m As Long                            ' 납입기간
    Public m_ As Long                           ' 납입주기

    ' key
    Public KEY As String                         ' 담보코드 & injure & driver 로 만든 키값
    Public injure As Long
    Public driver As Long
    
    ' 할인율
    Public exp_i As Double                      ' 공시이율
    Public exp_v As Double

    ' 사업비
    Public AMT As Long
    Public alpha1 As Double
    Public alpha3 As Double
    Public beta1 As Double
    Public beta2 As Double
    Public gamma As Double
    Public ce As Double

    ' 위험률
    
    Public numBenefit As Integer                  ' 급부개수
    Public makeCombRiskRate As Boolean      ' 결합위험률생성여부
    Public useSingleRate As Boolean             ' 단일률적용여부
        
'   탈퇴
    Public riskType_exit(12) As String
    Public NonCov(12) As Integer                  ' 부담보기간
    Public QxKey(12) As String                      ' 탈퇴율
    Public Qx(12, 120) As Double
    
'   급부지급

    Public riskType_benefit(12) As String
    Public DefryRate(12) As Double                ' 지급률
    Public ReducRate(12) As Double               ' 감액률
    Public ReducPeriod(12) As Double            ' 감액기간
    Public BxKey(12) As String                       ' 급부지급 위험률 코드
    Public Bx(12, 120) As Double                    ' 급부지급 위험률
    
'   납입면제
    Public riskType_grant As String
    Public GxKey As String                           ' 납입면제율 위험률 코드
    Public Gx(120) As Double                        ' 납입면제
    Public InvalidPeriod As Integer                 ' 무효해지기간


    ' 계산기수
    Public lx_(120) As Double                     ' 납입자수
    Public lx(12, 120) As Double                 ' 유지자수
    Public Dx_(120) As Double
    Public Dx(120) As Double
    Public Nx_(120) As Double
    Public Nx(120) As Double
    Public Cx(12, 120) As Double
    Public Mx(12, 120) As Double
    Public SUMx(120) As Double
    
    ' 보험료

        ' 순보험료
        Public NP_annual_full As Double
        Public NP_month_full As Double
        
        Public NP_annual As Double
        Public NP_month As Double
    
        '영업보험료
        Public G_annual_full As Double
        Public G_month_full As Double
        
        Public G_annual As Double
        Public G_month As Double

        
    ' 준비금, 환급금
    Public tVx_full(120) As Double
    Public tWx_full(120) As Double
    Public tVx(120) As Double
    Public tWx(120) As Double
    
    ' 표준알파, 적용알파
    Public alpha_std As Double
    Public alpha_apply As Double
    Public Srate As Double
    
    ' 기타
    Public l0 As Long                           ' 계약초기 가입자수


