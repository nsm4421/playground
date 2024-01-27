Attribute VB_Name = "텍스트파일쪼개기"
Sub sub텍스트파일쪼개기()
    
    ' 이 파일에서 컬럼수 3개로 지정해놨는데 나중에 사용할 때는 컬럼수 바꾸기!!!!
    
    Dim string파일경로 As String                            ' 텍스트 파일 경로
    Dim array글자수(3) As Integer                           ' 각 컬럼의 글자수를 넣는 배열
    Dim array추출(3) As Variant                             ' 텍스트 파일을 쪼개놓은 배열
    Dim int시작 As Integer
    Dim int컬럼수 As Integer
    Dim int행수 As Integer
    
    
    ' ⑴ Tab글자수 읽기
    With Worksheets("Layout").Range("Tab글자수")
        int컬럼수 = .Columns.Count
        For ii = 1 To int컬럼수
            
            If .Cells(1, ii) = 0 Then
                Exit For
            End If
            
            array글자수(ii) = .Cells(1, ii)
  
        Next ii
        
    End With
        
    
    ' ⑵ 텍스트파일 경로 지정
    
        ' 대화상자 열기
        string파일경로 = Application.GetOpenFilename()
        
        ' 만약 아무런 파일을 선택 안한다면 프로시저 종료
        If string파일경로 = "" Then
            Exit Sub
        End If
    
    
    ' ⑶ 텍스트파일 읽기
    
    Open string파일경로 For Input As #1
       
    int행수 = 1
    
    Do Until EOF(1)
        ' 한 행 읽기
        Erase array추출
        Line Input #1, Row
        
        ' 행을 쪼개서 array추출에 기록하기
        int시작 = 1
        
        For jj = 1 To int컬럼수
            int글자수 = array글자수(jj)
            array추출(jj) = Mid(Row, int시작, int글자수)
            int시작 = int시작 + int글자수
        Next jj
        
        ' ⑷ 기록하기
        For kk = 1 To 3
            Worksheets("Result").Range("A1").Cells(int행수 + 1, kk) = array추출(kk)
       
        Next kk
        
        
        int행수 = int행수 + 1
        
    Loop
    
    Close #1
    
    MsgBox "시마이~ " & int행수 & "행 작업 완료"
 

End Sub


