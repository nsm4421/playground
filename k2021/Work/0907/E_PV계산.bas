Attribute VB_Name = "E_PV계산"
Sub E보험료계산()

    Dim NNx As Double
    
    Nstar = 12 * ((Nx_(x) - Nx_(x + m)) - (11 / 24) * (Dx_(x) - Dx_(x + m)))

    ' ------------------- 순보험료 -------------------
    
    ' 월납순보험료
     NP_month = SUMx(x) / Nstar
    
    ' 연납순보험료
    NNx = Nx_(x) - Nx_(x + n)
    NP = SUMx(x) / NNx
    
    ' 기준연납순보험료
    NNx = Nx_(x) - Nx_(x + Application.Min(n, 20))
    NP_std = SUMx(x) / NNx
    
    ' 연납베타순보험료
    BetaP = NP + beta_ * (Nx(x) - Nx(x + n) - Application.Max(Nx_(x) - Nx_(x + m), 0)) / Application.Max(Nx_(x) - Nx_(x + m), 0)
    
    ' ------------------- 영업보험료 -------------------
    
    ' 월납영업보험료
    G = (NP_month + (alpha1 + alpha2 * NP_std) * Dx(x) / Nstar + beta1 / 12 + beta_ * (Nx(x) - Nx(x + n) - Nstar / 12) / Nstar) / (1 - beta2 - beta5)
    
End Sub


Sub E준비금계산()

' ------------------- 준비금 -------------------
For t = 0 To n
    If t = 0 Then
        tVx(x + t) = 0
    Else
        tVx(x + t) = (SUMx(x + t) + beta_ * (Nx(x + t) - Nx(x + n) - (Nx_(x + t) - Nx_(x + m))) - BetaP * (Nx_(x + t) - Nx_(x + m))) / Dx(x + t)
    End If
Next t

' ------------------- 해지환급금 -------------------

' 해약공제액
Dim alpha_apply As Double
Dim alpha_std As Double
Dim alpha_ As Double

alpha_apply = alpha1 + alpha2 * NP_std
alpha_std = NP_std * 0.05 * Application.Min(n, 20) + 10 / 1000 * Srate
alpha_ = Application.Min(alpha_apply, alpha_std)

' 해약환급금
For t = 0 To n
     tWx(x + t) = Application.Max(tVx(x + t) - Application.Max(1 - Application.Min(t, 7) / Application.Min(m, 7), 0) * alpha_, 0)
Next t

End Sub

