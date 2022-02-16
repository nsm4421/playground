Attribute VB_Name = "Z_Test"
Sub Z_CoverageInfo()

    Dim cov_, result_ As String
    Dim n_benefit As Long
   
    cov_input = InputBox("담보 키를 입력", "담보정보")
   
    If cov_input <> "" And CovDict.exists(cov_input) Then
            
        ' 급부개수
        n_benefit = CovDict(cov_input & "_" & "NumBenefit")
        result_ = "급부개수 : " & n_benefit & vbNewLine

        ' 탈퇴율 코드
        For NN = 0 To NumBenefit
            result_ = result_ & "Ex(" & NN & ") -> " & BxKey = CovDict(cov_input & "_" & "ExKey") & vbNewLine
        Next NN

        ' 지급률 코드
        
        For NN = 1 To NumBenefit
            result_ = result_ & "Bx(" & NN & ") -> " & BxKey = CovDict(cov_input & "_" & "BxKey") & vbNewLine
        Next NN
        
        ' 납면률 코드
        result_ = vbNewLine & result_ & CovDict(cov_input & "_" & "GxKey") & vbNewLine

    Else

        MsgBox "CovDict에 " & cov_input & "에 해당하는 담보키 無"
        Exit Sub
        
    End If

End Sub


 

Sub Z_Print()

 

    Dim sep As String
    Dim NumBenefit As Long
    Dim rngStd As Range

 
    sep = "_"
 
 
    ' Call~~~~~~
 
    NumBenefit = CovDict(cov & sep & "NumBenefit")
    ExKey = CovDict(cov & sep & "ExKey")
    BxKey = CovDict(cov & sep & "BxKey")
    GxKey = CovDict(cov & sep & "GxKey")
 


    Set rngStd = Worksheets("~~~").Range("rngStd")
 

    With rngStd

        '  ---------  Ex  ---------

        For NN = 0 To NumBenefit

            

            .Offset(-1, NN) = ExKey(NN)

            .Offset(0, NN) = "ExKey(" & NN & ")"

 
            For tt = 0 To n

 

                .Offset(tt + 1, NN) = Ex(NN, tt + x)

            Next tt


        Next NN

        

        '  ---------  Bx  ---------

        For NN = 1 To NumBenefit

            

            .Offset(-1, NN + NumBenefit + 1) = BxKey(NN)

            .Offset(0, NN + NumBenefit + 1) = "BxKey(" & NN & ")"

 

            For tt = 0 To n

 

                .Offset(tt + 1, NN + NumBenefit + 1) = Bx(NN, tt + x)

 

            Next tt

 

        Next NN

 

        '  ---------  Gx  ---------

        .Offset(-1, 2 * NumBenefit + 2) = GxKey

        .Offset(0, 2 * NumBenefit + 2) = "GxKey"

 

        For tt = 0 To n

 

            .Offset(tt + 1, 2 * NumBenefit + 2) = Gx(tt)

 

        Next tt

 

        '  ---------  Comm  ---------

 

        ' lx

        For NN = 0 To NumBenefit

            

            .Offset(0, 2 * NumBenefit + 3 + NN) = "lx(" & NN & ")"

 

            For tt = 0 To n

 

                .Offset(tt + 1, NN + NumBenefit + 1) = lx(NN, tt + x)

 

            Next tt

 

        Next NN

 

        ' l'x

        .Offset(0, 3 * NumBenefit + 4) = "lx(" & NN & ")"

 

        For tt = 0 To n

 

            .Offset(tt + 1, NN + NumBenefit + 1) = lx(NN, tt + x)

 

        Next tt

 

 

        ' Cx

        For NN = 1 To NumBenefit

            

            .Offset(0, 3 * NumBenefit + 4 + NN) = "Cx(" & NN & ")"

 

            For tt = 0 To n

 

                .Offset(tt + 1, 3 * NumBenefit + 4 + NN) = Cx(NN, tt + x)

 

            Next tt

 

        Next NN

 

        ' Mx

        For NN = 1 To NumBenefit

            

            .Offset(0, 4 * NumBenefit + 4 + NN) = "Mx(" & NN & ")"

 

            For tt = 0 To n

 

                .Offset(tt + 1, 4 * NumBenefit + 4 + NN) = Mx(NN, tt + x)

 

            Next tt

 

        Next NN

 

    ' SUMx

        .Offset(0, 5 * NumBenefit + 5) = "SUMx"

 

        For tt = 0 To n

 

            .Offset(tt + 1, 5 * NumBenefit + 5) = SUMx(tt + x)

 

        Next tt

 

 

        '  ---------  PV  ---------

 

        .Offset(0, 5 * NumBenefit + 6) = "NP12"

        .Offset(1, 5 * NumBenefit + 6) = NP12_full

        .Offset(2, 5 * NumBenefit + 6) = NP12_round

 

        .Offset(0, 5 * NumBenefit + 7) = "G12"

        .Offset(1, 5 * NumBenefit + 7) = G12_full

        .Offset(2, 5 * NumBenefit + 7) = G12_round

 

 

        ' tVx

        .Offset(0, 5 * NumBenefit + 8) = "tVx"

 

        For tt = 0 To n

 

            .Offset(tt + 1, 5 * NumBenefit + 8) = tVx(tt + x)

 

        Next tt

 

        

        ' tWx

        .Offset(0, 5 * NumBenefit + 9) = "tWx"

 

        For tt = 0 To n

 

            .Offset(tt + 1, 5 * NumBenefit + 9) = tWx(tt + x)

 

        Next tt

 

    End With

 

End Sub
