Attribute VB_Name = "e_���������"
Sub e_����������ϱ�()

    Erase Qx, Bx, Gx
    
    If makeCombRiskRate Then
        Call e_��������������
    End If
  
    '---------------------------------------------------------------------------------------------
    ' Qx (Ż����)
    For benefitNum = 0 To numBenefit
        For tt = x To x + n
            If QxKey(benefitNum) <> "" Then
                Qx(benefitNum, tt) = QxDict(QxKey(benefitNum))(sex, tt)
            End If
        Next tt
    Next benefitNum
        
    '---------------------------------------------------------------------------------------------
    ' Bx (�޺���)
    For benefitNum = 1 To numBenefit
        For tt = x To x + n
            Bx(benefitNum, tt) = QxDict(BxKey(benefitNum))(sex, tt)
        Next tt
    Next benefitNum

    '---------------------------------------------------------------------------------------------
    ' Gx (���Ը�����)

    If GxKey <> "" Then
        For tt = x To x + n
            Gx(tt) = QxDict(GxKey)(sex, tt)
        Next tt
    End If
End Sub



