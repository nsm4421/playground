Attribute VB_Name = "A_��������"
Option Explicit


Public riskRateDictMale As Object
Public riskRateDictFemale As Object

' ������ ����
Public x As Integer
Public sex As Integer

' �������
Public n As Long
Public m As Long
Public m_ As Long       '�����ֱ�

' key
Public cov As String
Public sub1 As Integer
Public sub2 As Integer
Public sub3 As Integer
Public KEY As String

' ������
Public exp_i As Double
Public exp_v As Double

' �����
Public amt As Long
Public alpha1 As Double
Public alpha2 As Double
Public beta1 As Double
Public beta2 As Double
Public beta_ As Double      ' Beta Prime
Public beta5 As Double
Public ce As Double     ' ���������
Public gamma As Double

' �����
Public WxKey(10) As String  ' ���Ը����� ����� �ڵ�
Public Wx(10, 120) As Double    ' ���Ը���
Public Invalid(10) As Integer   ' ��ȿ�����Ⱓ
Public NonCov(12) As Integer   ' �δ㺸�Ⱓ
Public QxKey(12) As String
Public Qx(12, 120) As Double
Public Pay(12) As Double   ' ���޷�
Public ReducRate(12) As Double   '  ���׷�
Public ReducPeriod(12) As Double   ' ���ױⰣ

Public apply_Bx As String
Public BxKey(12) As String
Public Bx(12, 120) As Double

' �����
Public lx_(120) As Double   ' �����ڼ�
Public lx(12, 120) As Double    '�����ڼ�
Public Dx_(120) As Double
Public Dx(120) As Double
Public Nx_(120) As Double
Public Nx(120) As Double
Public Cx(12, 120) As Double
Public Mx(12, 120) As Double
Public SUMx(160) As Double
Public Nstar As Double  ' ���Ա��

' �����
Public NP As Double     ' ���� �������
Public NP_month As Double     ' ���� �������
Public NP_std As Double      ' ���ؿ����������
Public G As Double      ' �������������
Public BetaP As Double      ' ������Ÿ�������


' �غ��, ȯ�ޱ�
Public tVx(160) As Double
Public Srate As Double
Public tWx(160) As Double




