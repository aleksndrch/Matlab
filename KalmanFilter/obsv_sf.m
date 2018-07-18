function [sys,x0,str,ts] = obsv_sf(t,x,u,flag)
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
sizes.NumDiscStates=1;  
sizes.NumOutputs=1;     
sizes.NumInputs=2;      
sizes.DirFeedthrough=0; 
sizes.NumSampleTimes=1; 

sys=simsizes(sizes);
x0=[0];            
str=[];                 
ts=[-1 0];               


function sys=mdlUpdate(t,x,u)
%Inputs:
%u(1) - object output
%New state:
sys(1)=obsv_def(u);

%Object outputs:
function sys=mdlOutputs(t,x,u)
%sys(1) - z
sys(1)=x;

        