Attribute VB_Name = "E_PV���"
Sub E�������()

    Dim NNx As Double
    
    Nstar = 12 * ((Nx_(x) - Nx_(x + m)) - (11 / 24) * (Dx_(x) - Dx_(x + m)))

    ' ------------------- ������� -------------------
    
    ' �����������
     NP_month = SUMx(x) / Nstar
    
    ' �����������
    NNx = Nx_(x) - Nx_(x + n)
    NP = SUMx(x) / NNx
    
    ' ���ؿ����������
    NNx = Nx_(x) - Nx_(x + Application.Min(n, 20))
    NP_std = SUMx(x) / NNx
    
    ' ������Ÿ�������
    BetaP = NP + beta_ * (Nx(x) - Nx(x + n) - Application.Max(Nx_(x) - Nx_(x + m), 0)) / Application.Max(Nx_(x) - Nx_(x + m), 0)
    
    ' ------------------- ��������� -------------------
    
    ' �������������
    G = (NP_month + (alpha1 + alpha2 * NP_std) * Dx(x) / Nstar + beta1 / 12 + beta_ * (Nx(x) - Nx(x + n) - Nstar / 12) / Nstar) / (1 - beta2 - beta5)
    
End Sub


Sub E�غ�ݰ��()

' ------------------- �غ�� -------------------
For t = 0 To n
    If t = 0 Then
        tVx(x + t) = 0
    Else
        tVx(x + t) = (SUMx(x + t) + beta_ * (Nx(x + t) - Nx(x + n) - (Nx_(x + t) - Nx_(x + m))) - BetaP * (Nx_(x + t) - Nx_(x + m))) / Dx(x + t)
    End If
Next t

' ------------------- ����ȯ�ޱ� -------------------

' �ؾ������
Dim alpha_apply As Double
Dim alpha_std As Double
Dim alpha_ As Double

alpha_apply = alpha1 + alpha2 * NP_std
alpha_std = NP_std * 0.05 * Application.Min(n, 20) + 10 / 1000 * Srate
alpha_ = Application.Min(alpha_apply, alpha_std)

' �ؾ�ȯ�ޱ�
For t = 0 To n
     tWx(x + t) = Application.Max(tVx(x + t) - Application.Max(1 - Application.Min(t, 7) / Application.Min(m, 7), 0) * alpha_, 0)
Next t

End Sub

