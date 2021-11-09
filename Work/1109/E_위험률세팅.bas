Attribute VB_Name = "e_위험률세팅"
Sub e_위험률세팅하기()

    Erase Qx, Bx, Gx
    
    If makeCombRiskRate Then
        Call e_결합위험률만들기
    End If
  
    '---------------------------------------------------------------------------------------------
    ' Qx (탈퇴율)
    For benefitNum = 0 To numBenefit
        For tt = x To x + n
            If QxKey(benefitNum) <> "" Then
                Qx(benefitNum, tt) = QxDict(QxKey(benefitNum))(sex, tt)
            End If
        Next tt
    Next benefitNum
        
    '---------------------------------------------------------------------------------------------
    ' Bx (급부율)
    For benefitNum = 1 To numBenefit
        For tt = x To x + n
            Bx(benefitNum, tt) = QxDict(BxKey(benefitNum))(sex, tt)
        Next tt
    Next benefitNum

    '---------------------------------------------------------------------------------------------
    ' Gx (납입면제율)

    If GxKey <> "" Then
        For tt = x To x + n
            Gx(tt) = QxDict(GxKey)(sex, tt)
        Next tt
    End If
End Sub



