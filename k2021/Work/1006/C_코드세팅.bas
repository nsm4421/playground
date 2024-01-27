Attribute VB_Name = "c_코드세팅"
Sub c_코드세팅하기()


    Dim startRow As Integer
    Dim cntRow As Integer
    Dim benefitNum As Integer
    
    Erase QxKey, BxKey
    Erase riskType_exit, riskType_benefit
    GxKey = ""
    riskType_grant = ""
        
    With Worksheets("코드").Range("Tab_Code")
        ' 시작행
        For RR = 1 To .Rows.Count
            If .Cells(RR, 6) = KEY Then
                startRow = RR
                Exit For
            End If
        Next RR
        
        ' 오류
        If startRow = 0 Then
            MsgBox KEY & "에 해당하는 키값이 코드 시트 F열 상에 존재하지 않음"
            Exit Sub
        End If
        
        ' 개수
        For RR = startRow To .Rows.Count
            
            If .Cells(RR, 6) <> KEY Or RR = .Rows.Count Then
                Exit For
            End If
            cntRow = cntRow + 1
        Next RR
        
        For RR = startRow To startRow + cntRow - 1
            benefitNum = .Cells(RR, 7)
            ' 납입
            If benefitNum = 99 Then
                GxKey = .Cells(RR, 18)                                                ' 납면 위험률코드
                riskType_grant = .Cells(RR, 19)                                     ' 납면 위험률코드 type
                invalidPeriod = .Cells(RR, 21)                                       ' 무효해지 기간 (단위 : 月)
            Else
                ' 급부지급
                If benefitNum <> 0 Then
                    BxKey(benefitNum) = .Cells(RR, 12)                          ' 급부율 위험률코드
                    riskType_benefit(benefitNum) = .Cells(RR, 13)            ' 급부율 위험률코드 type
                    DefryRate(benefitNum) = .Cells(RR, 15)                     ' 지급률
                    ReducRate(benefitNum) = .Cells(RR, 16)                    ' 감액률
                    ReducPeriod(benefitNum) = .Cells(RR, 17)                 ' 감액기간
                End If
                 
                 ' 탈퇴
                QxKey(benefitNum) = .Cells(RR, 8)
                riskType_exit(benefitNum) = .Cells(RR, 9)
                NonCov(benefitNum) = .Cells(RR, 11)
                
            End If
        Next RR
    End With
    

    
End Sub



Sub c_코드테스트()

   
    
    Call c_코드세팅하기
    
    MsgBox KEY & "담보의 정보"
    
    For benefitNum = 0 To 12
        If QxKey(benefitNum) = "" Then
            Exit For
        End If
        MsgBox "QxKey(" & benefitNum & ") : " & QxKey(benefitNum) & " / 부담보기간 : " & NonCov(benefitNum)
    Next benefitNum
    
    For benefitNum = 1 To 12
        If BxKey(benefitNum) = "" Then
            Exit For
        End If
        MsgBox "BxKey(" & benefitNum & ") : " & BxKey(benefitNum) & " / 지급률 : " & DefryRate(benefitNum) _
                & " / 감액기간 : " & ReducPeriod(benefitNum) & " / 감액률 : " & ReducRate(benefitNum)
    Next benefitNum

    If GxKey <> "" Then
        MsgBox "GxKey ---> " & GxKey & " / 무효해지기간 : " & invalidPeriod
    End If
    

End Sub
