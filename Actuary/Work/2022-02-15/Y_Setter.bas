Attribute VB_Name = "Y_Setter"
Sub Set_NumBenefit()

    NumBenefit = CovDict(CoverageKey & sep & "NumBenefit")

End Sub

Sub Set_ExKey()

    For NN = 0 To NumBenefit
        ExKey(NN) = CovDict(CoverageKey & sep & "ExKey")(NN)
    Next NN

End Sub

Sub Set_BxKey()

    For NN = 1 To NumBenefit
        BxKey(NN) = CovDict(CoverageKey & sep & "BxKey")(NN)
    Next NN

End Sub

Sub Set_GxKey()

    GxKey(NN) = CovDict(CoverageKey & sep & "GxKey")(NN)

End Sub


Sub Set_NonCov()

    For NN = 0 To NumBenefit
        NonCov(NN) = CovDict(CoverageKey & sep & "NonCov")(NN)
    Next NN

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


Sub Set_UseSingleRate()

    UseSingleRate = CovDict(CoverageKey & sep & "UseSingleRate")

End Sub


Sub Set_UseSingleRate()

    UseSingleRate = CovDict(CoverageKey & sep & "UseSingleRate")

End Sub






