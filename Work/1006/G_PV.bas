Attribute VB_Name = "G_PV"
Sub g_PV계산하기()

    Dim Nstar As Double
    
    '------------------------------------------------------------------
    ' 보험료
    
    m_ = 1
    Nstar = Nx_(x) - Nx_(x + m) - (m_ - 1) / (2 * m_) * (Dx_(x) - Dx_(x + m))
    NP_annual = SUMx(x) / (m_ * Nstar)
    G_annual = NP_annual / (1 - beta - beta5 - ce - alpha * Dx(x) / Nstar)
    
    m_ = 2
    Nstar = Nx_(x) - Nx_(x + m) - (m_ - 1) / (2 * m_) * (Dx_(x) - Dx_(x + m))
    NP_semi_annual = SUMx(x) / (m_ * Nstar)
    G_semi_annual = NP_semi_annual / (1 - beta - beta5 - ce - alpha * Dx(x) / Nstar)
    
    m_ = 4
    Nstar = Nx_(x) - Nx_(x + m) - (m_ - 1) / (2 * m_) * (Dx_(x) - Dx_(x + m))
    NP_quarter = SUMx(x) / (m_ * Nstar)
    G_quarter = NP_quarter / (1 - beta - beta5 - ce - alpha * Dx(x) / Nstar)
    
    m_ = 12
    Nstar = Nx_(x) - Nx_(x + m) - (m_ - 1) / (2 * m_) * (Dx_(x) - Dx_(x + m))
    NP_month = SUMx(x) / (m_ * Nstar)
    G_month = NP_month / (1 - beta - beta5 - ce - alpha * Dx(x) / Nstar)

    
    '-----------------------------------------------------------------------------
    ' 준비금
    For tt = x To x + n
        tVx(tt) = Round((SUMx(tt) - NP_annual * (Nx(tt) - Nx(x + m))) / Dx(tt) * AMT, 0)
    Next tt
    
    
End Sub
