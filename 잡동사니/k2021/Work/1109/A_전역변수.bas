Attribute VB_Name = "a_��������"
Option Explicit

' ----------  Global ������ �����ϴ� �κ�  ----------
    
    ' ����� ����
    Public QxDict As Object
    
   
    ' S rate ����
    Public SrateDict As Object

    ' ������ ����
    Public x As Integer                           ' ���Կ���
    Public sex As Integer                        ' ����
    
    ' �������
    Public n As Long                             ' ����Ⱓ
    Public m As Long                            ' ���ԱⰣ
    Public m_ As Long                           ' �����ֱ�

    ' key
    Public KEY As String                         ' �㺸�ڵ� & injure & driver �� ���� Ű��
    Public injure As Long
    Public driver As Long
    
    ' ������
    Public exp_i As Double                      ' ��������
    Public exp_v As Double

    ' �����
    Public AMT As Long
    Public alpha1 As Double
    Public alpha3 As Double
    Public beta1 As Double
    Public beta2 As Double
    Public gamma As Double
    Public ce As Double

    ' �����
    
    Public numBenefit As Integer                  ' �޺ΰ���
    Public makeCombRiskRate As Boolean      ' �����������������
    Public useSingleRate As Boolean             ' ���Ϸ����뿩��
        
'   Ż��
    Public riskType_exit(12) As String
    Public NonCov(12) As Integer                  ' �δ㺸�Ⱓ
    Public QxKey(12) As String                      ' Ż����
    Public Qx(12, 120) As Double
    
'   �޺�����

    Public riskType_benefit(12) As String
    Public DefryRate(12) As Double                ' ���޷�
    Public ReducRate(12) As Double               ' ���׷�
    Public ReducPeriod(12) As Double            ' ���ױⰣ
    Public BxKey(12) As String                       ' �޺����� ����� �ڵ�
    Public Bx(12, 120) As Double                    ' �޺����� �����
    
'   ���Ը���
    Public riskType_grant As String
    Public GxKey As String                           ' ���Ը����� ����� �ڵ�
    Public Gx(120) As Double                        ' ���Ը���
    Public InvalidPeriod As Integer                 ' ��ȿ�����Ⱓ


    ' �����
    Public lx_(120) As Double                     ' �����ڼ�
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
        Public NP_annual_full As Double
        Public NP_month_full As Double
        
        Public NP_annual As Double
        Public NP_month As Double
    
        '���������
        Public G_annual_full As Double
        Public G_month_full As Double
        
        Public G_annual As Double
        Public G_month As Double

        
    ' �غ��, ȯ�ޱ�
    Public tVx_full(120) As Double
    Public tWx_full(120) As Double
    Public tVx(120) As Double
    Public tWx(120) As Double
    
    ' ǥ�ؾ���, �������
    Public alpha_std As Double
    Public alpha_apply As Double
    Public Srate As Double
    
    ' ��Ÿ
    Public l0 As Long                           ' ����ʱ� �����ڼ�


