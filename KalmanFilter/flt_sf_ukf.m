function [sys,x0,str,ts] = flt_sf_ukf(t,x,u,flag)
%Global Variable:
%Q and R:
Q_ukf=diag([0.01,0.04]);
R_ukf=1;
global K;
%global x_ukf;
switch flag
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes; 
    case 2,
        sys=mdlUpdate(t,x,u,Q_ukf,R_ukf);          
    case 3,
        sys=mdlOutputs(t,x,u,K);              
    case {1,4,9},
        sys=[];
    otherwise
        error(['Unhandled flag= ',num2str(flag)]);
end

function[sys,x0,str,ts]=mdlInitializeSizes(N)
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

global x_ukf;
x_ukf=[x0]; 
%P:
global P;
P=100*eye(2);%zeros(2,2);

function sys=mdlUpdate(t,x,u,Q_ukf,R_ukf)
global x_ukf;
global P;
global K;
%Initial condition:

x_in=x_ukf(:,length(x_ukf(1,:)));
[x_new,P,K]=GetUKF_Parameters(x_in,u,P,Q_ukf,R_ukf);
x_ukf=[x_ukf,x_new];
sys=x_new;

%Object outputs:
function sys=mdlOutputs(t,x,u,K)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=K(1,1);
sys(4)=K(2,1);



        