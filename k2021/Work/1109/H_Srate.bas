Attribute VB_Name = "H_Srate"
Sub h_Srate�����ϱ�()

    ' �� ���⺸�� �������
    Dim NP12_death As Double
    NP12_death = 9.30672245896399E-05
   
    Set SrateDict = CreateObject("Scripting.Dictionary")
    
    With Worksheets("�����").Range("Tab_Expense")
        For RR = 1 To .Rows.Count
            
            KEY = .Cells(RR, 1)

            x = 40
            n = 5
            m = 5
            sex = 1
            l0 = 100000
            AMT = 1
            
            ' ����, ������ �޼� ---> 1
            If .Cells(RR, 3) <> "^" Then
                injure = .Cells(RR, 3)
            Else
                injure = 0
            End If
            
            If .Cells(RR, 4) <> "^" Then
                driver = .Cells(RR, 4)
            Else
                driver = 0
            End If
                        
            Call c_�ڵ弼���ϱ�
            Call d_��������ϱ�
            Call e_����������ϱ�
            Call f_����İ���ϱ�
            Call g_��������ϱ�
            
            ' �� S rate ����
            SrateDict.Add KEY, NP_month_full / NP12_death
            
        Next RR
    End With
End Sub



