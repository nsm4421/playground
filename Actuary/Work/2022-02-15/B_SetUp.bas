Attribute VB_Name = "B_SetUp"
Sub SetUp()
    
    Call B_initialSetUp
    Call B_SetUpQxDict
    Call B_SetUpCovDict

End Sub



Sub B_IntialSetUp()

    ' 상품 전체에 대해 동일하게 적용하는 내용 setting
    
    exp_i = 0.025
    exp_v = 1 / (1 + exp_i)
    l0 = 100000
    sep = "_"

End Sub


Sub B_SetUpQxDict()

    Set QxDict = CreateObject("Scripting.Dictionary")
    
    
    
    
    
    
    
    


End Sub



Sub B_SetUpCovDict()

' ToDo : CovDict라는 dictionary를 생성

    '  -------------------  변수 선언  -------------------  '

    Dim BNum As Long            ' 0:전체유지자/1~10:급부유지자/99:납입자
    Dim flag As Boolean
           
    ' 위험률 배열
    Dim Ex_(1 To 2, 10, 120), Bx_(1 To 2, 1 To 10, 120), Gx_(1 To 2, 120) As Double
       
    ' 기타
    Dim msg As String
    
    '======================== 구현부 ======================'
    
    ' ---------  초기화  --------- '
    
    Set CovDict = CreateObject("Scripting.Dictionary")
    flag = False
    sep = "_"
    useCombRiskRate = False
    UseSingleRate = False
    
    ' ---------  Iterating rows  --------- '
    
    With Worksheets("CODE").Range("TAB_CODE")
    
        For RR = 1 To .Rows.Count
                        
            Injure = .Cells(RR, 3)
            Driver = .Cells(RR, 4)
            FirstJoinAge = .Cells(RR, 5)
            
            CoverageKey = .Cells(RR, 9)
            BNum = .Cells(RR, 10)
            
            Select Case BNum
            
                ' ---------  전체유지자  --------- '
                Case 0
                
                    ExCode(BNum) = .Cells(RR, 11)
                    ExType(BNum) = .Cells(RR, 13)
                    NonCov(BNum) = .Cells(RR, 14)
                
                ' ---------  납입자  --------- '
                Case 99
                                
                    GxCode = .Cells(RR, 18)
                    GxType = .Cells(RR, 20)
                    InvalidPeriod = .Cells(RR, 21)
                    flag = True
                
                ' ---------  급부대상자  --------- '
                Case Else
                
                    ExCode(BNum) = .Cells(RR, 11)
                    ExType(BNum) = .Cells(RR, 13)
                    NonCov(BNum) = .Cells(RR, 14)
                    BxCode(BNum) = .Cells(RR, 15)
                    BxType(BNum) = .Cells(RR, 17)
                    PayRate(BNum) = .Cells(RR, 18)
                    ReduceRate(BNum) = .Cells(RR, 19)
                    ReducePeriod(BNum) = .Cells(RR, 20)
                    NumBenefit = NumBenefit + 1
                
            End Select
            
            
            ' ---------  탈퇴 위험률 key  --------- '
            For NN = 0 To NumBenefit
            
                Select Case ExType(NN)
                    Case "I"
                        ExKey(NN) = ExCode(NN) & sep & Injure
                    Case "D"
                        ExKey(NN) = ExCode(NN) & sep & Driver
                    Case "F"
                        ExKey(NN) = ExCode(NN) & sep & FirstJoinAge
                    Case "S"
                        ExKey(NN) = ExCode(NN)
                        UseSingleRate = True
                    Case "C"
                        ExKey(NN) = ExCode(NN)
                        UseCombRate = True
                    Case Else
                        ExKey(NN) = ExCode(NN)
                End Select
            
            Next NN
            
            ' ---------  급부 위험률 key  --------- '
            For NN = 1 To NumBenefit
            
                Select Case BxType(NN)
                    Case "I"
                        BxKey(NN) = BxCode(NN) & sep & Injure
                    Case "D"
                        BxKey(NN) = BxCode(NN) & sep & Driver
                    Case "F"
                         BxKey(NN) = BxCode(NN) & sep & FirstJoinAge
                    Case "S"
                        BxKey(NN) = BxCode(NN)
                        UseSingleRate = True
                    Case "C"
                        BxKey(NN) = BxCode(NN)
                        UseCombRate = True
                    Case Else
                        BxKey(NN) = BxCode(NN)
                End Select
            
            Next NN
            
            ' ---------  납면 위험률 key  --------- '
            Select Case GxType
                Case "I"
                    GxKey = GxCode & sep & Injure
                Case "D"
                    GxKey = GxCode & sep & Driver
                Case "F"
                    GxKey = GxCode & sep & FirstJoinAge
                Case "S"
                    GxKey = GxCode
                    UseSingleRate = True
                Case "C"
                    GxKey = GxCode
                    UseCombRate = True
                Case Else
                    GxKey = GxCode
            End Select
            
                        
            
            ' ---------  Append --------- '
            
            If flag Then
            
                ' ---------  이미 dict에 있는 키값인 경우 err 처리 --------- '
            
                If CovDict.exists(CoverageKey) Then
                    msg = "ERR : " & CoverageKey & "라는 담보키가 이미 존재"
                    Exit Sub
                End If
            
            
                ' ---------  위험률 배열 --------- '
            
                For NN = 0 To NumBenefit

                    For tt = 0 To 120
                    
                        Ex_(1, NN, tt) = QxDict(BxKey(NN))(1, tt)
                        Ex_(2, NN, tt) = QxDict(BxKey(NN))(2, tt)
                    
                    Next tt
                
                Next NN
                
                ' ---------  급부율 배열 --------- '
                For NN = 1 To NumBenefit
                
                    For tt = 0 To 120
                    
                        Bx_(1, NN, tt) = QxDict(BxKey(NN))(1, tt)
                        Bx_(2, NN, tt) = QxDict(BxKey(NN))(2, tt)
                    
                    Next tt
                
                Next NN
                
                
                ' ---------  납입면제율 배열 --------- '
           
                For tt = 0 To 120
                
                    Gx_(1, NN, tt) = QxDict(GxKey)(1, tt)
                    Gx_(2, NN, tt) = QxDict(GxKey)(2, tt)
                
                Next tt
                
                ' ---------  Append --------- '
                
                CovDict.Add CoverageKey & sep & "NumBenefit", NumBenefit
                CovDict.Add CoverageKey & sep & "UseSingleRate", NumBenefit
                CovDict.Add CoverageKey & sep & "UseCombRate", UseCombRate
                CovDict.Add CoverageKey & sep & "Ex_", Ex_
                CovDict.Add CoverageKey & sep & "Bx_", Bx_
                CovDict.Add CoverageKey & sep & "Bx_", Bx_
                CovDict.Add CoverageKey & sep & "NonCov", NonCov
                CovDict.Add CoverageKey & sep & "PayRate", PayRate
                CovDict.Add CoverageKey & sep & "ReduceRate", ReduceRate
                CovDict.Add CoverageKey & sep & "ReducePeriod", ReducePeriod
                CovDict.Add CoverageKey & sep & "InvalidPeriod", InvalidPeriod
                
                CovDict.Add CoverageKey & sep & "ExKey", ExKey
                CovDict.Add CoverageKey & sep & "BxKey", BxKey
                CovDict.Add CoverageKey & sep & "GxKey", GxKey
                CovDict.Add CoverageKey & sep & "Injure", Injure
                CovDict.Add CoverageKey & sep & "Driver", Driver
                CovDict.Add CoverageKey & sep & "FistJoinAge", FistJoinAge
                
                ' ---------  Initilize --------- '
                
                Erase ExCode, ExType, ExKey, NonCov
                Erase BxCode, BxType, BxKey, PayRate, ReduceRate, ReducePeriod
                GxCode = "": GxType = "": GxKey = "": InvalidPeriod = 0
                NumBenefit = 0
                userSingRate = False: UseCombRate = False
                flag = False
            
            End If
                    
        Next RR
    
    
    End With


End Sub
