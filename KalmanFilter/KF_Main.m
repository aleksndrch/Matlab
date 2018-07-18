clc,clear

% %Initial condition:
global K;
K=[0 0]';
%Sim Start:
sim('EKF_MDL.slx')
sim('UKF_MDL.slx')

%Analize Part:
%Compute Errors:
%EKF:
%X1:
E1=abs(Xekf(:,1)-X(:,1));        %EKF Error (Estimate-Real)
E2=abs(Z-X(:,1));                %Measure Error (Measure-Real)
E3=abs(Xekf(:,1)-X_ideal(:,1));  %EKF Error (Estimate-Ideal)
E4=abs(Z-X_ideal(:,1));          %Measure Error (Measure-Ideal)
%X2:
E5=abs(Xekf(:,2)-X(:,2));        %EKF Error (Estimate-Real)
E6=abs(Xekf(:,2)-X_ideal(:,2));  %EKF Error (Estimate-Ideal)
%UKF:
%X1:
E7=abs(Xukf(:,1)-X(:,1));        %UKF Error (Estimate-Real)
E8=abs(Xukf(:,1)-X_ideal(:,1));  %UKF Error (Estimate-Ideal)
%X2:
E9=abs(Xukf(:,2)-X(:,2));         %UKF Error (Estimate-Real)
E10=abs(Xukf(:,2)-X_ideal(:,2));  %UKF Error (Estimate-Ideal)

%EKF and UKF Real System Analisis:
figure(1)
subplot(2,1,1)
plot(t,E2,'.-',t,E1,t,E7,'--')
title('Real System Error(x_1)')
legend('Measure Error','EKF Error','UKF Error')
xlabel('Discrete Time');
ylabel('Error');
subplot(2,1,2)
plot(t,E5,t,E9,'--')
title('Real System Error(x_2)')
legend('EKF Error','UKF Error')
xlabel('Discrete Time');
ylabel('Error');

%Kalman Gain:
figure(2),grid on
plot(t,Kekf(:,1),t,Kekf(:,2),t,Kukf(:,1),'--',t,Kukf(:,2),'--')
title('Kalman Gain')
legend('EKF K_1','EKF K_2','UKF K_1','UKF K_2')
xlabel('Discrete Time');
ylabel('Gain');

%Compare:
%Plot Coordinate:
figure(3),grid on
plot(X_ideal(:,1),X_ideal(:,2),...
     X(:,1),X(:,2),...
     Xekf(:,1),Xekf(:,2),...
     Xukf(:,1),Xukf(:,2));
title('System Tracking')
legend('Ideal Track (w/o noise)','Real Track','EKF Track','UKF Track')
xlabel('x_1');
ylabel('x_2');
xlim([0 500]);


%Real System RMSE Error:
N=length(t);
for i=1:N
    Ekf_rmse_real(i)=sqrt((Xekf(i,1)-X(i,1))^2+(Xekf(i,2)-X(i,2))^2);
    Ukf_rmse_real(i)=sqrt((Xukf(i,1)-X(i,1))^2+(Xukf(i,2)-X(i,2))^2);
end
figure(4)
plot(t,Ekf_rmse_real',t,Ukf_rmse_real','--');
legend('EKF','UKF')
title('RMSE (Real System)')
xlabel('Discrete Time');
ylabel('Error');
xlim([0 50]);

%EKF and UKF Ideal System Analisis:
figure(5)
plot(t,E4,t,E3,t,E8,'--')
title('Ideal (w/o noise) System Error(x_1)')
legend('Measure Error','EKF Error','UKF Error')
xlabel('Discrete Time');
ylabel('Error');

%Ideal System RMSE Error:
N=length(t);
for i=1:N
    Ekf_rmse_ideal(i)=sqrt((Xekf(i,1)-X_ideal(i,1))^2+...
                          (Xekf(i,2)-X_ideal(i,2))^2);
    Ukf_rmse_ideal(i)=sqrt((Xukf(i,1)-X(i,1))^2+...
                          (Xukf(i,2)-X_ideal(i,2))^2);
end
figure(6)
plot(t,Ekf_rmse_ideal',t,Ukf_rmse_ideal','--');
legend('EKF','UKF')
title('RMSE (Ideal System)')
xlabel('Discrete Time');
ylabel('Error');
xlim([0 50]);


