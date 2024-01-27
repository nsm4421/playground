Attribute VB_Name = "B_위험률사전"
Sub B위험율사전()

    Dim dictKey As String      ' Dictionary 키
    Dim dictValue(120) As Double    ' Dictionary 값
    Dim age As Long     ' 가입연령
    Dim male As Double    ' 남자 위험률
    Dim female As Double      ' 여자 위험률
    Dim startRow As Long    ' 시작행
    Dim cnt As Long     ' 개수
        
        
    ' Dictionary 객체 초기화
    If sex = 1 Then
        Set riskRateDictMale = CreateObject("Scripting.Dictionary")
    Else
        Set riskRateDictFemale = CreateObject("Scripting.Dictionary")
    End If
    
    ' 위험률 코드마다 loop
    For ii = 1 To Worksheets("위험률").Range("Tab위험률코드").Rows.Count
    
        ' Tab위험률정보
        With Worksheets("위험률").Range("Tab위험률코드")
            dictKey = .Cells(ii, 1)
            startRow = .Cells(ii, 2)
            cnt = .Cells(ii, 3)
        End With

        
        ' Tab위험률
        With Worksheets("위험률").Range("Tab위험률")
            Erase dictValue
            For jj = startRow To startRow + cnt
                age = .Cells(jj, 9)
                If sex = 1 Then
                    dictValue(age) = .Cells(jj, 10)    ' 남자 위험률
                Else
                    dictValue(age) = .Cells(jj, 11)    ' 여자 위험률
                End If
            Next jj
            
            ' Dictionay에 삽입
            If sex = 1 Then
                If riskRateDictMale.exists(dictKey) Then
                    riskRateDictMale.remvoe (dictKey)
                End If
                riskRateDictMale.Add dictKey, dictValue
            Else
                If riskRateDictFemale.exists(dictKey) Then
                    riskRateDictFemale.remvoe (dictKey)
                End If
                riskRateDictFemale.Add dictKey, dictValue
            End If
    
        End With
    Next ii
    
 

End Sub
