Attribute VB_Name = "D_사업비세팅"
Sub d_사업비세팅하기()

        beta1 = 0.1204
        beta2 = 0
        gamma = 0.025
        ce = 0.0196

    With Worksheets("사업비").Range("Tab_Expense")
        For RR = 1 To .Rows.Count
            If KEY = .Cells(RR, 1) Then
                alpha1 = .Cells(RR, 4 + n)
                alpha3 = .Cells(RR, 10) / 1000              ' 대천알파
                Srate = .Cells(RR, 15)
                Exit For
            End If
        Next RR
    End With

End Sub

