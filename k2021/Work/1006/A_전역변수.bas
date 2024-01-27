Attribute VB_Name = "a_전역변수"
Option Explicit

' ----------  Global 변수를 선언하는 부분  ----------
    
    ' 위험률 사전
    Public QxDict As Object

    ' 가입자 정보
    Public x As Integer                         ' 가입연령
    Public sex As Integer                       ' 성별
    Public firstJoinAge As Integer              ' 최초가입연령
    
    ' 계약정보
    Public n As Long                            ' 보험기간
    Public m As Long                            ' 납입기간
    Public m_ As Long                           ' 납입주기
    
    ' key
    Public KEY As String                        ' 담보코드 & 보조키(sub) 1~4로 만든 키값
    Public re As String
    
    ' 할인율
    Public exp_i As Double                      ' 공시이율
    Public exp_v As Double
    
    ' 사업비
    Public AMT As Long
    Public alpha As Double
    Public beta As Double
    Public beta5 As Double
    Public ce As Double                         ' 손해조사비

    ' 위험률
    
'   탈퇴
    Public riskType_exit(100) As String         ' 탈퇴위험률type
    Public NonCov(12) As Integer            ' 부담보기간
    Public QxKey(12) As String              ' 탈퇴율
    Public Qx(12, 120) As Double
    
'   급부지급

    Public riskType_benefit(100) As String      ' 급부위험률type
    Public DefryRate(12) As Double          ' 지급률
    Public ReducRate(12) As Double          ' 감액률
    Public ReducPeriod(12) As Double        ' 감액기간
    Public BxKey(12) As String              ' 급부지급 위험률 코드
    Public Bx(12, 120) As Double            ' 급부지급 위험률
    
'   납입면제
    Public riskType_grant As String             ' 납면위험률type
    Public GxKey As String                  ' 납입면제율 위험률 코드
    Public Gx(120) As Double                ' 납입면제
    Public invalidPeriod As Integer         ' 무효해지기간


    ' 계산기수
    Public lx_(120) As Double                    ' 납입자수
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
        Public NP_annual As Double                   ' 연납 순보험료
        Public NP_semi_annual As Double              ' 6월납순보험료
        Public NP_quarter As Double                  ' 3월납순보험료
        Public NP_month As Double                    ' 월납 순보험료
    
        '영업보험료
        Public G_annual As Double                    ' 연납영업보험료
        Public G_semi_annual As Double               ' 6월납영업보험료
        Public G_quarter As Double                   ' 3월납영업보험료
        Public G_month As Double                     ' 월납영업보험료


        
    ' 준비금, 환급금
    Public tVx(160) As Double

    ' 기타
    Public l0 As Long                           ' 계약초기 가입자수


