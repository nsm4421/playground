Attribute VB_Name = "테스트"
Sub test()

    With Worksheets("결과")
        ' INPUT 조건 설정
        x = .Range("C4")
        sex = .Range("C5")
        combRiskKey = .Range("C6")
        
        ' dictionary 생성
        Call B위험률사전만들기
        
        ' 결합위험률 생성
        Call B결합위험률만들기
        
        ' 결과 찍기
        For t = 0 To 120
            .Range("F4").Offset(t, 0) = QxComb(t)
        Next t
        
    End With

End Sub
