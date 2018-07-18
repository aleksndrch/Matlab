%Functions:
function[x_out,P,K]=GetUKF_Parameters(x_in,Z,P,Q,R)
%Weigth value initial condition:
L=2;
alpha=0.01;
k_alpha=0;
betta=2;
lambda=alpha^2*(L+k_alpha)-L;

for j=1:2*L+1
    Wm(j)=1/(2*(L+lambda));
    Wc(j)=1/(2*(L+lambda));
end

Wm(1)=lambda/(L+lambda);
Wc(1)=lambda/(L+lambda)+1-alpha^2+betta;
%Filter initialization:
x_est=x_in;

%1 Step - Recieve sigma point set:
CH=(chol(P*(L+lambda)))';
for k=1:L
    P1_x_gamma(:,k)=x_est+CH(:,k);
    P2_x_gamma(:,k)=x_est-CH(:,k);
end
x_sigma=[x_est,P1_x_gamma,P2_x_gamma];
%2 Step - Calculate predict of sigma point set:
for k=1:2*L+1
    x_sigma_pre(:,k)=obj_def(x_sigma(:,k)+[Z(2);0]);
end
%3 Step - Use 2 step result calculate average value and covariatian:  
x_pre=zeros(2,1);
for k=1:2*L+1
    x_pre=x_pre+Wm(k)*x_sigma_pre(:,k);
end
P_pre=zeros(2,2);
for k=1:2*L+1
    P_pre=P_pre+Wc(k)*(x_sigma_pre(:,k)-x_pre)*(x_sigma_pre(:,k)-x_pre)';
end
P_pre=P_pre+Q;
%4 Step - Use predict value data,again calculate UT transform, 
%data setrecieve new sigma:
CHR=(chol((L+lambda)*P_pre))';
for k=1:L
    P1x_aug_sigma(:,k)=x_pre+CHR(:,k);
    P2x_aug_sigma(:,k)=x_pre-CHR(:,k);
end
x_aug_sigma=[x_pre P1x_aug_sigma P2x_aug_sigma];
%5 Step - Observe predication:
for k=1:2*L+1
    z_sigma_pre(1,k)=obsv_def(x_aug_sigma(:,k));
end
%6 Step - Compute observe average value and covariatian:
z_pre=0;
for k=1:2*L+1
    z_pre=z_pre+Wm(k)*z_sigma_pre(1,k);
end
Pz=0;
for k=1:2*L+1
    Pz=Pz+Wc(k)*(z_sigma_pre(1,k)-z_pre)*(z_sigma_pre(1,k)-z_pre)';
end
Pz=Pz+R;
Pxz=zeros(2,1);
for k=1:2*L+1
    Pxz=Pxz+Wc(k)*(x_aug_sigma(:,k)-x_pre)*(z_sigma_pre(1,k)-z_pre)';
end
%7 Step - Compute Kalman Gain:
K=Pxz*inv(Pz);
%8 Step - Refresh state and variance value:
x_out=x_pre+K*((Z(1)+Z(2))-z_pre);
P=P_pre-K*Pz*K';

