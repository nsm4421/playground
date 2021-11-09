Attribute VB_Name = "H_Srate"
Sub h_Srate세팅하기()

    ' ⓐ 정기보험 순보험료
    Dim NP12_death As Double
    NP12_death = 9.30672245896399E-05
   
    Set SrateDict = CreateObject("Scripting.Dictionary")
    
    With Worksheets("사업비").Range("Tab_Expense")
        For RR = 1 To .Rows.Count
            
            KEY = .Cells(RR, 1)

            x = 40
            n = 5
            m = 5
            sex = 1
            l0 = 100000
            AMT = 1
            
            ' 상해, 운전자 급수 ---> 1
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
                        
            Call c_코드세팅하기
            Call d_사업비세팅하기
            Call e_위험률세팅하기
            Call f_기수식계산하기
            Call g_보험료계산하기
            
            ' ⓒ S rate 저장
            SrateDict.Add KEY, NP_month_full / NP12_death
            
        Next RR
    End With
End Sub



