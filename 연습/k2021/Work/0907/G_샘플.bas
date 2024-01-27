Attribute VB_Name = "G_샘플"
Sub G샘플()
    
    Application.ScreenUpdating = False
    
    Dim rngSampleInput As Range
    Set rngSampleInput = Worksheets("샘플").Range("B6:B25")
    
    exp_i = 0.0225
    exp_v = 1 / (exp_i + 1)


    With rngSampleInput
        ' 배열초기화
        Erase QxKey, WxKey, BxKey, Qx, Wx, Bx, Invalid, NonCov, Pay, ReducRate, ReducPeriod, tVx, tWx, SUMx
    
        KEY = .Cells(5, 1).Value
        amt = .Cells(6, 1).Value
        alpha1 = .Cells(7, 1).Value
        alpha2 = .Cells(8, 1).Value
        beta1 = .Cells(9, 1).Value
        beta2 = .Cells(10, 1).Value
        beta_ = .Cells(11, 1).Value
        beta5 = .Cells(12, 1).Value
        ce = .Cells(13, 1).Value
        gamma = .Cells(14, 1).Value
        Srate = .Cells(15, 1).Value
        sex = .Cells(16, 1).Value
        x = .Cells(17, 1).Value
        n = .Cells(18, 1).Value
        m = .Cells(19, 1).Value
        m_ = .Cells(20, 1).Value

        '--------- 계산 -----------
        Application.StatusBar = "계산중"
        Call B위험율사전
        Call C위험률코드세팅
        Call C위험률세팅
        Call D기수식
        Call D누적기수식
        Call D급부
        Call E보험료계산
        Call E준비금계산
        '-------------------------
    End With
    

    
    With Worksheets("샘플").Range("G3")
    
         Application.StatusBar = "기록중"
    
        For RR = 1 To 10
            .Cells(1 + RR, -1) = WxKey(RR)
            For CC = 0 To n
                .Cells(1 + RR, CC) = Wx(RR, x + CC)
            Next CC
        Next RR
        
        For RR = 0 To 12
            .Cells(12 + RR, -1) = QxKey(RR)
            For CC = 0 To n
                .Cells(12 + RR, CC) = Qx(RR, x + CC)
            Next CC
        Next RR
        
        For RR = 1 To 12
            .Cells(24 + RR, -1) = BxKey(RR)
            For CC = 0 To n
                .Cells(24 + RR, CC) = Bx(RR, x + CC)
            Next CC
        Next RR
        
        For RR = 0 To 12
            For CC = 0 To n
                .Cells(37 + RR, CC) = lx(RR, x + CC)
            Next CC
        Next RR
        
        For CC = 0 To n
            .Cells(50, CC) = lx_(x + CC)
            .Cells(51, CC) = Dx(x + CC)
            .Cells(52, CC) = Dx_(x + CC)
        Next CC
    
            
        For RR = 1 To 12
            For CC = 0 To n
                .Cells(52 + RR, CC) = Cx(RR, x + CC)
                .Cells(65 + RR, CC) = Mx(RR, x + CC)
            Next CC
        Next RR
        

        
        For CC = 0 To n
            .Cells(78, CC) = SUMx(x + CC)
            .Cells(79, CC) = tVx(x + CC)
            .Cells(80, CC) = tWx(x + CC)
        Next CC
        

    End With
     Application.StatusBar = False
End Sub


Sub Clear샘플()

' Clear샘플 매크로

    Range("E4:BM89").Select
    Selection.ClearContents
End Sub



