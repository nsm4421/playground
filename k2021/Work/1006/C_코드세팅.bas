Attribute VB_Name = "c_�ڵ弼��"
Sub c_�ڵ弼���ϱ�()


    Dim startRow As Integer
    Dim cntRow As Integer
    Dim benefitNum As Integer
    
    Erase QxKey, BxKey
    Erase riskType_exit, riskType_benefit
    GxKey = ""
    riskType_grant = ""
        
    With Worksheets("�ڵ�").Range("Tab_Code")
        ' ������
        For RR = 1 To .Rows.Count
            If .Cells(RR, 6) = KEY Then
                startRow = RR
                Exit For
            End If
        Next RR
        
        ' ����
        If startRow = 0 Then
            MsgBox KEY & "�� �ش��ϴ� Ű���� �ڵ� ��Ʈ F�� �� �������� ����"
            Exit Sub
        End If
        
        ' ����
        For RR = startRow To .Rows.Count
            
            If .Cells(RR, 6) <> KEY Or RR = .Rows.Count Then
                Exit For
            End If
            cntRow = cntRow + 1
        Next RR
        
        For RR = startRow To startRow + cntRow - 1
            benefitNum = .Cells(RR, 7)
            ' ����
            If benefitNum = 99 Then
                GxKey = .Cells(RR, 18)                                                ' ���� ������ڵ�
                riskType_grant = .Cells(RR, 19)                                     ' ���� ������ڵ� type
                invalidPeriod = .Cells(RR, 21)                                       ' ��ȿ���� �Ⱓ (���� : ��)
            Else
                ' �޺�����
                If benefitNum <> 0 Then
                    BxKey(benefitNum) = .Cells(RR, 12)                          ' �޺��� ������ڵ�
                    riskType_benefit(benefitNum) = .Cells(RR, 13)            ' �޺��� ������ڵ� type
                    DefryRate(benefitNum) = .Cells(RR, 15)                     ' ���޷�
                    ReducRate(benefitNum) = .Cells(RR, 16)                    ' ���׷�
                    ReducPeriod(benefitNum) = .Cells(RR, 17)                 ' ���ױⰣ
                End If
                 
                 ' Ż��
                QxKey(benefitNum) = .Cells(RR, 8)
                riskType_exit(benefitNum) = .Cells(RR, 9)
                NonCov(benefitNum) = .Cells(RR, 11)
                
            End If
        Next RR
    End With
    

    
End Sub



Sub c_�ڵ��׽�Ʈ()

   
    
    Call c_�ڵ弼���ϱ�
    
    MsgBox KEY & "�㺸�� ����"
    
    For benefitNum = 0 To 12
        If QxKey(benefitNum) = "" Then
            Exit For
        End If
        MsgBox "QxKey(" & benefitNum & ") : " & QxKey(benefitNum) & " / �δ㺸�Ⱓ : " & NonCov(benefitNum)
    Next benefitNum
    
    For benefitNum = 1 To 12
        If BxKey(benefitNum) = "" Then
            Exit For
        End If
        MsgBox "BxKey(" & benefitNum & ") : " & BxKey(benefitNum) & " / ���޷� : " & DefryRate(benefitNum) _
                & " / ���ױⰣ : " & ReducPeriod(benefitNum) & " / ���׷� : " & ReducRate(benefitNum)
    Next benefitNum

    If GxKey <> "" Then
        MsgBox "GxKey ---> " & GxKey & " / ��ȿ�����Ⱓ : " & invalidPeriod
    End If
    

End Sub
