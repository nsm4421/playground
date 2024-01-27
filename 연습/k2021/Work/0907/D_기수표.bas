Attribute VB_Name = "D_기수표"
Sub D기수식()
Dim tt As Integer

' ------------------- lx_ (납입자수) -------------------
lx_(x) = 100000
For idx = 1 To 10
    For t = 0 To n
        If WxKey(idx) = "" Then
            Exit For
        Else
            If t = 0 Then
                lx_(x + t + 1) = lx_(x + t) * (1 - Wx(idx, x + t) * (1 - Invalid(idx) / 12))
            Else
                lx_(x + t + 1) = lx_(x + t) * (1 - Wx(idx, x + t))
            End If
        End If
    Next t
Next idx

' ------------------- lx (유지자수) -------------------
If QxKey(0) = "" Then
    lx(0, x) = 100000
    For t = 0 To n
        lx(0, x + t + 1) = lx(0, x + t)
    Next t
Else
    lx(0, x) = 100000
    For t = 0 To n
        If t = 0 Then
            lx(0, x + t + 1) = lx(0, x + t) * (1 - Qx(0, x + t) * (1 - NonCov(0)))
        Else
            lx(0, x + t + 1) = lx(0, x + t) * (1 - Qx(0, x + t))
        End If
    Next t
End If

For idx = 1 To 12
        If QxKey(idx) = "" Then
            Exit For
        Else
            lx(idx, x) = 100000
            For t = 0 To n
                If t = 0 Then
                    lx(idx, x + t + 1) = lx(idx, x + t) * (1 - Qx(idx, x + t) * (1 - NonCov(idx)))
                Else
                    lx(idx, x + t + 1) = lx(idx, x + t) * (1 - Qx(idx, x + t))
                End If
            Next t
        End If
Next idx


' ------------------- Cx -------------------

If apply_Bx <> "Y" Then
    For idx = 1 To 12
        If QxKey(idx) = "" Then
            Exit For
        Else
            For t = 0 To n
                Cx(idx, x + t) = lx(idx, x + t) * Qx(idx, x + t) * exp_v ^ (t + 0.5)
            Next t
        End If
    Next idx
Else
    For idx = 1 To 12
        If BxKey(idx) = "" Then
            Exit For
        Else
            For t = 0 To n
                Cx(idx, x + t) = lx(idx, x + t) * Bx(idx, x + t) * exp_v ^ (t + 0.5)
            Next t
        End If
    Next idx
End If


' ------------------- Dx, D'x -------------------
For t = 0 To n
    Dx(x + t) = lx(0, x + t) * exp_v ^ t
    Dx_(x + t) = lx_(x + t) * exp_v ^ t
    
    
Next t


End Sub

Sub D누적기수식()

' ------------------- Nx, N'x -------------------
For t = x + n To x Step -1
    If t = x + n Then
        Nx(t) = Dx(t)
        Nx_(t) = Dx_(t)
    Else
        Nx(t) = Dx(t) + Nx(t + 1)
        Nx_(t) = Dx_(t) + Nx_(t + 1)
    End If
Next t

' ------------------- Mx -------------------
For t = x + n To x Step -1
    For idx = 1 To 12
        If t = x + n Then
            Mx(idx, t) = Cx(idx, t)
        Else
            Mx(idx, t) = Cx(idx, t) + Mx(idx, t + 1)
        End If
    Next idx
Next t

End Sub

Sub D급부()

Erase SUMx

Dim B As Double
B = 0
' ------------------- SUMx -------------------

For idx = 1 To 12
    If QxKey(idx) = "" Then
        Exit For
    Else
        For t = x To x + n
            ' ----- 감액 ----'
            If t - x < ReducPeriod(idx) Then
                B = Pay(idx) * ((1 - ReducRate(idx)) * (Mx(idx, t) - Mx(idx, ReducPeriod(idx)) + (Mx(idx, x + ReducPeriod(idx)) - Mx(idx, x + n))))
            Else
                B = Pay(idx) * (Mx(idx, t) - Mx(idx, x + n))
            End If
            ' ----- 지급률 -----'
            SUMx(t) = SUMx(t) + B
        Next t
        
    End If
Next idx

End Sub






