%����������� �������:
function [sys,x0,str,ts] = obj_erlid(t,x,u,flag)

%����� �������:
switch flag
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes; %�������������
    case 1,
        sys=mdlDerivatives(t,x,u);          %������ ����������� ������� ��������� (x)
    case 3,
        sys=mdlOutputs(t,x,u);              %�������� ��������
    case {2,4,9},
        sys=[];
    otherwise
        error(['Unhandled flag= ',num2str(flag)]);
end

%������������� ���������� ������
function[sys,x0,str,ts]=mdlInitializeSizes
sizes=simsizes;         %�������� ��������� sizes ���� simsizes
sizes.NumContStates=2;  %����� ���������� ��������� (�����������)
sizes.NumDiscStates=0;  %����� ���������� ��������� (����������)
sizes.NumOutputs=2;     %����� ������� �������
sizes.NumInputs=1;      %����� ������ �������
sizes.DirFeedthrough=0; %������ �������� ������� �� ����� (0,if D=0)
sizes.NumSampleTimes=1; %����������� ������� ���������� ������� (min=1)

sys=simsizes(sizes);
x0=[-0.5 1];          %��������� �������
str=[];                 %����������������� ��������
ts=[0 0];               %��� ���������� ������� � ��������

%Calculate state equation:
function sys=mdlDerivatives(t,x,u)
%Object parameters
b=120; J=25;

%State equation
sys(1)=x(2);
sys(2)=-J*x(2)+b*u;

%Object outputs:
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);

        