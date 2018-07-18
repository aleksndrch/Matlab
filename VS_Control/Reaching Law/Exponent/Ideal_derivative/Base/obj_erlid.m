%Непрерывные системы:
function [sys,x0,str,ts] = obj_erlid(t,x,u,flag)

%Вызов функций:
switch flag
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes; %Инициализация
    case 1,
        sys=mdlDerivatives(t,x,u);          %Расчет производных вектора состояния (x)
    case 3,
        sys=mdlOutputs(t,x,u);              %Выходное значение
    case {2,4,9},
        sys=[];
    otherwise
        error(['Unhandled flag= ',num2str(flag)]);
end

%Инициализация параметров модели
function[sys,x0,str,ts]=mdlInitializeSizes
sizes=simsizes;         %Создание структуры sizes типа simsizes
sizes.NumContStates=2;  %Число переменных состояния (непрерывных)
sizes.NumDiscStates=0;  %Число переменных состояния (дискретных)
sizes.NumOutputs=2;     %Число выходов системы
sizes.NumInputs=1;      %Число входов системы
sizes.DirFeedthrough=0; %Проход входного сигнала на выход (0,if D=0)
sizes.NumSampleTimes=1; %Размерность вектора модельного времени (min=1)

sys=simsizes(sizes);
x0=[-0.5 1];          %Начальные условия
str=[];                 %Зарезервированный параметр
ts=[0 0];               %Шаг модельного времени и смещение

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

        