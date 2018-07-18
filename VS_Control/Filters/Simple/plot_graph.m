%Plot graph
%Basic parameter
% figure(1)
% %Positioning (position tracking) - x(1)
% subplot(2,1,1)
% plot(t,xd,t,X(:,1),t,Xf(:,1))
% xlabel('Time(s)')
% ylabel('Angle response')
% legend('Ideal position tracking','Real position tracking(UNFLT)','Real position tracking(FLT)')
% title('Position tracking')
% grid on
% %Positioning (speed tracking) - x(2)
% subplot(2,1,2)
% plot(t,dxd,t,X(:,2),t,Xf(:,2))
% xlabel('Time(s)')
% ylabel('Angle speed response')
% legend('Ideal speed signal','Real speed signal(UNFLT)','Real speed signal(FLT)')
% title('Speed signal')
% grid on

figure(2)
%Control - u(t)
subplot(2,1,1)
plot(t,u)
ylim([-20 20]);
xlabel('Time(s)')
ylabel('Control')
title('Unfiltred control signal')
grid on
%Filtred Control - u_f(t)
subplot(2,1,2)
plot(t,u_f)
ylim([-20 20]);
xlabel('Time(s)')
ylabel('Control')
title('Filtred control signal')
grid on

%Control error
figure(3)
%Control error - e
plot(t,e)
xlabel('Time(s)')
ylabel('e')
title('Error(e)')
grid on


figure(4)
plot3(e,de,d2e)
xlabel('e')
ylabel('de')
zlabel('d2e')
title('Phase path')
grid on

% figure(5)
% subplot(1,2,1)
% plot(et,det)
% xlim([-0.08 0.08]);
% ylim([-0.08 0.08]);
% xlabel('e')
% ylabel('de')
% title('Filtred phase path')
% grid on
% subplot(1,2,2)
% plot(e,de)
% xlim([-0.08 0.08]);
% ylim([-0.08 0.08]);
% xlabel('e')
% ylabel('de')
% title('Unfiltred phase path')
% grid on