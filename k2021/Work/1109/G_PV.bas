Attribute VB_Name = "G_PV"
Sub g_보험료계산하기()

    Dim Nstar As Double     ' 납입기수

    m_ = 1
    Nstar = m_ * (Nx_(x) - Nx_(x + m) - (m_ - 1) / (2 * m_) * (Dx_(x) - Dx_(x + m)))
    NP_annual_full = SUMx(x) / (Nstar)
    G_annual_full = (NP_annual_full + alpha3 * Dx_(x) / Nstar + beta2 * (Nx(x + m) - Nx(x + n)) / Nstar) / (1 - alpha1 * Dx_(x) / (Nstar / m_) - beta1 - ce - gamma)
    NP_annual = Application.Round(NP_annual_full * AMT, 0)
    G_annual = Application.Round(G_annual_full * AMT, 0)
    
    m_ = 12
    Nstar = m_ * (Nx_(x) - Nx_(x + m) - (m_ - 1) / (2 * m_) * (Dx_(x) - Dx_(x + m)))
    NP_month_full = SUMx(x) / (Nstar)
    G_month_full = (NP_month_full + alpha3 * Dx_(x) / Nstar + beta2 * (Nx(x + m) - Nx(x + n)) / Nstar) / (1 - alpha1 * Dx_(x) / (Nstar / m_) - beta1 - ce - gamma)

    
End Sub

Sub g_준비금계산하기()

    ' 준비금
    For tt = x To x + n
        tVx_full(tt) = (SUMx(tt) - NP_annual_full * (Nx(tt) - Nx(x + m))) / Dx(tt)
        tVx(tt) = Application.Round(tVx_full(tt) * AMT, 0)
    Next tt

End Sub

Sub g_알파계산하기()

    '적용알파
    alpha_apply = Application.Round(alpha1 * G_annual + alpha3 * AMT, 0)

    ' 표준알파
    ' Srate = SrateDict(KEY)
    
    ' 단일률 ---> NP1 x 45% / 실손 -> NP1 x 15%
    If useSingleRate Then
        alpha_std = Application.Round((0.05 * Application.Min(n, 20) * NP_annual_full + NP_annual_full * 0.45) * AMT, 8)
    Else
        alpha_std = Application.Round((0.05 * Application.Min(n, 20) * NP_annual_full + Srate / 100) * AMT, 8)
    End If
End Sub


Sub g_PV계산하기()
    
    Erase tVx, tVx_full
    
    Call g_보험료계산하기
    Call g_준비금계산하기
    Call g_알파계산하기
        
End Sub
