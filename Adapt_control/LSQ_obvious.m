%LSQ:
R=[y(n:N-1) y(n-1:N-2) u(n:N-1)];%Augmented matrix
Y=[y(n+1:N)]; %output data (vector)
beta=inv(R'*R)*R'*Y;

%Recalculate for continuous system
T1=(dt^2)/(1-beta(1)-beta(2));
T2=((beta(2)+1)*T1+dt^2)/dt;
k=(beta(3)*T1)/dt^2;
Wlsq=tf([k],[T1 T2 1]);
