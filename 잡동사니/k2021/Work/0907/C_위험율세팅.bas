Attribute VB_Name = "C_����������"
Sub C������ڵ弼��()

    Dim rowCnt As Long
    rowCnt = 0
    Dim rngCode As Range
    Set rngCode = Worksheets("Code").Range("Tab�ڵ�")
        
    With rngCode
    
        ' (8��° �÷�) KEY���� ��ġ�ϴ� �� ã��
        For RR = 1 To .Rows.Count
            If .Cells(RR, 8) = KEY Then
                rowCnt = RR
                Exit For
            End If
        Next RR
       
        ' ã�� ���ϸ� ���� �޽��� ��� �޼���
        If rowCnt = 0 Then
            MsgBox KEY & "�� Code ��Ʈ J���� ã�� �� �����ϴ�."
            
        Else
        
            apply_Bx = .Cells(rowCont, 89)
            
            ' WxKey �迭 (���Ը����� ������ڵ�), Invalid (��ȿ�����Ⱓ)
            For CC = 1 To 10
                If .Cells(rowCnt, 8 + CC) = "" Then
                    Exit For
                Else
                    WxKey(CC) = .Cells(rowCnt, 8 + CC)
                    Invalid(CC) = .Cells(rowCnt, 18 + CC)
                End If
            Next CC
            
            ' QxKey �迭 (Ż���� ������ڵ�), NonCov (�δ㺸�Ⱓ)
            If .Cells(rowCnt, 29) <> "" Then
                QxKey(0) = .Cells(rowCnt, 29)
                NonCov(0) = .Cells(rowCnt, 78)
            End If
            
            For CC = 1 To 12
                If .Cells(rowCnt, 29 + CC) = "" Then
                    Exit For
                Else
                    QxKey(CC) = .Cells(rowCnt, 29 + CC)
                    NonCov(CC) = .Cells(rowCnt, 78 + CC)
                End If
            Next CC
            
            ' Pay, Fst, Snd �迭
            For CC = 1 To 12
                Pay(CC) = .Cells(rowCnt, 39 + 3 * CC)       ' ���޷�
                ReducRate(CC) = .Cells(rowCnt, 40 + 3 * CC)     ' ���׷�
                ReducPeriod(CC) = .Cells(rowCnt, 41 + 3 * CC)       ' ���ױⰣ
            Next CC
            
            ' �޺����� Ż������ �ٸ� ���
            If .Cells(rowCnt, 91) = "Y" Then
                For CC = 1 To 12
                    BxKey(CC) = .Cells(rowCnt, 91 + CC)
                Next CC
            End If
            
        End If
    End With
    
    
    
End Sub



Sub C���������()

    ' Wx (���Ը�����)
    For ii = 1 To 10
        If WxKey(ii) = "" Then
            Exit For
        Else
            For jj = 0 To 120
                If sex = 1 Then
                    Wx(ii, jj) = riskRateDictMale(WxKey(ii))(jj)
                Else
                    Wx(ii, jj) = riskRateDictFemale(WxKey(ii))(jj)
                End If
            Next jj
        End If
    Next ii
    
    ' Qx (Ż����)
    
    If QxKey(0) <> "" Then
        For jj = 0 To 120
            If sex = 1 Then
                Qx(0, jj) = riskRateDictMale(QxKey(0))(jj)
            Else
                Qx(0, jj) = riskRateDictFemale(QxKey(0))(jj)
            End If
        Next jj
    End If
    
    For ii = 1 To 12
        If QxKey(ii) = "" Then
            Exit For
        Else
            For jj = 0 To 120
                If sex = 1 Then
                    Qx(ii, jj) = riskRateDictMale(QxKey(ii))(jj)
                Else
                    Qx(ii, jj) = riskRateDictFemale(QxKey(ii))(jj)
                End If
            Next jj
        End If
    Next ii
    
    ' Bx (�޺���)
    If apply_Bx <> "" Then
        For ii = 1 To 12
            If BxKey(ii) = "" Then
                Exit For
            Else
                For jj = 0 To 120
                    If sex = 1 Then
                        Bx(ii, jj) = riskRateDictMale(BxKey(ii))(jj)
                    Else
                        Bx(ii, jj) = riskRateDictFemale(BxKey(ii))(jj)
                    End If
                Next jj
            End If
        Next ii
    End If
End Sub
