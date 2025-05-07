Attribute VB_Name = "b_���������"
Sub b_��������������()

    ' QxDict��� dictionary(key, value ����� �ڷᱸ��)�� ����
        ' key : �����Ű (A��)
        ' value : qx(2, 120) - ����, ���ɺ� qx

    Dim riskKey As String                                           ' �����Ű (A��)
    Dim x As Long                                                    ' ���� (H��)
    Dim cnt As Long                                                  ' �����Ű�� ���� ī������ ����
    Dim male As Double                                             ' �� ����� (I��)
    Dim female As Double                                           ' �� �����(J��)
    Dim qx_(2, 120) As Double                                     ' ��, ҳ ����� �迭
    
    ' �� Dictionary �����
    Set QxDict = CreateObject("Scripting.Dictionary")

    With Worksheets("�����").Range("Tab_Qx")
        For RR = 1 To .Rows.Count
        
            riskKey = .Cells(RR, 1)
            male = .Cells(RR, 9)
            female = .Cells(RR, 10)
            
            ' �� qx_ �迭 ä���
                ' ���Ϸ� : ����(x)�� ZZ�� ��� ���Ϸ�
                If .Cells(RR, 8) = "ZZ" Then
                    For ii = 0 To 120
                        qx_(1, ii) = male
                        qx_(2, ii) = female
                    Next ii
                ' ������
                Else
                    x = .Cells(RR, 8)
                    qx_(1, x) = male
                    qx_(2, x) = female
                End If
           
            ' �� qx_ �迭�� �ϼ��� ��� key, value�� dictionary�� ����
            If RR = .Rows.Count Or .Cells(RR, 1) <> .Cells(RR + 1, 1) Then
                If QxDict.exists(riskKey) Then
                    QxDict.Remove (riskKey)
                End If
                QxDict.Add riskKey, qx_
                cnt = cnt + 1
                 Erase qx_          ' qx_ �ʱ�ȭ
            End If
                       
        Next RR
    End With

    ' MsgBox "Ű���� " & cnt & "���� ������ ����� ���� ����"
    
End Sub


Sub b_������׽�Ʈ�ϱ�()

    ' O2~T2�� �Է��� ������ �ش��ϴ� q�� ���

    Dim rKey As String
    Dim a As Double
    
    With Worksheets("�����")
            
        rKey = .Range("P2")
        x = .Range("R2")
        sex = .Range("T2")
    
        If QxDict.exists(rKey) Then
            MsgBox "�����Ű : " & rKey & " /  x  : " & x & " / sex : " & sex & " / q : " & QxDict(rKey)(sex, x)
        Else
            MsgBox "�����Ű : " & rKey & "�� �ش��ϴ� ����� Ű ����"
        End If

    End With

End Sub
