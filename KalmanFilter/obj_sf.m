function [sys,x0,str,ts] = obj_sf(t,x,u,flag)
%global x_state;
switch flag
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes; 
    case 2,
        sys=mdlUpdate(t,x,u);          
    case 3,
        sys=mdlOutputs(t,x,u);              
    case {1,4,9},
        sys=[];
    otherwise
        error(['Unhandled flag= ',num2str(flag)]);
end

function[sys,x0,str,ts]=mdlInitializeSizes
sizes=simsizes;         
sizes.NumContStates=0;  
sizes.NumDiscStates=2;  
sizes.NumOutputs=2;     
sizes.NumInputs=3;      
sizes.DirFeedthrough=0; 
sizes.NumSampleTimes=1; 

sys=simsizes(sizes);
x0=[0 0]';            
str=[];                 
ts=[-1 0];               

function sys=mdlUpdate(t,x,u)
%Inputs:
%u(1) - Control signal
%u(2) - x1 noise (Q1)
%u(3) - x2 noise (Q2)
%Input matrix:
u=[u(1)+u(2);u(3)];
%New state:
x_new=obj_def(x)+u;
sys(1)=x_new(1,1);
sys(2)=x_new(2,1);

%Object outputs:
function sys=mdlOutputs(t,x,u)
%sys(1) - x1
%sys(2) - x2
sys=x;

        