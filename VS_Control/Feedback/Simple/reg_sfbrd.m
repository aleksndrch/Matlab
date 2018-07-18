function [sys,x0,str,ts] = reg_sfbrd(t,x,u,flag)
switch flag
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes; 
    case 3,
        sys=mdlOutputs(t,x,u);              
    case {1,2,4,9},
        sys=[];
    otherwise
        error(['Unhandled flag= ',num2str(flag)]);
end

function[sys,x0,str,ts]=mdlInitializeSizes
sizes=simsizes;         
sizes.NumContStates=0;  
sizes.NumDiscStates=0;  
sizes.NumOutputs=1;    
sizes.NumInputs=10;      
sizes.DirFeedthrough=1; 
sizes.NumSampleTimes=1; 

sys=simsizes(sizes);
x0=[];                  
str=[];                 
ts=[0 0];               

function sys=mdlOutputs(t,x,u)
%Input
yd=u(1);  %Ideal signal
%Regulator parameters
k1=u(2);
k2=u(3);     

x1=u(4);   %x1
x2=u(5);   %x2
x3=u(6);   %x3

e=u(7);     %e
de=u(8);    %de

dyd=u(9);   %dyd
d2yd=u(10); %d2yd


%Object parameters
f=x1^5*cos(x2)+x3*(cos(x2)+x1^5+x3)+x1^2*(x2+1);
%Controler param:
v=d2yd+k2*de+k1*e;

%Control law:
u=(1/(x2+1))*(v-f);
%Regulator outputs:
sys(1)=u;



        