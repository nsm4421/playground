Attribute VB_Name = "Z_�׽�Ʈ"
Sub z_���������()
    Call b_��������������
    Call h_Srate�����ϱ�
End Sub


Sub z_�׽�Ʈ()

    ' ���� ���̽��� ���ǥ ���
    Dim startTime As Double                                 ' ���۽ð�
    Dim passedTime As Double                              ' �ɸ��ð�
    
    Application.ScreenUpdating = False
    
    l0 = 100000
    
    With Worksheets("�׽�Ʈ")
    
        ' �� B~C���� ���� �б�
        KEY = .Range("KEY")
        x = .Range("x")
        sex = .Range("sex")
        m = .Range("m")
        n = .Range("n")
        injure = .Range("injure")
        driver = .Range("driver")
        alpha1 = .Range("alpha1")
        alpha3 = .Range("alpha3")
        beta1 = .Range("beta1")
        beta2 = .Range("beta2")
        gamma = .Range("gamma")
        ce = .Range("ce")
        AMT = .Range("AMT")
        
        exp_i = .Range("exp_i")
        exp_v = 1 / (1 + exp_i)
        
    End With
    
    Application.StatusBar = "��� ��"
    
    ' �� ����ϱ�

     
        Call c_�ڵ弼���ϱ�

        ' Call d_��������ϱ�

        Call e_����������ϱ�

        Call f_����İ���ϱ�

        Call g_PV����ϱ�
        
      
        
        
    ' �� ����� ���
    With Worksheets("�׽�Ʈ").Range("F5")
        For tt = x To x + n
        
            .Offset(tt - x, 0) = tt - x
            .Offset(tt - x, 1) = tt
            
            ' Ż����
            For benefitNum = 0 To 12
                .Offset(-2, benefitNum + 2) = QxKey(benefitNum)
                .Offset(tt - x, benefitNum + 2) = Qx(benefitNum, tt)
            Next benefitNum
            
            ' �޺���
            For benefitNum = 1 To 12
                .Offset(-2, benefitNum + 14) = BxKey(benefitNum)
               .Offset(tt - x, benefitNum + 14) = Bx(benefitNum, tt)
            Next benefitNum
            
            ' ������
            .Offset(-2, 27) = GxKey
            .Offset(tt - x, 27) = Gx(tt)
            
            ' lx
            For benefitNum = 0 To 12
                .Offset(tt - x, 28 + benefitNum) = lx(benefitNum, tt)
            Next benefitNum
            
            ' l'x
            .Offset(tt - x, 41) = lx_(tt)
                        
            
            ' Cx
            For benefitNum = 1 To 12
                .Offset(tt - x, 41 + benefitNum) = Cx(benefitNum, tt)
            Next benefitNum
            
            ' Dx
            .Offset(tt - x, 54) = Dx(tt)
            
            
            ' D'x
            .Offset(tt - x, 55) = Dx_(tt)
            
            ' Nx, N'x
            .Offset(tt - x, 56) = Nx(tt)
            .Offset(tt - x, 57) = Nx_(tt)
            
            ' Mx
            For benefitNum = 1 To 12
                .Offset(tt - x, 57 + benefitNum) = Mx(benefitNum, tt)
            Next benefitNum
            
            'SUMx
            .Offset(tt - x, 70) = SUMx(tt)
            
            .Offset(tt - x, 71) = tVx(tt)
            
            '.Offset(tt - x, 72) = tWx(tt)
            
            ' NP
            
        Next tt
        
        .Offset(0, 73) = NP_annual_full

        .Offset(2, 73) = G_annual_full
       
        .Offset(0, 76) = NP_month_full
        
        .Offset(2, 76) = G_month_full
        
        .Offset(0, 77) = alpha_std
        
        .Offset(0, 78) = alpha_apply
        
        .Offset(0, 79) = Srate
        
        
    End With
    
        Application.StatusBar = False

        
End Sub

Sub z_Ŭ����()
    With Worksheets("�׽�Ʈ")
        .Range("F5:BZ49").ClearContents
        .Range("F3:BX3").ClearContents
        .Range("CA5:CD5").ClearContents
        .Range("CA7:CD7").ClearContents
    End With
End Sub


