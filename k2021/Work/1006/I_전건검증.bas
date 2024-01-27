Attribute VB_Name = "I_���ǰ���"
Sub i_���ǰ���()
    
    Dim string���ϰ�� As String                            ' �ؽ�Ʈ ���� ���
    Dim string������ As String
    
    Dim startTime As Double
    Dim passedTime As Double

    Dim cnt As Integer
    Dim serialNum As Long
    Dim expandNum As Long
    Dim NP1, NP2, NP4, NP12 As Long
    Dim G1, G2, G4, G12 As Long
    Dim V0, V1, V2 As Long
    Dim output As String
    
    Call b_��������������
    string���ϰ�� = Application.GetOpenFilename()
    string������ = "./����.csv"
    
     ' ���� �ƹ��� ������ ���� ���Ѵٸ� ���ν��� ����
     If string���ϰ�� = "" Then
         Exit Sub
     End If
     
     startTime = Timer
     
     
     cnt = 1
Open string������ For Output As #1
    Open string���ϰ�� For Input As #2
        
        Do Until EOF(2)
        
            Line Input #2, Row
                
                splitedRow = Split(Row, ",")
                If cnt > 1 Then
                    
                    serialNum = splitedRow(0)
                    expandNum = splitedRow(1)
                    n = splitedRow(2)
                    m = splitedRow(3)
                    G12 = splitedRow(4)
                    G4 = splitedRow(5)
                    G2 = splitedRow(6)
                    G1 = splitedRow(7)
                    sex = splitedRow(8)
                    x = splitedRow(9)
                    re = splitedRow(10)
                    KEY = "ZR" & expandNum & "_" & re
        
           
                    firstJoinAge = splitedRow(12)
                    AMT = splitedRow(13)
                    V0 = splitedRow(14)
                    V1 = splitedRow(15)
                    V2 = splitedRow(16)
                    NP1 = splitedRow(17)
                    NP2 = splitedRow(18)
                    NP4 = splitedRow(19)
                    NP12 = splitedRow(20)
                    
                    '---------------------
                    Call h_�����ϱ�
                    '---------------------
                    
                    G_month = Application.Round(AMT * G_month, 0)
                    G_quarter = Application.Round(AMT * G_quarter, 0)
                    G_semi_annual = Application.Round(AMT * G_semi_annual, 0)
                    G_annual = Application.Round(AMT * G_annual, 0)
                    NP_month = Application.Round(AMT * NP_month, 0)
                    NP_quarter = Application.Round(AMT * NP_quarter, 0)
                    NP_semi_annual = Application.Round(AMT * NP_semi_annual, 0)
                    NP_annual = Application.Round(AMT * NP_annual, 0)
                                        
                    output = serialNum & "," & _
                                G_month & "," & _
                                G_quarter & "," & _
                                G_semi_annual & "," & _
                                G_annual & "," & _
                                tVx(x) & "," & _
                                tVx(x + 1) & "," & _
                                tVx(x + 2) & "," & _
                                NP_annual & "," & _
                                NP_semi_annual & "," & _
                                NP_quarter & "," & _
                                NP_month
                    Print #1, output
                End If
                cnt = cnt + 1
                           
                Application.StatusBar = cnt & "th case"
                
        Loop
        
        
    Close #1, #2
    
    passedTime = Timer - startTime
    
    H = Int(passedTime / 3600)
    m = Int(passedTime / 60) Mod 60
    S = Int(passedTime Mod 60)

  secToHHMMSS = Format(H, "00") & ":" & Format(m, "00") & ":" & Format(S, "00")
  
  MsgBox secToHHMMSS

    
  Application.StatusBar = False
  
End Sub
