clc, clear
% Step response (the output of object):
% Plant output: 
y=load('ident_data.dat'); y=y';
% Normalize of curve(step from 0 to 1)
y=y-min(y);
y=(y./max(y))';                               % (50x1)
% Initial value:
dt=14;               % Step rate (s)
tmax=length(y)*dt;   % The time of transient response
t=0:dt:tmax-1;       % Discrete time          % (50x1)
N=length(t);         % Length of discrete time 
u=ones(N,1);         % Step response h(t)
n=2;                 % The order of system

%Because the curve is distorted, smooth it (moving average method):
m=7; % The number of dots for averaging
h(1)=y(1); % Smoothed the time response

%Averaging the initial points:
for i=2:m
    d=i-1;
    h(i)=sum(y(1:i+d))/(2*d+1);
end;
%Averaging the main points:
for i=m+1:N-m
    h(i)=sum(y(i-m:i+m))/(2*m+1);
end;
%Averaging the end points:
for i=N-m+1:N
    d=N-i;
    h(i)=sum(y(i-d:N))/(2*d+1);
end;

% Convert h for same dimentions:
h=h';                                        % (1x50)->(50x1)

%%%%%%%%%%%%%%%%%%%%LSQ - Recurrent algorithm%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Others algorithm in the others file: LSQ_xxxxxx;

%INITIAL DATA FOR UNSMOTHED CURVE:
i=1;             % The initial step
I=diag([1 1 1]); % Identity matrix
P=5*I;           % Starting value
beta=[0;0;0];    % Vector parameters
Be(i,:)=beta;    % Error

for i=n:N-1
    R=[y(i+n-2:-1:i-1);u(i+n-2:-1:i)]'; % Augmented matrix
    gama=P*R'/(R*P*R'+1);               % Vector correction
    beta=beta+gama*(y(i+1)-R*beta);     % New beta
    P=(I-gama*R)*P;                     % New value P
    Be(i,:)=beta;                       % Error
end

%Recalculate for continuous system
T1=(dt^2)/(1-beta(1)-beta(2));
T2=((beta(2)+1)*T1+dt^2)/dt;
k=(beta(3)*T1)/dt^2;
W=tf([k],[T1 T2 1]);

%INITIAL DATA FOR SMOTHED CURVE:
i=1;             % The initial step
I=diag([1 1 1]); % Identity matrix
P=5*I;           % Starting value
beta=[0;0;0];    % Vector parameters
Be_s(i,:)=beta;  % Error

for i=n:N-1
    R=[h(i+n-2:-1:i-1);u(i+n-2:-1:i)]'; % Augmented matrix
    gama=P*R'/(R*P*R'+1);               % Vector correction
    beta=beta+gama*(h(i+1)-R*beta);     % New beta
    P=(I-gama*R)*P;                     % New value P
    Be_s(i,:)=beta;                     % Error
end

% Recalculate for continuous system
T1s=(dt^2)/(1-beta(1)-beta(2));
T2s=((beta(2)+1)*T1s+dt^2)/dt;
ks=(beta(3)*T1s)/dt^2;
Ws=tf([ks],[T1s T2s 1]);

% Transfer function of smoothed system:
NUM=0.9171;
DEN=[1562 174.9 1];
[A,B,C,D]=tf2ss(NUM,DEN);
SYS=ss(A,B,C,D);

% Parametric distortion:
A1=[-0.1680 -0.0096;1 0] % Min
A2=[-0.0560 -0.0032;1 0] % Max  
Smin=ss(A1,B,C,D);
Smax=ss(A2,B,C,D);

% Compute obsver:
% Compute vector G:
H1=[1 2 2];         %Binomial distribution w0=2; n=2
P1=roots(H1);       
G=acker(A',C',P1)';  

% Reference model:
NUM1=1;
DEN1=[1 100 1];
[Am,Bm,Cm,Dm]=tf2ss(NUM1,DEN1);

% Compute adaptive regultor parameters:
Q=eye(2);
P=lyap(Am',Q);
syms r1a r2a Rb e g x1 x2 x1m x2m real;
X=[x1;x2]; Xm=[x1m;x2m]; e=Xm-X; Ra=[r1a 0;0 r2a];
Ka=vpa(Bm'*P*e*X'*Ra,3);
Kb=vpa(Bm'*P*e*g*Rb,3);

