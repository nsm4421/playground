Attribute VB_Name = "d_���������"
Sub d_��������������()

    Dim startRow As Integer
    Dim cntRow As Integer
    Dim operation As Integer
    Dim combRiskKey As String
    Dim numRiskKey As Integer
    Dim riskKey As String
    Dim period As Integer
    Dim qx_comb(2, 120, 120) As Double
    Dim product_male(120), product_female(120)  As Double
    
    
            
    With Worksheets("���������").Range("Tab_Comb")
'        ' ������
'        For RR = 1 To .Rows.Count
'            If .Cells(RR, 1) = KEY Then
'                startRow = RR
'                Exit For
'            End If
'        Next RR
'
'        ' ����
'        If startRow = 0 Then
'            MsgBox KEY & "�� �ش��ϴ� Ű���� ��������� ��Ʈ A�� �� �������� ����"
'            Exit Sub
'        End If
'
'        ' ����
'        For RR = startRow To .Rows.Count
'            cntRow = cntRow + 1
'            If .Cells(RR, 6) <> KEY Or RR = .Rows.Count Then
'                Exit For
'            End If
'        Next RR
'
'
'        For RR = startRow To startRow + cntRow
            
        For RR = 1 To .Rows.Count
            Erase qx_comb
            combRiskKey = .Cells(RR, 3)
            operation = .Cells(RR, 5)
            numRiskKey = .Cells(RR, 6)
            
            
            Select Case operation
                '------------------------------------------------------------------------------------------------------
                Case 1                                                      ' q_comb = (1-k1)q1+(1-k2)q2+.....
                    For CC = 1 To numRiskKey
                        riskKey = .Cells(RR, 4 + 3 * CC)
                        period = .Cells(RR, 5 + 3 * CC)
                        For tt = x To 120                                   ' <--- x+n���� �����ص� ok
                            If tt = x Then
                                qx_comb(1, 0, tt) = qx_comb(1, 0, tt) + QxDict(riskKey)(1, 0, tt) * (1 - period / 12)
                                qx_comb(2, 0, tt) = qx_comb(2, 0, tt) + QxDict(riskKey)(2, 0, tt) * (1 - period / 12)
                            Else
                                qx_comb(1, 0, tt) = qx_comb(1, 0, tt) + QxDict(riskKey)(1, 0, tt)
                                qx_comb(2, 0, tt) = qx_comb(2, 0, tt) + QxDict(riskKey)(2, 0, tt)
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
                    
                        
                        For tt = x To 120                                    ' <--- x+n���� �����ص� ok
                            If tt = x Then
                               product_male(tt) = product_male(tt) * (1 - QxDict(riskKey)(1, 0, tt) * (1 - period / 12))
                               product_female(tt) = product_female(tt) * (1 - QxDict(riskKey)(2, 0, tt) * (1 - period / 12))
                            Else
                               product_male(tt) = product_male(tt) * (1 - QxDict(riskKey)(1, 0, tt))
                               product_female(tt) = product_female(tt) * (1 - QxDict(riskKey)(2, 0, tt))
                            End If
                        Next tt
                        
                        For tt = x To 120                                    ' <--- x+n���� �����ص� ok
                            qx_comb(1, 0, tt) = 1 - product_male(tt)
                            qx_comb(2, 0, tt) = 1 - product_female(tt)
                        Next tt
                    Next CC
            End Select
            

            If QxDict.exists(combRiskKey) Then
                QxDict.Remove (combRiskKey)
            End If
            QxDict.Add combRiskKey, qx_comb
          

        Next RR
    End With
End Sub

