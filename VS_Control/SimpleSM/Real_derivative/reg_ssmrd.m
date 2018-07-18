%����������� �������:
function [sys,x0,str,ts] = reg_ssmrd(t,x,u,flag)

%����� �������:
switch flag
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes; %�������������
    case 3,
        sys=mdlOutputs(t,x,u);              %�������� ��������
    case {1,2,4,9},
        sys=[];
    otherwise
        error(['Unhandled flag= ',num2str(flag)]);
end

%������������� ���������� ������
function[sys,x0,str,ts]=mdlInitializeSizes
sizes=simsizes;         %�������� ��������� sizes ���� simsizes
sizes.NumContStates=0;  %����� ���������� ��������� (�����������)
sizes.NumDiscStates=0;  %����� ���������� ��������� (����������)
sizes.NumOutputs=4;     %����� ������� �������
sizes.NumInputs=7;      %����� ������ �������
sizes.DirFeedthrough=1; %������ �������� ������� �� ����� (0,if D=0)
sizes.NumSampleTimes=1; %����������� ������� ���������� ������� (min=1)

sys=simsizes(sizes);
x0=[];               %��������� �������
str=[];                 %����������������� ��������
ts=[0 0];               %��� ���������� ������� � ��������

%������ �������� ������� �������� ��������
function sys=mdlOutputs(t,x,u)
%Input
Th_a=u(1);  %Ideal signal
dTh_a=u(2); %Derivative of ideal signal
d2Th_a=u(3);%Second derivative of ideal signal
%Regulator parameters
c=u(4);     
nv=u(5);

Th =u(6);   %Real signal
dTh=u(7);   %Derivative of measured signal

%Object parameters
J=10;   %Inertia

%Errors
e=Th-Th_a;
de=dTh-dTh_a;
s=c*e+de;
%Control law:
u=J*(-c*de+d2Th_a-nv*sign(s));%-d*sign(s);

%Regulator outputs:
sys(1)=u;
sys(2)=e;
sys(3)=de;
sys(4)=s;


        