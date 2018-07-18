%Непрерывные системы:
function [sys,x0,str,ts] = reg_sfrd(t,x,u,flag)

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
sizes.NumOutputs=5;     %Число выходов системы
sizes.NumInputs=11;      %Число входов системы
sizes.DirFeedthrough=1; %Проход входного сигнала на выход (0,if D=0)
sizes.NumSampleTimes=1; %Размерность вектора модельного времени (min=1)

sys=simsizes(sizes);
x0=[];               %Начальные условия
str=[];                 %Зарезервированный параметр
ts=[0 0];               %Шаг модельного времени и смещение

%Расчет значений вектора выходных сигналов
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

        