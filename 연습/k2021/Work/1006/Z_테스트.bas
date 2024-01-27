Attribute VB_Name = "Z_테스트"
Sub z_테스트()
    
    exp_i = 0.0225
    exp_v = 1 / (1 + exp_i)
    l0 = 100000
    
    Application.ScreenUpdating = False
    
    With Worksheets("테스트").Range("C5")
        x = .Offset(0, 0)
        sex = .Offset(1, 0)
        m = .Offset(2, 0)
        n = .Offset(3, 0)
        m_ = .Offset(4, 0)
        firstJoinAge = .Offset(5, 0)
        ' alpha = .Offset(6, 0)
        ' beta = .Offset(7, 0)
        ' beta5 = .Offset(8, 0)
        ' ce = .Offset(9, 0)
        KEY = .Offset(10, 0)
        re = .Offset(11, 0)
        AMT = .Offset(12, 0)
    End With
    
    Call h_검증하기
    
    
    With Worksheets("테스트").Range("F5")
        For tt = x To x + n
        
            .Offset(tt - x, 0) = tt - x
            .Offset(tt - x, 1) = tt
            
            ' 탈퇴율
            For benefitNum = 0 To 12
                .Offset(-2, benefitNum + 2) = QxKey(benefitNum)
                .Offset(tt - x, benefitNum + 2) = Qx(benefitNum, tt)
            Next benefitNum
            
            ' 급부율
            For benefitNum = 1 To 12
                .Offset(-2, benefitNum + 14) = BxKey(benefitNum)
               .Offset(tt - x, benefitNum + 14) = Bx(benefitNum, tt)
            Next benefitNum
            
            ' 납면율
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
        
        .Offset(0, 73) = NP_annual
        .Offset(2, 73) = G_annual
        
        .Offset(0, 74) = NP_semi_annual
        .Offset(2, 74) = G_semi_annual
        
        .Offset(0, 75) = NP_quarter
        .Offset(2, 75) = G_quarter
        
        .Offset(0, 76) = NP_month
        .Offset(2, 76) = G_month
    End With
    
    
End Sub


