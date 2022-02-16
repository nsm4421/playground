Attribute VB_Name = "Y_Util"
'Function getQxKey(riskCode_ As String, _
'    Optional sex_ As Integer, _
'    Optional injure_ As Integer, _
'    Optional driver_ As Integer, _
'    Optional firstJoinAge_ As Long, _
'    Optional Lawyer_ As Integer, _
'    Optional grade_ As Integer)
'
'    If riskCode_ <> "" Then
'
'        getQxKey = riskCode_ & sex_ & injure_ & driver_ & Lawyer_ & grade_
'
'    Else
'
'        getQxKey = ""
'
'    End If
'
'
'End Function


Sub Set_NumBenefit()

    NumBenefit = CovDict(CoverageKey & sep & "NumBenefit")

End Sub

Sub Set_QxKey()

    For NN = 0 To NumBenefit
        ExCode(NN) = CovDict(CoverageKey & sep & "ExCode")(NN)
        ExType(NN) = CovDict(CoverageKey & sep & "ExType")(NN)
    Next NN


    For NN = 1 To NumBenefit
        BxCode(NN) = CovDict(CoverageKey & sep & "BxCode")(NN)
        BxType(NN) = CovDict(CoverageKey & sep & "BxType")(NN)
    Next NN

    GxCode = CovDict(CoverageKey & sep & "GxCode")
    GxType = CovDict(CoverageKey & sep & "GxType")
    
    For NN = 0 To NumBenefit

        Select Case ExType(NN)
            Case ""
                ExKey(NN) = ExCode(NN) & sex & 0 & 0 & 0 & 0 & 0
            Case "I"
                ExKey(NN) = ExCode(NN) & sex & Injure & 0 & 0 & 0 & 0
            Case "D"
                ExKey(NN) = ExCode(NN) & sex & 0 & Driver & 0 & 0 & 0
            Case "F"
                ExKey(NN) = ExCode(NN) & sex & 0 & 0 & FirstJoinAge & 0 & 0
            Case "L"
                ExKey(NN) = ExCode(NN) & sex & 0 & 0 & 0 & Lawyer & 0
            Case "G"
                ExKey(NN) = ExCode(NN) & sex & 0 & 0 & 0 & 0 & Grade
            Case Else
                MsgBox "≈ª≈¿≤ Type INPUT ERR"
        End Select

    Next NN
    
    
    For NN = 1 To NumBenefit

        Select Case BxType(NN)
            Case ""
                BxKey(NN) = BxCode(NN) & sex & 0 & 0 & 0 & 0 & 0
            Case "I"
                BxKey(NN) = BxCode(NN) & sex & Injure & 0 & 0 & 0 & 0
            Case "D"
                BxKey(NN) = BxCode(NN) & sex & 0 & Driver & 0 & 0 & 0
            Case "F"
                BxKey(NN) = BxCode(NN) & sex & 0 & 0 & FirstJoinAge & 0 & 0
            Case "L"
                BxKey(NN) = BxCode(NN) & sex & 0 & 0 & 0 & Lawyer & 0
            Case "G"
                BxKey(NN) = ExCode(NN) & sex & 0 & 0 & 0 & 0 & Grade
            Case Else
                MsgBox "±ﬁ∫Œ¿≤ Type INPUT ERR"
        End Select

    Next NN


    Select Case GxType
        Case ""
            GxKey = GxCode & sex & 0 & 0 & 0 & 0 & 0
        Case "I"
            GxKey = GxCode & sex & Injure & 0 & 0 & 0 & 0
        Case "D"
            GxKey = GxCode & sex & 0 & Driver & 0 & 0 & 0
        Case "F"
            GxKey = GxCode & sex & 0 & 0 & FirstJoinAge & 0 & 0
        Case "L"
            GxKey = GxCode & sex & 0 & 0 & 0 & Lawyer & 0
        Case "G"
            GxKey = GxCode & sex & 0 & 0 & 0 & 0 & Grade
        Case Else
            MsgBox "≥≥∏È¿≤ Type INPUT ERR"
    End Select

    
End Sub


Sub Set_NonCov()

    For NN = 0 To NumBenefit
        NonCov(NN) = CovDict(CoverageKey & sep & "NonCov")(NN)
    Next NN

End Sub



Sub Set_PayRate()

    For NN = 1 To NumBenefit
        PayRate(NN) = CovDict(CoverageKey & sep & "PayRate")(NN)
    Next NN

End Sub


Sub Set_ReducePeriod()

    For NN = 1 To NumBenefit
        ReducePeriod(NN) = CovDict(CoverageKey & sep & "ReducePeriod")(NN)
    Next NN

End Sub

Sub Set_ReduceRate()

    For NN = 1 To NumBenefit
        ReduceRate(NN) = CovDict(CoverageKey & sep & "ReduceRate")(NN)
    Next NN

End Sub


Sub Set_InvalidPeriod()

    InvalidPeriod = CovDict(CoverageKey & sep & "InvalidPeriod")

End Sub

Sub Set_UseCombRate()

    UseSingleRate = CovDict(CoverageKey & sep & "UseCombRate")

End Sub


Sub Set_UseSingleRate()

    UseSingleRate = CovDict(CoverageKey & sep & "UseSingleRate")

End Sub







