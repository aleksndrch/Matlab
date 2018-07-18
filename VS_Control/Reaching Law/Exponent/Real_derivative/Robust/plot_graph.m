%Plot graph
%Basic parameter
figure(1)
%Positioning (position tracking) - x(1)
subplot(2,2,1)
plot(t,X(:,1),t,sin(t))
xlabel('Time(s)')
ylabel('Angle response')
legend('Real position tracking','Ideal position tracking')
title('Position tracking')
grid on
%Positioning (speed tracking) - x(2)
subplot(2,2,2)
plot(t,X(:,2),t,cos(t))
xlabel('Time(s)')
ylabel('Angle speed response')
legend('Real speed signal','Ideal speed signal')
title('Speed signal')
grid on
%Control - u(t)
subplot(2,2,3)
plot(t,U)
xlabel('Time(s)')
ylabel('Control')
title('Control signal')
grid on
%Phase path
subplot(2,2,4)
plot(e,de,e,-c.*e)
xlabel('e')
ylabel('de')
legend('s','s=0',2)
title('Phase path')
grid on

%Control error and control error derivative
figure(2)
%Control error - e
subplot(2,1,1)
plot(t,e)
xlabel('Time(s)')
ylabel('e')
title('Error(e)')
grid on
%Control error derivative - de
subplot(2,1,2)
plot(t,de)
xlabel('Time(s)')
ylabel('de')
title('Error(de)')
grid on