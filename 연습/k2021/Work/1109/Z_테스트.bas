Attribute VB_Name = "Z_테스트"
Sub z_사전만들기()
    Call b_위험률사전만들기
    Call h_Srate세팅하기
End Sub


Sub z_테스트()

    ' 샘플 케이스의 기수표 출력
    Dim startTime As Double                                 ' 시작시간
    Dim passedTime As Double                              ' 걸린시간
    
    Application.ScreenUpdating = False
    
    l0 = 100000
    
    With Worksheets("테스트")
    
        ' ⓐ B~C열의 정보 읽기
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
    
    Application.StatusBar = "계산 中"
    
    ' ⓑ 계산하기

     
        Call c_코드세팅하기

        ' Call d_사업비세팅하기

        Call e_위험률세팅하기

        Call f_기수식계산하기

        Call g_PV계산하기
        
      
        
        
    ' ⓒ 계산결과 출력
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

Sub z_클리어()
    With Worksheets("테스트")
        .Range("F5:BZ49").ClearContents
        .Range("F3:BX3").ClearContents
        .Range("CA5:CD5").ClearContents
        .Range("CA7:CD7").ClearContents
    End With
End Sub


