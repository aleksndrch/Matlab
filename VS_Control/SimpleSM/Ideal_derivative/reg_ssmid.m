function [sys,x0,str,ts] = reg_ssmid(t,x,u,flag)
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
sizes.NumOutputs=4;     %Число выходов системы
sizes.NumInputs=5;      %Число входов системы
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
c=u(2);     
nv=u(3);

Th =u(4);   %Real signal
dTh=u(5);   %Derivative of measured signal

%Signal - sin(t)
  dTh_a=cos(t);
  d2Th_a=-sin(t);
%Signal - Step
% dTh_a=0;
% d2Th_a=0;

%Object parameters
J=10;	%Inertia

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


        