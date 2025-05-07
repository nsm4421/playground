Attribute VB_Name = "A_변수선언하기"
Option Explicit

' ----------  Global 변수를 선언하는 부분  ----------
    
    ' 위험률 사전
    Public riskRateDictMale As Object
    Public riskRateDictFemale As Object
    
    ' 가입자 정보
    Public x As Integer                         ' 가입연령
    Public sex As Integer                       ' 성별
    

    '   결합위험률
        Public combRiskKey As String
        Public QxComb(120) As Double
 

