Attribute VB_Name = "E_결합위험률"
Sub e_결합위험률만들기()

    Dim startRow As Integer
    Dim cntRow As Integer
    Dim operation As Integer
    Dim combRiskKey As String
    Dim numRiskKey As Integer
    Dim riskKey As String
    Dim period As Integer
    Dim qx_comb(2, 120) As Double
    Dim product_male(120), product_female(120)  As Double
    
            
    With Worksheets("결합위험률").Range("Tab_Comb")
        
        For RR = 1 To .Rows.Count
            
            If .Cells(RR, 1) = KEY Then
                
                combRiskKey = .Cells(RR, 3)
                operation = .Cells(RR, 5)
                numRiskKey = .Cells(RR, 6)
                                
                Select Case operation
                    '------------------------------------------------------------------------------------------------------
                    Case 1                                                      ' q_comb = (1-k1)q1+(1-k2)q2+.....
                        For CC = 1 To numRiskKey
                            riskKey = .Cells(RR, 4 + 3 * CC)
                            period = .Cells(RR, 5 + 3 * CC)
                            For tt = x To x + n                                 ' <--- x+n으로 수정해도 ok
                                If tt = x Then
                                    qx_comb(1, tt) = qx_comb(1, tt) + QxDict(riskKey)(1, tt) * (1 - period / 12)
                                    qx_comb(2, tt) = qx_comb(2, tt) + QxDict(riskKey)(2, tt) * (1 - period / 12)
                                Else
                                    qx_comb(1, tt) = qx_comb(1, tt) + QxDict(riskKey)(1, tt)
                                    qx_comb(2, tt) = qx_comb(2, tt) + QxDict(riskKey)(2, tt)
                                End If
                                
                            Next tt
                        Next CC
                    '------------------------------------------------------------------------------------------------------
                    Case 2                                                      ' q_comb = 1- (1-q1)(1-q2) ...
    
                    
                        For tt = x To x + n
                            product_male(tt) = 1
                            product_female(tt) = 1
                        Next tt
                        
                        For CC = 1 To numRiskKey
                            riskKey = .Cells(RR, 4 + 3 * CC)
                            period = .Cells(RR, 5 + 3 * CC)
                        
                            
                            For tt = x To x + n
                                If tt = x Then
                                   product_male(tt) = product_male(tt) * (1 - QxDict(riskKey)(1, tt) * (1 - period / 12))
                                   product_female(tt) = product_female(tt) * (1 - QxDict(riskKey)(2, tt) * (1 - period / 12))
                                Else
                                   product_male(tt) = product_male(tt) * (1 - QxDict(riskKey)(1, tt))
                                   product_female(tt) = product_female(tt) * (1 - QxDict(riskKey)(2, tt))
                                End If
                            Next tt
                            
                            For tt = x To x + n
                                qx_comb(1, tt) = 1 - product_male(tt)
                                qx_comb(2, tt) = 1 - product_female(tt)
                            Next tt
                        Next CC
                End Select
                
                    '------------------------------------------------------------------------------------------------------
    
                If QxDict.exists(combRiskKey) Then
                    QxDict.Remove (combRiskKey)
                End If
                QxDict.Add combRiskKey, qx_comb
                
                Erase qx_comb
                
            End If
        Next RR
    End With
End Sub

