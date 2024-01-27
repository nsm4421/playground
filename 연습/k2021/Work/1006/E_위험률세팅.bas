Attribute VB_Name = "e_���������"
Sub e_����������ϱ�()

    Erase Qx, Bx, Gx
    '---------------------------------------------------------------------------------------------
    ' ��������� ���� ���� ����
    Dim haveToMakeCombRiskRate As Boolean
    haveToMakeCombRiskRate = False
    For benefitNum = 0 To 12
        If riskType_exit(benefitNum) = "C" Then
            haveToMakeCombRiskRate = True
        End If
        If riskType_benefit(benefitNum) = "C" Then
            haveToMakeCombRiskRate = True
        End If
    Next benefitNum
    If riskType_grant = "C" Then
        haveToMakeCombRiskRate = True
    End If
    
    If haveToMakeCombRiskRate Then
        Call d_��������������
        
    End If
  
    '---------------------------------------------------------------------------------------------
    ' Qx (Ż����)
    For benefitNum = 0 To 12
        If QxKey(benefitNum) = "" Then
            Exit For
        Else
            If riskType_exit(benefitNum) = "" Or riskType_exit(benefitNum) = "C" Then
            '---------------------------------------------------------------------------------------------
            ' �Ϲ����� ���
                For tt = x To 120
                    Qx(benefitNum, tt) = QxDict(QxKey(benefitNum))(sex, 0, tt)
                Next tt
            '---------------------------------------------------------------------------------------------
            ' ������⺰ ����� �����ϱ�
            ElseIf riskType_exit(benefitNum) = "M" Then
                For tt = x To 120
                    Qx(benefitNum, tt) = QxDict(QxKey(benefitNum))(sex, tt - firstJoinAge, firstJoinAge)
                Next tt
            Else
                MsgBox "ERROR : Ż�� ����� type�� " & riskType_exit(benefitNum) & "�� �����Ǿ� ����"
            End If
        End If
    Next benefitNum
        
    '---------------------------------------------------------------------------------------------
    ' Bx (�޺���)
    For benefitNum = 1 To 12
        If BxKey(benefitNum) = "" Then
            Exit For
        Else
            If riskType_benefit(benefitNum) = "" Or riskType_benefit(benefitNum) = "C" Then
            '---------------------------------------------------------------------------------------------
            ' �Ϲ����� ���
                For tt = x To 120
                    Bx(benefitNum, tt) = QxDict(BxKey(benefitNum))(sex, 0, tt)
                Next tt
            '---------------------------------------------------------------------------------------------
            ' ������⺰ ����� �����ϱ�
            ElseIf riskType_benefit(benefitNum) = "M" Then
                For tt = x To 120
                    Bx(benefitNum, tt) = QxDict(BxKey(benefitNum))(sex, tt - firstJoinAge, firstJoinAge)
                Next tt
            Else
                MsgBox "ERROR : �޺� ����� type�� " & riskType_benefit(benefitNum) & "�� �����Ǿ� ����"
            End If
        End If
    Next benefitNum
    


    '---------------------------------------------------------------------------------------------
    ' Gx (���Ը�����)

    If GxKey <> "" Then
        If riskType_grant = "" Or riskType_grant = "C" Then
        '---------------------------------------------------------------------------------------------
        ' �Ϲ����� ���
            For tt = x To 120
                Gx(tt) = QxDict(GxKey)(sex, 0, tt)
            Next tt
        '---------------------------------------------------------------------------------------------
        ' ������⺰ ����� �����ϱ�
        ElseIf riskType_grant = "M" Then
            For tt = x To 120
                Gx(tt) = QxDict(GxKey)(sex, tt - firstJoinAge, firstJoinAge)
            Next tt
        Else
            MsgBox "ERROR : ���� ����� type�� " & riskType_grant & "�� �����Ǿ� ����"
        End If
    End If
End Sub
