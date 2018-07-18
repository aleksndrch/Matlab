function [sys,x0,str,ts] = flt_sf_ekf(t,x,u,flag)
%Global Variable:
global K;
%K=[0 0]';
%Define Q and R:
Q=diag([0.01,0.04]);
R=1;

switch flag
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes; 
    case 2,
        sys=mdlUpdate(t,x,u,Q,R);          
    case 3,
        sys=mdlOutputs(t,x,u,K);              
    case {1,4,9},
        sys=[];
    otherwise
        error(['Unhandled flag= ',num2str(flag)]);
end

function[sys,x0,str,ts]=mdlInitializeSizes
sizes=simsizes;         
sizes.NumContStates=0;  
sizes.NumDiscStates=2;  
sizes.NumOutputs=4;     
sizes.NumInputs=2;      
sizes.DirFeedthrough=0; 
sizes.NumSampleTimes=1; 

sys=simsizes(sizes);
x0=[0 0]';            
str=[];                 
ts=[-1 0];               

%EKF Initial condition:
global x_ekf;
x_ekf=[x0]; 
%Matrix P:
global P;
P=100*eye(2);

function sys=mdlUpdate(t,x,u,Q,R)
global x_ekf;
global P;
global K;
%Initial condition:
x0=0; y0=0;
%0 step - Call EKF Function:
x_old=x_ekf(:,length(x_ekf(1,:)));
[x_new,P,K]=GetEKF_Parameters(x_old,u,P,Q,R,x0,y0);
%Filtering Result:
x_ekf=[x_ekf, x_new];
sys(1)=x_new(1,1);  %(x(1))
sys(2)=x_new(2,1);  %(x(2))

%Object outputs:
function sys=mdlOutputs(t,x,u,K)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=K(1,1);
sys(4)=K(2,1);




        