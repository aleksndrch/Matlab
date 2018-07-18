function [sys,x0,str,ts] = reg_erlrd(t,x,u,flag)
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
sizes.NumInputs=8;      %����� ������ �������
sizes.DirFeedthrough=1; %������ �������� ������� �� ����� (0,if D=0)
sizes.NumSampleTimes=1; %����������� ������� ���������� ������� (min=1)

sys=simsizes(sizes);
x0=[];                  %��������� �������
str=[];                 %����������������� ��������
ts=[0 0];               %��� ���������� ������� � ��������

%������ �������� ������� �������� ��������
function sys=mdlOutputs(t,x,u)
%Input
Th_a=u(1);  %Ideal signal
%Regulator parameters
eps=u(2);
k=u(3);     
c=u(4);
dTh_a=u(5);
d2Th_a=u(6);
Th =u(7);   %Real signal
dTh=u(8);   %Derivative of measured signal

%Object parameters
b=120; J=25;
f_x=J*dTh;

%Errors
D=0.01*sin(10*pi*t);    %��� � ������ ���������
e=Th_a-Th;
de=dTh_a-dTh;
s=c*e+de;
%Control law:
u=(1/b)*(d2Th_a+c*de+f_x+eps*sign(s)+k*s);

%Regulator outputs:
sys(1)=u;
sys(2)=e;
sys(3)=de;
sys(4)=s;


        