function [sys,x0,str,ts] = reg_ecrd(t,x,u,flag)
%Вызов функций:
switch flag
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes; %Инициализация
    case 3,
        sys=mdlOutputs(t,x,u);              %Выходное значение
    case {1,2,4,9},
        sys=[];
    otherwise
        error(['Unhandled flag= ',num2str(flag)]);
end

%Инициализация параметров модели
function[sys,x0,str,ts]=mdlInitializeSizes
sizes=simsizes;         %Создание структуры sizes типа simsizes
sizes.NumContStates=0;  %Число переменных состояния (непрерывных)
sizes.NumDiscStates=0;  %Число переменных состояния (дискретных)
sizes.NumOutputs=6;     %Число выходов системы
sizes.NumInputs=8;      %Число входов системы
sizes.DirFeedthrough=1; %Проход входного сигнала на выход (0,if D=0)
sizes.NumSampleTimes=1; %Размерность вектора модельного времени (min=1)

sys=simsizes(sizes);
x0=[];                  %Начальные условия
str=[];                 %Зарезервированный параметр
ts=[0 0];               %Шаг модельного времени и смещение

%Расчет значений вектора выходных сигналов
function sys=mdlOutputs(t,x,u)
%Input
Th_a=u(1);  %Ideal signal
%Regulator parameters
D=u(2);
nv=u(3);     
c=u(4);

Th =u(5);   %Real signal
dTh=u(6);   %Derivative of measured signal

dTh_a =u(7);   %Ideal signal
d2Th_a=u(8);   %Derivative of Ideal signal

%Object parameters
b=120; J=25;
f_x=-J*dTh;

%Controler param:
K=nv+D;

%Errors
e=Th_a-Th;
de=dTh_a-dTh;
s=c*e+de;
%Control law:
u_eq=(1/b)*(c*de+d2Th_a-f_x);
u_sw=(1/b)*K*sign(s);
u=u_eq+u_sw;
%Regulator outputs:
sys(1)=u;
sys(2)=e;
sys(3)=de;
sys(4)=s;
sys(5)=u_eq;
sys(6)=u_sw;


        