Attribute VB_Name = "B_위험률사전만들기"
Sub B위험률사전만들기()

    Dim riskKey As String     ' 위험률키 ---> Dictionary 키
    Dim Qx_(120) As Double    ' Qx배열 ---> Dictionary 값
    
    Dim age As Long           ' 가입연령 (I열)
    Dim male As Double        ' 남자 위험률 (J열)
    Dim female As Double      ' 여자 위험률 (K열)
    Dim startRow As Long      ' 시작행 (R열)
    Dim cnt As Long           ' 개수 (S열)
        

    ' Dictionary 만들기
    If sex = 1 Then
        Set riskRateDictMale = CreateObject("Scripting.Dictionary")
    ElseIf sex = 2 Then
        Set riskRateDictFemale = CreateObject("Scripting.Dictionary")
    Else
        MsgBox "ERROR : 성별코드 오류"
    End If
    
    
    For ii = 1 To Worksheets("위험률").Range("Tab위험률키").Rows.Count
    
        ' Tab위험률정보
        With Worksheets("위험률").Range("Tab위험률키")
            riskKey = .Cells(ii, 1)                         ' P열
            startRow = .Cells(ii, 3)                        ' R열
            cnt = .Cells(ii, 4)                             ' S열
            If riskKey = "" Then
                Exit For
            End If
        End With

        
        ' Tab위험률
        With Worksheets("위험률").Range("Tab위험률")
            Erase Qx_                                   ' 배열초기화
            
            ' 시작행 ~ 시작행+개수 번째 행까지 loop 돌면서 Qx_를 채움
            For jj = startRow To startRow + cnt
                age = .Cells(jj, 9)
                If sex = 1 Then
                    Qx_(age) = .Cells(jj, 10)           ' J열(남자 위험률)
                Else
                    Qx_(age) = .Cells(jj, 11)           ' K열(여자 위험률)
                End If
            Next jj
             
            ' Dictionay에 삽입
            ' Key : riskKey(A열)    /   Value : Qx_
            If sex = 1 Then
                ' 이미 사전에 있는 위험률키가 있으면 삭제
                If riskRateDictMale.exists(riskKey) Then
                    riskRateDictMale.remvoe (riskKey)
                End If
                riskRateDictMale.Add riskKey, Qx_
            Else
                ' 이미 사전에 있는 위험률키가 있으면 삭제
                If riskRateDictFemale.exists(riskKey) Then
                    riskRateDictFemale.remvoe (riskKey)
                End If
                riskRateDictFemale.Add riskKey, Qx_
            End If
    
        End With
    Next ii
    
    
    ' 메세지 출력
    With Worksheets("위험률").Range("Tab위험률키")
        If sex = 1 Then
            MsgBox "남자위험률 사전 위험률키 " & .Rows.Count & "개 생성 완료"
        Else
            MsgBox "여자위험률 사전 위험률키 " & .Rows.Count & "개 생성 완료"
        End If
    End With
    
    
End Sub




Sub B결합위험률만들기()

    Dim riskKey As String           ' 위험률키
    Dim invalidPeriod As Integer    ' 제외기간
         
    Erase QxComb
    
    With Worksheets("결합위험률").Range("Tab결합위험률")
        For R = 1 To .Rows.Count
            If .Cells(R, 1) = combRiskKey Then
                For ii = 1 To .Cells(R, 5)
                    riskKey = .Cells(R, 3 * ii + 3)
                    invalidPeriod = .Cells(R, 3 * ii + 4)
                    For jj = x To 120
                        ' 남자
                        If sex = 1 Then
                            If jj = x Then
                                ' 무효기간
                                QxComb(jj) = QxComb(jj) + riskRateDictMale(riskKey)(jj) * (1 - invalidPeriod / 12)
                            Else
                                QxComb(jj) = QxComb(jj) + riskRateDictMale(riskKey)(jj)
                            End If
                        ' 여자
                        Else
                            If jj = x Then
                                ' 무효기간
                                QxComb(jj) = QxComb(jj) + riskRateDictFemale(riskKey)(jj) * (1 - invalidPeriod / 12)
                            Else
                                QxComb(jj) = QxComb(jj) + riskRateDictFemale(riskKey)(jj)
                            End If
                        End If
                    Next jj
                Next ii
            End If
        Next R
    End With
End Sub

