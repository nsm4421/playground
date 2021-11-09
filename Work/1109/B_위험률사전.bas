Attribute VB_Name = "b_위험률사전"
Sub b_위험률사전만들기()

    ' QxDict라는 dictionary(key, value 방식의 자료구조)를 생성
        ' key : 위험률키 (A열)
        ' value : qx(2, 120) - 성별, 연령별 qx

    Dim riskKey As String                                           ' 위험률키 (A열)
    Dim x As Long                                                    ' 연령 (H열)
    Dim cnt As Long                                                  ' 위험률키값 개수 카운팅할 변수
    Dim male As Double                                             ' 男 위험률 (I열)
    Dim female As Double                                           ' 女 위험률(J열)
    Dim qx_(2, 120) As Double                                     ' 男, 女 위험률 배열
    
    ' ⓐ Dictionary 만들기
    Set QxDict = CreateObject("Scripting.Dictionary")

    With Worksheets("위험률").Range("Tab_Qx")
        For RR = 1 To .Rows.Count
        
            riskKey = .Cells(RR, 1)
            male = .Cells(RR, 9)
            female = .Cells(RR, 10)
            
            ' ⓑ qx_ 배열 채우기
                ' 단일률 : 연령(x)가 ZZ인 경우 단일률
                If .Cells(RR, 8) = "ZZ" Then
                    For ii = 0 To 120
                        qx_(1, ii) = male
                        qx_(2, ii) = female
                    Next ii
                ' 연령율
                Else
                    x = .Cells(RR, 8)
                    qx_(1, x) = male
                    qx_(2, x) = female
                End If
           
            ' ⓒ qx_ 배열이 완성된 경우 key, value를 dictionary에 삽입
            If RR = .Rows.Count Or .Cells(RR, 1) <> .Cells(RR + 1, 1) Then
                If QxDict.exists(riskKey) Then
                    QxDict.Remove (riskKey)
                End If
                QxDict.Add riskKey, qx_
                cnt = cnt + 1
                 Erase qx_          ' qx_ 초기화
            End If
                       
        Next RR
    End With

    ' MsgBox "키값이 " & cnt & "개인 포함한 위험률 사전 만듬"
    
End Sub


Sub b_위험률테스트하기()

    ' O2~T2에 입력한 정보에 해당하는 q를 출력

    Dim rKey As String
    Dim a As Double
    
    With Worksheets("위험률")
            
        rKey = .Range("P2")
        x = .Range("R2")
        sex = .Range("T2")
    
        If QxDict.exists(rKey) Then
            MsgBox "위험률키 : " & rKey & " /  x  : " & x & " / sex : " & sex & " / q : " & QxDict(rKey)(sex, x)
        Else
            MsgBox "위험률키 : " & rKey & "에 해당하는 위험률 키 없음"
        End If

    End With

End Sub
