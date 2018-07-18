%����������� �������:
function [sys,x0,str,ts] = reg_sfrd(t,x,u,flag)

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
sizes.NumOutputs=5;     %����� ������� �������
sizes.NumInputs=11;      %����� ������ �������
sizes.DirFeedthrough=1; %������ �������� ������� �� ����� (0,if D=0)
sizes.NumSampleTimes=1; %����������� ������� ���������� ������� (min=1)

sys=simsizes(sizes);
x0=[];               %��������� �������
str=[];                 %����������������� ��������
ts=[0 0];               %��� ���������� ������� � ��������

%������ �������� ������� �������� ��������
function sys=mdlOutputs(t,x,u)
%Input
xd=u(1); %Ideal signal
x=u(2);   %Real signal
dx=u(3);  %The first derivative of real signal
d2x=u(4); %The second derivative of real signal
%Regulator parameters:
l=u(5);
l_1=u(6);
l_2=u(7);
nv=u(8);
%Derivates of ideal signal:
dxd=u(9);
d2xd=u(10);
d3xd=u(11);

%Object parameters
J=10;   %Inertia

%Errors
e=x-xd;
de=dx-dxd;
d2e=d2x-d2xd;

%Control law:
s=d2e+l_1*de+l_2*e;
u=(-1/l)*(-l*J*d2x+J*(-d3xd+l_1*d2e+l_2*de)+nv*sign(s));

%Regulator outputs:
sys(1)=u;
sys(2)=e;
sys(3)=de;
sys(4)=d2e;
sys(5)=s;

        