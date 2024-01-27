Attribute VB_Name = "H_검증"
Function h_검증하기()

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


    'Call b_위험률사전만들기
    Call c_코드세팅하기
    Call e_위험률세팅하기
    Call f_기수식계산하기
    Call g_PV계산하기

End Function



