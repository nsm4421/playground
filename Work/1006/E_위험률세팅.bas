Attribute VB_Name = "e_위험률세팅"
Sub e_위험률세팅하기()

    Erase Qx, Bx, Gx
    '---------------------------------------------------------------------------------------------
    ' 결합위험률 생성 여부 결정
    Dim haveToMakeCombRiskRate As Boolean
    haveToMakeCombRiskRate = False
    For benefitNum = 0 To 12
        If riskType_exit(benefitNum) = "C" Then
            haveToMakeCombRiskRate = True
        End If
        If riskType_benefit(benefitNum) = "C" Then
            haveToMakeCombRiskRate = True
        End If
    Next benefitNum
    If riskType_grant = "C" Then
        haveToMakeCombRiskRate = True
    End If
    
    If haveToMakeCombRiskRate Then
        Call d_결합위험률만들기
        
    End If
  
    '---------------------------------------------------------------------------------------------
    ' Qx (탈퇴율)
    For benefitNum = 0 To 12
        If QxKey(benefitNum) = "" Then
            Exit For
        Else
            If riskType_exit(benefitNum) = "" Or riskType_exit(benefitNum) = "C" Then
            '---------------------------------------------------------------------------------------------
            ' 일반적인 경우
                For tt = x To 120
                    Qx(benefitNum, tt) = QxDict(QxKey(benefitNum))(sex, 0, tt)
                Next tt
            '---------------------------------------------------------------------------------------------
            ' 경과차년별 위험률 생성하기
            ElseIf riskType_exit(benefitNum) = "M" Then
                For tt = x To 120
                    Qx(benefitNum, tt) = QxDict(QxKey(benefitNum))(sex, tt - firstJoinAge, firstJoinAge)
                Next tt
            Else
                MsgBox "ERROR : 탈퇴 위험률 type이 " & riskType_exit(benefitNum) & "로 설정되어 있음"
            End If
        End If
    Next benefitNum
        
    '---------------------------------------------------------------------------------------------
    ' Bx (급부율)
    For benefitNum = 1 To 12
        If BxKey(benefitNum) = "" Then
            Exit For
        Else
            If riskType_benefit(benefitNum) = "" Or riskType_benefit(benefitNum) = "C" Then
            '---------------------------------------------------------------------------------------------
            ' 일반적인 경우
                For tt = x To 120
                    Bx(benefitNum, tt) = QxDict(BxKey(benefitNum))(sex, 0, tt)
                Next tt
            '---------------------------------------------------------------------------------------------
            ' 경과차년별 위험률 생성하기
            ElseIf riskType_benefit(benefitNum) = "M" Then
                For tt = x To 120
                    Bx(benefitNum, tt) = QxDict(BxKey(benefitNum))(sex, tt - firstJoinAge, firstJoinAge)
                Next tt
            Else
                MsgBox "ERROR : 급부 위험률 type이 " & riskType_benefit(benefitNum) & "로 설정되어 있음"
            End If
        End If
    Next benefitNum
    


    '---------------------------------------------------------------------------------------------
    ' Gx (납입면제율)

    If GxKey <> "" Then
        If riskType_grant = "" Or riskType_grant = "C" Then
        '---------------------------------------------------------------------------------------------
        ' 일반적인 경우
            For tt = x To 120
                Gx(tt) = QxDict(GxKey)(sex, 0, tt)
            Next tt
        '---------------------------------------------------------------------------------------------
        ' 경과차년별 위험률 생성하기
        ElseIf riskType_grant = "M" Then
            For tt = x To 120
                Gx(tt) = QxDict(GxKey)(sex, tt - firstJoinAge, firstJoinAge)
            Next tt
        Else
            MsgBox "ERROR : 납면 위험률 type이 " & riskType_grant & "로 설정되어 있음"
        End If
    End If
End Sub
