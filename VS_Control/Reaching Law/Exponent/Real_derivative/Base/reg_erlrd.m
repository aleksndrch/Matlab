function [sys,x0,str,ts] = reg_erlrd(t,x,u,flag)
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
D=0.01*sin(10*pi*t);    %Шум в канале измерения
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


        