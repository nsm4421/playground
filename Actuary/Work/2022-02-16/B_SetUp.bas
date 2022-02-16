Attribute VB_Name = "B_SetUp"
Sub SetUp()
    
    Call B_InitialSetUp
    Call B_SetUpQxDict
    Call B_SetUpCovDict

End Sub



Sub B_InitialSetUp()

    ' 상품 전체에 대해 동일하게 적용하는 내용 setting
    
    exp_i = 0.025
    exp_v = 1 / (1 + exp_i)
    l0 = 100000
    sep = "_"

End Sub


Sub B_SetUpQxDict()
    
    Dim qxKey_ As String
    Dim qx_(120) As Double
    
    Set QxDict = CreateObject("Scripting.Dictionary")


    With Worksheets("Qx").Range("TAB_Qx")
    
        For RR = 1 To .Rows.Count
            
            qxKey_ = .Cells(RR, 9)
            
            For tt = 0 To 120
               qx_(tt) = .Cells(RR, 10 + tt)
            Next tt
            
            If QxDict.exists(qxKey_) Then
                MsgBox qxKey_ & "라는 위험률 코드가 중복"
                Exit Sub
            End If
            
            QxDict.Add qxKey_, qx_
            
            Erase qx_

        Next RR
        
    
    End With
    

End Sub



Sub B_SetUpCovDict()

' ToDo : CovDict라는 dictionary를 생성

    '  -------------------  변수 선언  -------------------  '

    Dim BNum As Long            ' 0:전체유지자/1~10:급부유지자/99:납입자
    Dim flag As Boolean

     ' 기타
    Dim msg As String
    
    '======================== 구현부 ======================'
    
   
    Set CovDict = CreateObject("Scripting.Dictionary")
    flag = False
    useCombRiskRate = False
    UseSingleRate = False
    NumBenefit = 0
    
    ' ---------  Iterating rows  --------- '
    
    With Worksheets("Code").Range("TAB_CODE")
    
        For RR = 1 To .Rows.Count
                        
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
                                
                    GxCode = .Cells(RR, 21)
                    GxType = .Cells(RR, 22)
                    InvalidPeriod = .Cells(RR, 24)
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
            

            If flag Then
            
                        
                ' ---------  이미 dict에 있는 키값인 경우 err 처리 --------- '
            
                If CovDict.exists(CoverageKey) Then
                    
                    msg = "ERR : " & CoverageKey & "라는 담보키가 이미 존재"
                    Exit Sub
                
                End If
                
                ' ---------  결합위험률 / 단일률 적용 여부 (bool) --------- '
                
                For NN = 0 To NumBenefit
                
                    Select Case ExType(NN)
                    
                        Case "C"
                            UseCombRate = True
                        Case "S"
                            UseSingleRate = True
                    
                    End Select
                
                Next NN
                
                For NN = 1 To NumBenefit
                
                    Select Case BxType(NN)
                    
                        Case "C"
                            UseCombRate = True
                        Case "S"
                            UseSingleRate = True
                    
                    End Select
                
                Next NN
                
                Select Case GxType
                
                    Case "C"
                        UseCombRate = True
                    Case "S"
                        UseSingleRate = True
                
                End Select

                ' ---------  Append --------- '
                
                CovDict.Add CoverageKey & sep & "NumBenefit", NumBenefit
                CovDict.Add CoverageKey & sep & "UseSingleRate", NumBenefit
                CovDict.Add CoverageKey & sep & "UseCombRate", UseCombRate

                CovDict.Add CoverageKey & sep & "NonCov", NonCov
                CovDict.Add CoverageKey & sep & "PayRate", PayRate
                CovDict.Add CoverageKey & sep & "ReduceRate", ReduceRate
                CovDict.Add CoverageKey & sep & "ReducePeriod", ReducePeriod
                CovDict.Add CoverageKey & sep & "InvalidPeriod", InvalidPeriod
                
                CovDict.Add CoverageKey & sep & "ExCode", ExCode
                CovDict.Add CoverageKey & sep & "BxCode", BxCode
                CovDict.Add CoverageKey & sep & "GxCode", GxCode
                CovDict.Add CoverageKey & sep & "ExType", ExType
                CovDict.Add CoverageKey & sep & "BxType", BxType
                CovDict.Add CoverageKey & sep & "GxType", GxType
                
                ' ---------  Initilize --------- '
                
                Erase ExCode, ExType, NonCov
                Erase BxCode, BxType, PayRate, ReduceRate, ReducePeriod
                GxCode = "": GxType = "": InvalidPeriod = 0
                NumBenefit = 0
                userSingRate = False: UseCombRate = False
                flag = False
            
            End If
                    
        Next RR
    
    
    End With


End Sub
