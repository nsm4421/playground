Attribute VB_Name = "D_Mapping"
Sub Mapping()

    Call D_CovInfoMapping      '<--- 담보정보 mapping
    Call D_QxMapping            '<--- Ex, Bx, Gx 배열 mapping

End Sub

Sub D_CovInfoMapping()
' 조건 : coverageKey(담보키), 성별(sex), 가입나이(x), 보험기간(n)가 미리 세팅
' 동작 : 탈퇴율,급부율, 납면율, 급부개수, 부담보, 지급률, 감액률, 감액기간, 무효해지기간 등 세팅

    Call Set_NumBenefit
    Call Set_QxKey
    Call Set_NonCov
    Call Set_PayRate
    Call Set_ReduceRate
    Call Set_ReducePeriod
    Call Set_InvalidPeriod
    Call Set_UseCombRate
    Call Set_UseSingleRate
    
End Sub


Sub D_QxMapping()

    ' ---------  초기화  --------- '
    Erase Ex, Bx, Gx

    ' ---------  탈퇴율 (Ex)  --------- '
    For NN = 0 To NumBenefit
        If ExKey(NN) <> "" Then         ' 위험률키가 없으면 pass
            For tt = x To x + n
                Ex(NN, tt) = QxDict(ExKey(NN))(tt)
            Next tt
        End If
    Next NN
    

    ' ---------  급부율 (Bx)  --------- '
    For NN = 1 To NumBenefit
        ' 오류 handling
        'If BxKey(NN) = "" Then
        '    Dim msg As String
        '    msg = "ERR : " & CoverageKey & " 담보" & BNum & "번 급부에서 급부율이 안들어옴"
        '    MsgBox msg
        '    Exit Sub
        'End If
    
        For tt = x To x + n
            Bx(NN, tt) = QxDict(BxKey(NN))(tt)
        Next tt
    Next NN

    ' ---------  납면율 (Gx)  --------- '
    If GxKey <> "" Then
        For tt = x To x + n
            Gx(tt) = QxDict(GxKey)(tt)
        Next tt
    End If

End Sub

