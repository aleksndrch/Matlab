%Regression LSQ:
%Unsmoothed function
S1=sum(y(1:N).^2);
S2=sum(y(2:N).*y(1:N-1));
S3=sum(y(1:N-1).^2);
S4=sum(y(3:N).*y(1:N-2));
S5=sum(y(2:N).*u(1:N-1));
S6=sum(y(2:N-1).*y(1:N-2));
S7=sum(y(1:N-1).*u(1:N-1));
S8=sum(y(1:N-2).^2);
S9=sum(y(1:N-2).*u(2:N-1));
S10=sum(u(1:N-1).^2);
%Matrix A and B:
A=[S3 S6 S7;S6 S8 S9; S7 S9 S10];
B=transp([S2 S4 S5]);

%Calculate the coefficients of the discrete system
beta=inv(A)*B;
a1=beta(1);
a2=beta(2);
b0=beta(3);

%Recalculate for continuous system
T1=(dt^2)/(1-a1-a2);
T2=((a2+1)*T1+dt^2)/dt;
k=(b0*T1)/dt^2;
W1=tf([k],[T1 T2 1]);

% %Smoothed function 
%h=h';
% 
S1=sum(h(1:N).^2);
S2=sum(h(2:N).*h(1:N-1));
S3=sum(h(1:N-1).^2);
S4=sum(h(3:N).*h(1:N-2));
S5=sum(h(2:N).*u(1:N-1));
S6=sum(h(2:N-1).*h(1:N-2));
S7=sum(h(1:N-1).*u(1:N-1));
S8=sum(h(1:N-2).^2);
S9=sum(h(1:N-2).*u(2:N-1));
S10=sum(u(1:N-1).^2);

A=[S3 S6 S7;S6 S8 S9; S7 S9 S10];
B=transp([S2 S4 S5]);

beta=inv(A)*B;
a1=beta(1);
a2=beta(2);
a3=beta(3);

T1s=(dt^2)/(1-a1-a2);
T2s=((a2+1)*T1s+dt^2)/dt;
ks=(a3*T1s)/dt^2;
W2=tf([ks],[T1s T2s 1]);





