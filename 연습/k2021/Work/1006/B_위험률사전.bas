Attribute VB_Name = "b_���������"
Sub b_��������������()

    Dim riskCode As String
    Dim sub1 As String                  ' ��������
    Dim age As Long
    Dim qx_(2, 120, 120) As Double      ' sex, sub1, age
    Dim cnt As Long
    
    Dim male As Double
    Dim female As Double
    
    ' Dictionary �����
    Set QxDict = CreateObject("Scripting.Dictionary")
    
    With Worksheets("�����").Range("TAB_Qx")
        For RR = 1 To .Rows.Count
        
            riskCode = .Cells(RR, 1)
            
            If .Cells(RR, 2) = "ZZ" Then
                sub1 = 0
            Else
                sub1 = .Cells(RR, 2)
            End If
            
            age = .Cells(RR, 8)
            male = .Cells(RR, 9)
            female = .Cells(RR, 10)
            qx_(1, Int(sub1), age) = male
            qx_(2, Int(sub1), age) = female
           
            If RR = .Rows.Count Or .Cells(RR, 1) <> .Cells(RR + 1, 1) Then
                    If QxDict.exists(riskCode) Then
                        QxDict.Remove (riskCode)
                    End If
                    QxDict.Add riskCode, qx_
                    Erase qx_
                    cnt = cnt + 1
            End If
        Next RR
    End With

    MsgBox "Ű���� " & cnt & "���� ������ ����� ���� ����"
    
End Sub


Sub b_������׽�Ʈ()

  

    Dim riskCode As String
    
    
    
    Call b_��������������
    Call d_��������������
    With Worksheets("�����").Range("O3")
        riskCode = .Offset(0, 1)
        x = .Offset(0, 3)
        sex = .Offset(0, 5)
        firstJoinAge = .Offset(0, 7)

        
        .Offset(2 + tt, 0) = "x+t"
        .Offset(2 + tt, 1) = "qx+t"
        For tt = x To 120
            .Offset(3 + tt, 0) = x + tt
            If firstJoinAge = 0 Then
                .Offset(3 + tt, 1) = QxDict(riskCode)(sex, 0, x + tt)
            Else
                .Offset(3 + tt, 1) = QxDict(riskCode)(sex, tt - firstJoinAge, firstJoinAge)
            End If
        Next tt
    End With
End Sub
   
    
