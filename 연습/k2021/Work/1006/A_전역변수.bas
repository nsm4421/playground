Attribute VB_Name = "a_��������"
Option Explicit

' ----------  Global ������ �����ϴ� �κ�  ----------
    
    ' ����� ����
    Public QxDict As Object

    ' ������ ����
    Public x As Integer                         ' ���Կ���
    Public sex As Integer                       ' ����
    Public firstJoinAge As Integer              ' ���ʰ��Կ���
    
    ' �������
    Public n As Long                            ' ����Ⱓ
    Public m As Long                            ' ���ԱⰣ
    Public m_ As Long                           ' �����ֱ�
    
    ' key
    Public KEY As String                        ' �㺸�ڵ� & ����Ű(sub) 1~4�� ���� Ű��
    Public re As String
    
    ' ������
    Public exp_i As Double                      ' ��������
    Public exp_v As Double
    
    ' �����
    Public AMT As Long
    Public alpha As Double
    Public beta As Double
    Public beta5 As Double
    Public ce As Double                         ' ���������

    ' �����
    
'   Ż��
    Public riskType_exit(100) As String         ' Ż�������type
    Public NonCov(12) As Integer            ' �δ㺸�Ⱓ
    Public QxKey(12) As String              ' Ż����
    Public Qx(12, 120) As Double
    
'   �޺�����

    Public riskType_benefit(100) As String      ' �޺������type
    Public DefryRate(12) As Double          ' ���޷�
    Public ReducRate(12) As Double          ' ���׷�
    Public ReducPeriod(12) As Double        ' ���ױⰣ
    Public BxKey(12) As String              ' �޺����� ����� �ڵ�
    Public Bx(12, 120) As Double            ' �޺����� �����
    
'   ���Ը���
    Public riskType_grant As String             ' ���������type
    Public GxKey As String                  ' ���Ը����� ����� �ڵ�
    Public Gx(120) As Double                ' ���Ը���
    Public invalidPeriod As Integer         ' ��ȿ�����Ⱓ


    ' �����
    Public lx_(120) As Double                    ' �����ڼ�
    Public lx(12, 120) As Double                 ' �����ڼ�
    Public Dx_(120) As Double
    Public Dx(120) As Double
    Public Nx_(120) As Double
    Public Nx(120) As Double
    Public Cx(12, 120) As Double
    Public Mx(12, 120) As Double
    Public SUMx(120) As Double
    
    ' �����

        ' �������
        Public NP_annual As Double                   ' ���� �������
        Public NP_semi_annual As Double              ' 6�����������
        Public NP_quarter As Double                  ' 3�����������
        Public NP_month As Double                    ' ���� �������
    
        '���������
        Public G_annual As Double                    ' �������������
        Public G_semi_annual As Double               ' 6�������������
        Public G_quarter As Double                   ' 3�������������
        Public G_month As Double                     ' �������������


        
    ' �غ��, ȯ�ޱ�
    Public tVx(160) As Double

    ' ��Ÿ
    Public l0 As Long                           ' ����ʱ� �����ڼ�


