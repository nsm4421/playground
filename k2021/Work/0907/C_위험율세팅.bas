Attribute VB_Name = "C_위험율세팅"
Sub C위험률코드세팅()

    Dim rowCnt As Long
    rowCnt = 0
    Dim rngCode As Range
    Set rngCode = Worksheets("Code").Range("Tab코드")
        
    With rngCode
    
        ' (8번째 컬럼) KEY값이 일치하는 행 찾기
        For RR = 1 To .Rows.Count
            If .Cells(RR, 8) = KEY Then
                rowCnt = RR
                Exit For
            End If
        Next RR
       
        ' 찾기 못하면 에러 메시지 출력 메세지
        If rowCnt = 0 Then
            MsgBox KEY & "를 Code 시트 J열에 찾을 수 없습니다."
            
        Else
        
            apply_Bx = .Cells(rowCont, 89)
            
            ' WxKey 배열 (납입면제율 위험률코드), Invalid (무효해지기간)
            For CC = 1 To 10
                If .Cells(rowCnt, 8 + CC) = "" Then
                    Exit For
                Else
                    WxKey(CC) = .Cells(rowCnt, 8 + CC)
                    Invalid(CC) = .Cells(rowCnt, 18 + CC)
                End If
            Next CC
            
            ' QxKey 배열 (탈퇴율 위험률코드), NonCov (부담보기간)
            If .Cells(rowCnt, 29) <> "" Then
                QxKey(0) = .Cells(rowCnt, 29)
                NonCov(0) = .Cells(rowCnt, 78)
            End If
            
            For CC = 1 To 12
                If .Cells(rowCnt, 29 + CC) = "" Then
                    Exit For
                Else
                    QxKey(CC) = .Cells(rowCnt, 29 + CC)
                    NonCov(CC) = .Cells(rowCnt, 78 + CC)
                End If
            Next CC
            
            ' Pay, Fst, Snd 배열
            For CC = 1 To 12
                Pay(CC) = .Cells(rowCnt, 39 + 3 * CC)       ' 지급률
                ReducRate(CC) = .Cells(rowCnt, 40 + 3 * CC)     ' 감액률
                ReducPeriod(CC) = .Cells(rowCnt, 41 + 3 * CC)       ' 감액기간
            Next CC
            
            ' 급부율과 탈퇴율이 다른 경우
            If .Cells(rowCnt, 91) = "Y" Then
                For CC = 1 To 12
                    BxKey(CC) = .Cells(rowCnt, 91 + CC)
                Next CC
            End If
            
        End If
    End With
    
    
    
End Sub



Sub C위험률세팅()

    ' Wx (납입면제율)
    For ii = 1 To 10
        If WxKey(ii) = "" Then
            Exit For
        Else
            For jj = 0 To 120
                If sex = 1 Then
                    Wx(ii, jj) = riskRateDictMale(WxKey(ii))(jj)
                Else
                    Wx(ii, jj) = riskRateDictFemale(WxKey(ii))(jj)
                End If
            Next jj
        End If
    Next ii
    
    ' Qx (탈퇴율)
    
    If QxKey(0) <> "" Then
        For jj = 0 To 120
            If sex = 1 Then
                Qx(0, jj) = riskRateDictMale(QxKey(0))(jj)
            Else
                Qx(0, jj) = riskRateDictFemale(QxKey(0))(jj)
            End If
        Next jj
    End If
    
    For ii = 1 To 12
        If QxKey(ii) = "" Then
            Exit For
        Else
            For jj = 0 To 120
                If sex = 1 Then
                    Qx(ii, jj) = riskRateDictMale(QxKey(ii))(jj)
                Else
                    Qx(ii, jj) = riskRateDictFemale(QxKey(ii))(jj)
                End If
            Next jj
        End If
    Next ii
    
    ' Bx (급부율)
    If apply_Bx <> "" Then
        For ii = 1 To 12
            If BxKey(ii) = "" Then
                Exit For
            Else
                For jj = 0 To 120
                    If sex = 1 Then
                        Bx(ii, jj) = riskRateDictMale(BxKey(ii))(jj)
                    Else
                        Bx(ii, jj) = riskRateDictFemale(BxKey(ii))(jj)
                    End If
                Next jj
            End If
        Next ii
    End If
End Sub
