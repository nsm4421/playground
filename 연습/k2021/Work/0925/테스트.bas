Attribute VB_Name = "�׽�Ʈ"
Sub test()

    With Worksheets("���")
        ' INPUT ���� ����
        x = .Range("C4")
        sex = .Range("C5")
        combRiskKey = .Range("C6")
        
        ' dictionary ����
        Call B��������������
        
        ' ��������� ����
        Call B��������������
        
        ' ��� ���
        For t = 0 To 120
            .Range("F4").Offset(t, 0) = QxComb(t)
        Next t
        
    End With

End Sub
