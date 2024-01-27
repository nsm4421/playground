Attribute VB_Name = "I_���ǰ���"
Sub i_���ǰ���()
    
    Dim string���ǰ�� As String                          ' csv ���� ���
    Dim savePath As String                                   ' ������ ���� ���
    
    Dim startTime As Double                                 ' ���۽ð�
    Dim passedTime As Double                              ' �ɸ��ð�

    Dim cnt As Integer
    Dim output As String                                     ' ��°��
    
    
    exp_i = 0.025
    exp_v = 1 / (1 + exp_i)
    l0 = 100000
    cnt = 1
    savePath = "./����.csv"
    
    Call b_��������������
    Call h_Srate�����ϱ�
        
    Application.StatusBar = True
    
    ' �� ���� ���� �б�
    string���ǰ�� = Application.GetOpenFilename()
     If string���ǰ�� = "" Then         ' ���� �ƹ��� ������ ���� ���Ѵٸ� ���ν��� ����
         Exit Sub
     End If
     

    startTime = Timer
     Open savePath For Output As #1
        Open string���ǰ�� For Input As #2
            
            Do Until EOF(2)
                
                ' �� ���� ���� �а� ����
                Line Input #2, Row
                                        
                    splitedRow = Split(Row, ",")
                    
                    If cnt > 1 Then                         ' Header�� ����
                        
                        KEY = splitedRow(0)
                        n = splitedRow(1)
                        m = splitedRow(2)
                        
                        sex = splitedRow(5)
                        x = splitedRow(6)
                        If splitedRow(7) <> "^" Then
                            injure = splitedRow(7)
                            KEY = KEY & "_" & injure
                        End If
                        If splitedRow(8) <> "^" Then
                            driver = splitedRow(8)
                            KEY = KEY & "_" & driver
                        End If
                        
                        AMT = splitedRow(9)
                        
                        ' �� ����ϱ�
                        Call c_�ڵ弼���ϱ�
                        Call d_��������ϱ�
                        Call e_����������ϱ�
                        Call f_����İ���ϱ�
                        Call g_PV����ϱ�
                                       
                        
                        ' �� ��� ����ϱ�
                        output = NP_annual & "," & NP_month & "," & _
                                    G_annual & "," & G_month & "," & _
                                    tVx(x) & "," & tVx(x + 1) & "," & tVx(x + 2) & "," & tVx(x + 3) & "," & tVx(x + 4) & "," & tVx(x + 5) & "," & _
                                    alpha_std & "," & alpha_apply
                                    
                        Print #1, output
                        
                    End If
                    cnt = cnt + 1
                               
                    Application.StatusBar = cnt & "th case"
                    
            Loop
            
            
         Close #1, #2
        
        
    ' �ɸ��ð� ���
    
    passedTime = Timer - startTime
    
    H = Int(passedTime / 3600)
    m = Int(passedTime / 60) Mod 60
    S = Int(passedTime Mod 60)

    secToHHMMSS = Format(H, "00") & ":" & Format(m, "00") & ":" & Format(S, "00")
    
    MsgBox secToHHMMSS
    
  Application.StatusBar = False
  


  
End Sub


Sub i_���ǰ���()

    exp_i = 0.025
    exp_v = 1 / (1 + exp_i)
    l0 = 100000

    Call b_��������������

    startTime = Timer
    
    With Worksheets("����")
        For RR = 3 To 16582
            Application.StatusBar = RR - 2 & " th case"
            
            KEY = .Cells(RR, 2)
            n = .Cells(RR, 4)
            m = .Cells(RR, 5)
            sex = .Cells(RR, 8)
            x = .Cells(RR, 9)
            If .Cells(RR, 10) <> "^" Then
                injure = .Cells(RR, 10)
            End If
            If .Cells(RR, 11) <> "^" Then
                driver = .Cells(RR, 11)
            End If
            AMT = .Cells(RR, 12)
            
            Call c_�ڵ弼���ϱ�
            Call d_��������ϱ�
            Call e_����������ϱ�
            Call f_����İ���ϱ�
            Call g_PV����ϱ�
            
             NP_month = Application.Round(NP_month_full * AMT, 0)
            If NP_month <> .Cells(RR, 13) Then
                .Cells(RR, 24) = "X"
            End If
            
            G_month = Application.Round(G_month_full * AMT, 0)
            If G_month <> .Cells(RR, 15) Then
                .Cells(RR, 25) = "X"
            End If
            
            ' �غ�� �°� ����?
            For tt = 0 To n
                If tVx(x + tt) <> .Cells(RR, 16 + tt) Then
                    .Cells(RR, 26) = "X"
                    Exit For
                End If
            Next tt
            
            ' �Ű��� �°� ����?
            If alpha_apply <> .Cells(RR, 22) Then
                .Cells(RR, 27) = "X"
            End If
            
            If alpha_std - .Cells(RR, 23) > 0.00000001 Or alpha_std - .Cells(RR, 23) < -0.00000001 Then
                .Cells(RR, 28) = alpha_std - .Cells(RR, 23)
            End If

        Next RR
    End With
    
    passedTime = Timer - startTime
    
    H = Int(passedTime / 3600)
    m = Int(passedTime / 60) Mod 60
    S = Int(passedTime Mod 60)

    secToHHMMSS = Format(H, "00") & ":" & Format(m, "00") & ":" & Format(S, "00")
    
    MsgBox "16580 �� �����ϴµ� �ɸ��ð� ---> " & secToHHMMSS
    
    Application.StatusBar = False
End Sub
