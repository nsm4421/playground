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
        
        startRow = RowDict(KEY)(1)
        endRow = RowDict(KEY)(2)
        

        For RR = startRow To endRow
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



Sub c_행사전만들기()

    Dim previousKey As String
    Dim currentKey As String
    Dim startRow As Long
    Dim endRow As Long
    Dim rowArray(2) As Long
    

    Set RowDict = CreateObject("Scripting.Dictionary")


    With Worksheets("코드").Range("Tab_Code")
    
        previousKey = .Cells(1, 6)
        currentKey = .Cells(1, 6)
        startRow = 1
        
        For RR = 1 To .Rows.Count
                
            currentKey = .Cells(RR, 6)
            
            endRow = endRow + 1
            
            If currentKey <> previousKey Or RR = .Rows.Count Then
                If RowDict.exists(previousKey) Then
                    RowDict.Remove (previousKey)
                End If
                RowDict.Add previousKey, rowArray
                Erase rowArray
                startRow = RR
            End If
            
            previousKey = currentKey
            
            rowArray(1) = startRow
            rowArray(2) = endRow
            
        Next RR
        
    End With
    
    
End Sub
