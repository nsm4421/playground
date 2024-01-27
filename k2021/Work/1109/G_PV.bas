Attribute VB_Name = "G_PV"
Sub g_��������ϱ�()

    Dim Nstar As Double     ' ���Ա��

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

Sub g_�غ�ݰ���ϱ�()

    ' �غ��
    For tt = x To x + n
        tVx_full(tt) = (SUMx(tt) - NP_annual_full * (Nx(tt) - Nx(x + m))) / Dx(tt)
        tVx(tt) = Application.Round(tVx_full(tt) * AMT, 0)
    Next tt

End Sub

Sub g_���İ���ϱ�()

    '�������
    alpha_apply = Application.Round(alpha1 * G_annual + alpha3 * AMT, 0)

    ' ǥ�ؾ���
    ' Srate = SrateDict(KEY)
    
    ' ���Ϸ� ---> NP1 x 45% / �Ǽ� -> NP1 x 15%
    If useSingleRate Then
        alpha_std = Application.Round((0.05 * Application.Min(n, 20) * NP_annual_full + NP_annual_full * 0.45) * AMT, 8)
    Else
        alpha_std = Application.Round((0.05 * Application.Min(n, 20) * NP_annual_full + Srate / 100) * AMT, 8)
    End If
End Sub


Sub g_PV����ϱ�()
    
    Erase tVx, tVx_full
    
    Call g_��������ϱ�
    Call g_�غ�ݰ���ϱ�
    Call g_���İ���ϱ�
        
End Sub
