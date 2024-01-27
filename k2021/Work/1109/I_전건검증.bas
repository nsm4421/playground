Attribute VB_Name = "I_전건검증"
Sub i_전건검증()
    
    Dim string대상건경로 As String                          ' csv 파일 경로
    Dim savePath As String                                   ' 저장할 파일 경로
    
    Dim startTime As Double                                 ' 시작시간
    Dim passedTime As Double                              ' 걸린시간

    Dim cnt As Integer
    Dim output As String                                     ' 출력결과
    
    
    exp_i = 0.025
    exp_v = 1 / (1 + exp_i)
    l0 = 100000
    cnt = 1
    savePath = "./저장.csv"
    
    Call b_위험률사전만들기
    Call h_Srate세팅하기
        
    Application.StatusBar = True
    
    ' ⓐ 대상건 파일 읽기
    string대상건경로 = Application.GetOpenFilename()
     If string대상건경로 = "" Then         ' 만약 아무런 파일을 선택 안한다면 프로시저 종료
         Exit Sub
     End If
     

    startTime = Timer
     Open savePath For Output As #1
        Open string대상건경로 For Input As #2
            
            Do Until EOF(2)
                
                ' ⓑ 대상건 한줄 읽고 세팅
                Line Input #2, Row
                                        
                    splitedRow = Split(Row, ",")
                    
                    If cnt > 1 Then                         ' Header는 무시
                        
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
                        
                        ' ⓒ 계산하기
                        Call c_코드세팅하기
                        Call d_사업비세팅하기
                        Call e_위험률세팅하기
                        Call f_기수식계산하기
                        Call g_PV계산하기
                                       
                        
                        ' ⓓ 결과 출력하기
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
        
        
    ' 걸린시간 계산
    
    passedTime = Timer - startTime
    
    H = Int(passedTime / 3600)
    m = Int(passedTime / 60) Mod 60
    S = Int(passedTime Mod 60)

    secToHHMMSS = Format(H, "00") & ":" & Format(m, "00") & ":" & Format(S, "00")
    
    MsgBox secToHHMMSS
    
  Application.StatusBar = False
  


  
End Sub


Sub i_대상건검증()

    exp_i = 0.025
    exp_v = 1 / (1 + exp_i)
    l0 = 100000

    Call b_위험률사전만들기

    startTime = Timer
    
    With Worksheets("대상건")
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
            
            Call c_코드세팅하기
            Call d_사업비세팅하기
            Call e_위험률세팅하기
            Call f_기수식계산하기
            Call g_PV계산하기
            
             NP_month = Application.Round(NP_month_full * AMT, 0)
            If NP_month <> .Cells(RR, 13) Then
                .Cells(RR, 24) = "X"
            End If
            
            G_month = Application.Round(G_month_full * AMT, 0)
            If G_month <> .Cells(RR, 15) Then
                .Cells(RR, 25) = "X"
            End If
            
            ' 준비금 맞게 산출?
            For tt = 0 To n
                If tVx(x + tt) <> .Cells(RR, 16 + tt) Then
                    .Cells(RR, 26) = "X"
                    Exit For
                End If
            Next tt
            
            ' 신계약비 맞게 산출?
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
    
    MsgBox "16580 건 검증하는데 걸린시간 ---> " & secToHHMMSS
    
    Application.StatusBar = False
End Sub
