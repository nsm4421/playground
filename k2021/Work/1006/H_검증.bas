Attribute VB_Name = "H_����"
Function h_�����ϱ�()

    exp_i = 0.0225
    exp_v = 1 / (1 + exp_i)
    l0 = 10000

    
    beta = 0.19
    beta5 = 0.02
    ce = 0.038
    
    If re = 1 Then
        alpha = 0.3
    Else
        Select Case n
            Case 3
                alpha = 0.21
            Case 2
                alpha = 0.14
            Case 1
                alpha = 0.07
        End Select
    End If


    'Call b_��������������
    Call c_�ڵ弼���ϱ�
    Call e_����������ϱ�
    Call f_����İ���ϱ�
    Call g_PV����ϱ�

End Function



