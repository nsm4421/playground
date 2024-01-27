Attribute VB_Name = "f_기수식"
Sub f_기수식계산하기()

    Erase lx, lx_, Dx, Dx_, Nx, Nx_, Cx, Mx, SUMx

    '-------------------------------------------------------------------------------------------
    ' lx
    
    For benefitNum = 0 To 12
        
        If BxKey(benefitNum) = "" And benefitNum > 1 Then
            Exit For
        End If
        
        lx(benefitNum, x) = l0
        
        For tt = x To x + n
            If tt = x Then
                lx(benefitNum, tt + 1) = lx(benefitNum, tt) * (1 - Qx(benenfitNum, tt) * (1 - NonCov(benefitNum) / 12))
            Else
                lx(benefitNum, tt + 1) = lx(benefitNum, tt) * (1 - Qx(benenfitNum, tt))
            End If
        Next tt
        
    Next benefitNum
    
    '-------------------------------------------------------------------------------------------
    ' l'x
    
    lx_(x) = l0
    For tt = x To x + n
    
        If tt = x Then
            lx_(tt + 1) = lx_(tt) * (1 - Gx(tt) * (1 - invalidPeriod / 12))
        Else
            lx_(tt + 1) = lx_(tt) * (1 - Gx(tt))
        End If
    Next tt
    
    '-------------------------------
    ' Dx, D'x
    
    For tt = x To x + n
            Dx(tt) = lx(0, tt) * (exp_v ^ (tt - x))
            Dx_(tt) = lx_(tt) * (exp_v ^ (tt - x))
    Next tt
        
    '--------------------------------
    ' Nx, Nx_
    For tt = x + n To x Step -1
    
        Nx(tt) = Dx(tt) + Nx(tt + 1)
        Nx_(tt) = Dx_(tt) + Nx_(tt + 1)
        
    Next tt
    

    '-------------------------------------------------------------------------------------------
    
    For benefitNum = 1 To 12
    
        If BxKey(benefitNum) = "" Then
            Exit For
        End If
        
                
        '--------------------------------
        ' Cx
        For tt = x To x + n
            Cx(benefitNum, tt) = lx(benefitNum, tt) * Bx(benefitNum, tt) * (exp_v ^ (tt - x + 0.5))
        Next tt
        
        '--------------------------------
        ' Mx
        For tt = x + n To x Step -1
            Mx(benefitNum, tt) = Cx(benefitNum, tt) + Mx(benefitNum, tt + 1)
        Next tt
        
        '--------------------------------
        ' SUMx
        For tt = 0 To n
            If tt < ReducPeriod(benefitNum) Then
            
                SUMx(x + tt) = SUMx(x + tt) + DefryRate(benefitNum) * ((1 - ReducRate(benefitNum)) * Mx(benefitNum, x + tt) + ReducRate(benefitNum) * Mx(benefitNum, x + ReducPeriod(benefitNum)) - Mx(benefitNum, x + n))
            Else
          
                SUMx(x + tt) = SUMx(x + tt) + DefryRate(benefitNum) * (Mx(benefitNum, x + tt) - Mx(benefitNum, x + n))
            End If
        Next tt
    
    Next benefitNum


 

End Sub
