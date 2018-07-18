function [x_new, P, K]=GetEKF_Parameters(x_old,u,P,Q,R,x0,y0)
%1 step - Compute predict of system state:
x_pre=obj_def(x_old)+[u(2);0];
%2 step - Compute measure predict::
z_pre=obsv_def(x_pre);
%3 step - Compute Jacobian of matrix F and H :
F=[1, 0;0.1*cos(0.1*x_pre(1,1)), 1];
H=[(x_pre(1,1)-x0)/z_pre, (x_pre(2,1)-y0)/z_pre];
%4 step - Compute predict of covariation matrix P:
P_pre=F*P*F'+Q;
%5 step - Compute Kalman Gain:
K=P_pre*H'*inv(H*P_pre*H'+R);
%6 step - Compude new system state:
x_new=x_pre+K*((u(1)+u(2))-z_pre);
%7 step - and Compude new matrix covariation state:
P=(eye(2)-K*H)*P_pre;