Attribute VB_Name = "F_����"
Sub F����()

    Application.ScreenUpdating = False
    
    Dim rngResult As Range
    Set rngResult = Worksheets("���").Range("Tab���")

    exp_i = 0.0225
    exp_v = 1 / (exp_i + 1)
    
    '------------- ������ ���� ����� ------------
    Application.StatusBar = "������ ���� ����� ��"
    sex = 1
    Call B����������
    sex = 2
    Call B����������


    With rngResult
        
        For R = 1 To .Rows.Count
        
            Application.StatusBar = R & "/" & .Rows.Count
        
            ' �迭�ʱ�ȭ
            Erase QxKey, WxKey, BxKey, Qx, Wx, Bx, Invalid, NonCov, Pay, ReducRate, ReducPeriod, tVx, tWx, SUMx
        
            KEY = .Cells(R, 5)
            amt = .Cells(R, 6)
            alpha1 = .Cells(R, 7)
            alpha2 = .Cells(R, 8)
            beta1 = .Cells(R, 9)
            beta2 = .Cells(R, 10)
            beta_ = .Cells(R, 11)
            beta5 = .Cells(R, 12)
            ce = .Cells(R, 13)
            gamma = .Cells(R, 14)
            Srate = .Cells(R, 15)
            
            sex = .Cells(R, 16)
            x = .Cells(R, 17)
            n = .Cells(R, 18)
            m = .Cells(R, 19)
            m_ = .Cells(R, 20)
            
            '--------- ��� -----------

            Call C������ڵ弼��
            Call C���������
            Call D�����
            Call D���������
            Call D�޺�
            Call E�������
            Call E�غ�ݰ��
                        
            '-------------------------
            
'            .Cells(R, 21) = NP_month
'            .Cells(R, 22) = NP_std
'            .Cells(R, 23) = BetaP
'            .Cells(R, 24) = G
'
            .Cells(R, 21) = Application.Round(NP_month * amt, 0)
            .Cells(R, 22) = Application.Round(NP_std * amt, 0)
            .Cells(R, 23) = Application.Round(BetaP * amt, 0)
            .Cells(R, 24) = Application.Round(G * amt, 0)
            
                
            For t = 0 To 40
'                .Cells(R, 25 + t) = tVx(x + t) * amt
'                .Cells(R, 66 + t) = tWx(x + t) * amt
                .Cells(R, 25 + t) = Application.Round(tVx(t + x) * amt, 0)
                .Cells(R, 66 + t) = Application.Round(tWx(t + x) * amt, 0)
            Next t
            
            
                        
        Next R
    
      
    End With
    
    Application.StatusBar = False

End Sub
