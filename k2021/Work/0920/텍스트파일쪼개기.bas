Attribute VB_Name = "�ؽ�Ʈ�����ɰ���"
Sub sub�ؽ�Ʈ�����ɰ���()
    
    ' �� ���Ͽ��� �÷��� 3���� �����س��µ� ���߿� ����� ���� �÷��� �ٲٱ�!!!!
    
    Dim string���ϰ�� As String                            ' �ؽ�Ʈ ���� ���
    Dim array���ڼ�(3) As Integer                           ' �� �÷��� ���ڼ��� �ִ� �迭
    Dim array����(3) As Variant                             ' �ؽ�Ʈ ������ �ɰ����� �迭
    Dim int���� As Integer
    Dim int�÷��� As Integer
    Dim int��� As Integer
    
    
    ' �� Tab���ڼ� �б�
    With Worksheets("Layout").Range("Tab���ڼ�")
        int�÷��� = .Columns.Count
        For ii = 1 To int�÷���
            
            If .Cells(1, ii) = 0 Then
                Exit For
            End If
            
            array���ڼ�(ii) = .Cells(1, ii)
  
        Next ii
        
    End With
        
    
    ' �� �ؽ�Ʈ���� ��� ����
    
        ' ��ȭ���� ����
        string���ϰ�� = Application.GetOpenFilename()
        
        ' ���� �ƹ��� ������ ���� ���Ѵٸ� ���ν��� ����
        If string���ϰ�� = "" Then
            Exit Sub
        End If
    
    
    ' �� �ؽ�Ʈ���� �б�
    
    Open string���ϰ�� For Input As #1
       
    int��� = 1
    
    Do Until EOF(1)
        ' �� �� �б�
        Erase array����
        Line Input #1, Row
        
        ' ���� �ɰ��� array���⿡ ����ϱ�
        int���� = 1
        
        For jj = 1 To int�÷���
            int���ڼ� = array���ڼ�(jj)
            array����(jj) = Mid(Row, int����, int���ڼ�)
            int���� = int���� + int���ڼ�
        Next jj
        
        ' �� ����ϱ�
        For kk = 1 To 3
            Worksheets("Result").Range("A1").Cells(int��� + 1, kk) = array����(kk)
       
        Next kk
        
        
        int��� = int��� + 1
        
    Loop
    
    Close #1
    
    MsgBox "�ø���~ " & int��� & "�� �۾� �Ϸ�"
 

End Sub


