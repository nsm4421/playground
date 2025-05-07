Attribute VB_Name = "B_��������������"
Sub B��������������()

    Dim riskKey As String     ' �����Ű ---> Dictionary Ű
    Dim Qx_(120) As Double    ' Qx�迭 ---> Dictionary ��
    
    Dim age As Long           ' ���Կ��� (I��)
    Dim male As Double        ' ���� ����� (J��)
    Dim female As Double      ' ���� ����� (K��)
    Dim startRow As Long      ' ������ (R��)
    Dim cnt As Long           ' ���� (S��)
        

    ' Dictionary �����
    If sex = 1 Then
        Set riskRateDictMale = CreateObject("Scripting.Dictionary")
    ElseIf sex = 2 Then
        Set riskRateDictFemale = CreateObject("Scripting.Dictionary")
    Else
        MsgBox "ERROR : �����ڵ� ����"
    End If
    
    
    For ii = 1 To Worksheets("�����").Range("Tab�����Ű").Rows.Count
    
        ' Tab���������
        With Worksheets("�����").Range("Tab�����Ű")
            riskKey = .Cells(ii, 1)                         ' P��
            startRow = .Cells(ii, 3)                        ' R��
            cnt = .Cells(ii, 4)                             ' S��
            If riskKey = "" Then
                Exit For
            End If
        End With

        
        ' Tab�����
        With Worksheets("�����").Range("Tab�����")
            Erase Qx_                                   ' �迭�ʱ�ȭ
            
            ' ������ ~ ������+���� ��° ����� loop ���鼭 Qx_�� ä��
            For jj = startRow To startRow + cnt
                age = .Cells(jj, 9)
                If sex = 1 Then
                    Qx_(age) = .Cells(jj, 10)           ' J��(���� �����)
                Else
                    Qx_(age) = .Cells(jj, 11)           ' K��(���� �����)
                End If
            Next jj
             
            ' Dictionay�� ����
            ' Key : riskKey(A��)    /   Value : Qx_
            If sex = 1 Then
                ' �̹� ������ �ִ� �����Ű�� ������ ����
                If riskRateDictMale.exists(riskKey) Then
                    riskRateDictMale.remvoe (riskKey)
                End If
                riskRateDictMale.Add riskKey, Qx_
            Else
                ' �̹� ������ �ִ� �����Ű�� ������ ����
                If riskRateDictFemale.exists(riskKey) Then
                    riskRateDictFemale.remvoe (riskKey)
                End If
                riskRateDictFemale.Add riskKey, Qx_
            End If
    
        End With
    Next ii
    
    
    ' �޼��� ���
    With Worksheets("�����").Range("Tab�����Ű")
        If sex = 1 Then
            MsgBox "��������� ���� �����Ű " & .Rows.Count & "�� ���� �Ϸ�"
        Else
            MsgBox "��������� ���� �����Ű " & .Rows.Count & "�� ���� �Ϸ�"
        End If
    End With
    
    
End Sub




Sub B��������������()

    Dim riskKey As String           ' �����Ű
    Dim invalidPeriod As Integer    ' ���ܱⰣ
         
    Erase QxComb
    
    With Worksheets("���������").Range("Tab���������")
        For R = 1 To .Rows.Count
            If .Cells(R, 1) = combRiskKey Then
                For ii = 1 To .Cells(R, 5)
                    riskKey = .Cells(R, 3 * ii + 3)
                    invalidPeriod = .Cells(R, 3 * ii + 4)
                    For jj = x To 120
                        ' ����
                        If sex = 1 Then
                            If jj = x Then
                                ' ��ȿ�Ⱓ
                                QxComb(jj) = QxComb(jj) + riskRateDictMale(riskKey)(jj) * (1 - invalidPeriod / 12)
                            Else
                                QxComb(jj) = QxComb(jj) + riskRateDictMale(riskKey)(jj)
                            End If
                        ' ����
                        Else
                            If jj = x Then
                                ' ��ȿ�Ⱓ
                                QxComb(jj) = QxComb(jj) + riskRateDictFemale(riskKey)(jj) * (1 - invalidPeriod / 12)
                            Else
                                QxComb(jj) = QxComb(jj) + riskRateDictFemale(riskKey)(jj)
                            End If
                        End If
                    Next jj
                Next ii
            End If
        Next R
    End With
End Sub

