Attribute VB_Name = "c_코드세팅"

Sub c_코드세팅하기()
   
    Erase QxKey, BxKey, NonCov, DefryRate, ReducPeriod, ReducRate
    GxKey = ""
    InvalidPeriod = 0
    numBenefit = 0                                ' 급부개수
    makeCombRiskRate = False                ' 결합위험률생성여부
    useSingleRate = False
        
    With Worksheets("코드").Range("Tab_Code")
        For RR = 1 To .Rows.Count
            If .Cells(RR, 6) = KEY Then
                benefitNum = .Cells(RR, 7)
                If benefitNum = 99 Then
                    InvalidPeriod = .Cells(RR, 21)
                    Select Case .Cells(RR, 19)
                        Case "I"
                            GxKey = .Cells(RR, 18) & "_" & injure
                        Case "D"
                            GxKey = .Cells(RR, 18) & "_" & driver
                        Case "C"
                            makeCombRiskRate = True
                            GxKey = .Cells(RR, 18)
                        Case "S"
                            useSingleRate = True
                            GxKey = .Cells(RR, 18)
                        Case Else
                            GxKey = .Cells(RR, 18)
                    End Select
                Else
                    If benefitNum <> 0 Then
                        numBenefit = numBenefit + 1
                        DefryRate(benefitNum) = .Cells(RR, 15)
                        ReducRate(benefitNum) = .Cells(RR, 16)
                        ReducPeriod(benefitNum) = .Cells(RR, 17)
                        Select Case .Cells(RR, 13)
                            Case "I"
                                BxKey(benefitNum) = .Cells(RR, 12) & "_" & injure
                            Case "D"
                                BxKey(benefitNum) = .Cells(RR, 12) & "_" & driver
                            Case "C"
                                makeCombRiskRate = True
                                BxKey(benefitNum) = .Cells(RR, 12)
                            Case "S"
                                useSingleRate = True
                                BxKey(benefitNum) = .Cells(RR, 12)
                            Case Else
                                BxKey(benefitNum) = .Cells(RR, 12)
                        End Select
                    End If
                    NonCov(benefitNum) = .Cells(RR, 11)
                    Select Case .Cells(RR, 9)
                            Case "I"
                                QxKey(benefitNum) = .Cells(RR, 8) & "_" & injure
                            Case "D"
                                QxKey(benefitNum) = .Cells(RR, 8) & "_" & driver
                            Case "C"
                                makeCombRiskRate = True
                                QxKey(benefitNum) = .Cells(RR, 8)
                            Case "S"
                                useSingleRate = True
                                QxKey(benefitNum) = .Cells(RR, 8)
                            Case Else
                                QxKey(benefitNum) = .Cells(RR, 8)
                    End Select
                End If
            End If
        Next RR
    End With
End Sub
