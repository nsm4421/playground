Attribute VB_Name = "b_위험률사전"
Sub b_위험률사전만들기()

    Dim riskCode As String
    Dim sub1 As String                  ' 경과차년수
    Dim age As Long
    Dim qx_(2, 120, 120) As Double      ' sex, sub1, age
    Dim cnt As Long
    
    Dim male As Double
    Dim female As Double
    
    ' Dictionary 만들기
    Set QxDict = CreateObject("Scripting.Dictionary")
    
    With Worksheets("위험률").Range("TAB_Qx")
        For RR = 1 To .Rows.Count
        
            riskCode = .Cells(RR, 1)
            
            If .Cells(RR, 2) = "ZZ" Then
                sub1 = 0
            Else
                sub1 = .Cells(RR, 2)
            End If
            
            age = .Cells(RR, 8)
            male = .Cells(RR, 9)
            female = .Cells(RR, 10)
            qx_(1, Int(sub1), age) = male
            qx_(2, Int(sub1), age) = female
           
            If RR = .Rows.Count Or .Cells(RR, 1) <> .Cells(RR + 1, 1) Then
                    If QxDict.exists(riskCode) Then
                        QxDict.Remove (riskCode)
                    End If
                    QxDict.Add riskCode, qx_
                    Erase qx_
                    cnt = cnt + 1
            End If
        Next RR
    End With

    MsgBox "키값이 " & cnt & "개인 포함한 위험률 사전 만듬"
    
End Sub


Sub b_위험률테스트()

  

    Dim riskCode As String
    
    
    
    Call b_위험률사전만들기
    Call d_결합위험률만들기
    With Worksheets("위험률").Range("O3")
        riskCode = .Offset(0, 1)
        x = .Offset(0, 3)
        sex = .Offset(0, 5)
        firstJoinAge = .Offset(0, 7)

        
        .Offset(2 + tt, 0) = "x+t"
        .Offset(2 + tt, 1) = "qx+t"
        For tt = x To 120
            .Offset(3 + tt, 0) = x + tt
            If firstJoinAge = 0 Then
                .Offset(3 + tt, 1) = QxDict(riskCode)(sex, 0, x + tt)
            Else
                .Offset(3 + tt, 1) = QxDict(riskCode)(sex, tt - firstJoinAge, firstJoinAge)
            End If
        Next tt
    End With
End Sub
   
    
