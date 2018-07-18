%Plot graph
%Basic parameter
figure(1)
%Positioning (position tracking) - x(1)
subplot(2,2,1)
plot(t,yd,t,x(:,1))
xlabel('Time(s)')
ylabel('Position tracking')
legend('Ideal position tracking','Real position tracking')
title('Position tracking')
grid on
%Control - u(t)
subplot(2,2,3)
plot(t,u)
xlabel('Time(s)')
ylabel('Control')
title('Control signal')
grid on

%Control error and control error derivative
%Control error - e
subplot(2,2,2)
plot(t,e)
xlabel('Time(s)')
ylabel('e')
title('Error(e)')
grid on
%Control error derivative - de
subplot(2,2,4)
plot(t,de)
xlabel('Time(s)')
ylabel('de')
title('Error(de)')
grid on