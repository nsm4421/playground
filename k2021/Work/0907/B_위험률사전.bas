Attribute VB_Name = "B_���������"
Sub B����������()

    Dim dictKey As String      ' Dictionary Ű
    Dim dictValue(120) As Double    ' Dictionary ��
    Dim age As Long     ' ���Կ���
    Dim male As Double    ' ���� �����
    Dim female As Double      ' ���� �����
    Dim startRow As Long    ' ������
    Dim cnt As Long     ' ����
        
        
    ' Dictionary ��ü �ʱ�ȭ
    If sex = 1 Then
        Set riskRateDictMale = CreateObject("Scripting.Dictionary")
    Else
        Set riskRateDictFemale = CreateObject("Scripting.Dictionary")
    End If
    
    ' ����� �ڵ帶�� loop
    For ii = 1 To Worksheets("�����").Range("Tab������ڵ�").Rows.Count
    
        ' Tab���������
        With Worksheets("�����").Range("Tab������ڵ�")
            dictKey = .Cells(ii, 1)
            startRow = .Cells(ii, 2)
            cnt = .Cells(ii, 3)
        End With

        
        ' Tab�����
        With Worksheets("�����").Range("Tab�����")
            Erase dictValue
            For jj = startRow To startRow + cnt
                age = .Cells(jj, 9)
                If sex = 1 Then
                    dictValue(age) = .Cells(jj, 10)    ' ���� �����
                Else
                    dictValue(age) = .Cells(jj, 11)    ' ���� �����
                End If
            Next jj
            
            ' Dictionay�� ����
            If sex = 1 Then
                If riskRateDictMale.exists(dictKey) Then
                    riskRateDictMale.remvoe (dictKey)
                End If
                riskRateDictMale.Add dictKey, dictValue
            Else
                If riskRateDictFemale.exists(dictKey) Then
                    riskRateDictFemale.remvoe (dictKey)
                End If
                riskRateDictFemale.Add dictKey, dictValue
            End If
    
        End With
    Next ii
    
 

End Sub
