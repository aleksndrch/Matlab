function [sys,x0,str,ts] = obj_slfbrd(t,x,u,flag)

switch flag
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes; 
    case 1,
        sys=mdlDerivatives(t,x,u);          
    case 3,
        sys=mdlOutputs(t,x,u);              
    case {2,4,9},
        sys=[];
    otherwise
        error(['Unhandled flag= ',num2str(flag)]);
end

function[sys,x0,str,ts]=mdlInitializeSizes
sizes=simsizes;         
sizes.NumContStates=3;  
sizes.NumDiscStates=0;  
sizes.NumOutputs=3;     
sizes.NumInputs=1;      
sizes.DirFeedthrough=1; 
sizes.NumSampleTimes=0; 

sys=simsizes(sizes);
x0=[0.15 0 0];            
str=[];                 
ts=[];               

%Calculate state equation:
function sys=mdlDerivatives(t,x,u)
%Object parameters
%u=u(1);
%Select disturb
M=1;
%Without disturb
if M==1
d1=0;
d2=0;
d3=0;
%With disturb
elseif M==2
d1=sin(t);
d2=sin(t);
d3=sin(t);
end 

%State equation
sys(1)=sin(x(2))+(x(2)+1)*x(3)+d1;
sys(2)=x(1)^5+x(3)+d2;
sys(3)=x(1)^2+u+d3;

%Object outputs:
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);

        