% % Plot graph - Experemental and Smoothed model:
% figure(1)
% hold on, grid on
% plot (t,y,t,h) %Experimental data
% title('Step response');
% xlabel('t,c');
% ylabel('h(t)')
% legend('Experemental data','Smoothed model',4)
% hold off
% 
% LSQ - Recurrent algorithm 
figure(2)
% NON SMOOTHED:
subplot(1,2,1)
% The convergence of the algorithm:
plot(Be),grid;
title('The Convergence of the Unsmooth System');
xlabel('Number of Iteration');
ylabel('Value')
legend('a_0','a_1','b_0',2)
%Ident Function and Experemental data:
subplot(1,2,2)
hold on, grid on
y_ident=lsim(W,u,t);
plot(t,y_ident,t,y)
xlabel('t,sec');
ylabel('h(t)')
title('System Output');
legend('Identify System','Experemental Data',4)
figure(3)
subplot(1,2,1)
% The Convergence of the algorithm:
plot(Be_s),grid;
title('The Convergence of the Smooth System');
xlabel('Number of Iteration');
ylabel('Value')
legend('a_0','a_1','b_0',2)
%Ident Function and Experemental data:
subplot(1,2,2)
hold on, grid on
ys_ident=lsim(Ws,u,t);
plot(t,ys_ident,t,h,t,y)
xlabel('t,sec');
ylabel('h(t)')
title('System Output');
legend('Identify System','Smooth Data','Experemental data',4)
hold off;

%Base system:
% figure(3)
% subplot(1,3,1)
% plot(t_sym,y_g1);
% grid on;
% xlabel('t,sec');
% ylabel('y(t)')
% title('Error Type \sigma');
% subplot(1,3,2)
% plot(t_sym,y_g2);
% grid on;
% xlabel('t,sec');
% ylabel('y(t)')
% title('Error Type \phi');
% subplot(1,3,3)
% plot(t_sym,y_g3);
% grid on;
% xlabel('t,sec');
% ylabel('y(t)')
% title('Error Type \sigma+\phi');

% % %Obsver:
% figure(4)
% plot(t_sym,obs_out(:,1),t_sym,obs_out(:,2),t_sym,obs_out(:,3));
% grid on;
% legend ('x_1','x_2','y')
% xlabel('t,sec');
% ylabel('h(t)')
% title('Obsver Output');
% 
% figure(5)
% plot(t_sym,obs_e1,t_sym,obs_e2);
% grid on;
% xlabel('t,sec');
% ylabel('e(t)')
% legend ('e_1','e_2')
% title('Obsver Error');

% figure(6)
% subplot(1,3,1)
% plot(t_sym,obs_e1,t_sym,obs_e2);
% grid on;
% xlabel('t,sec');
% ylabel('e(t)')
% legend ('e_1','e_2')
% title('Obsver Error - \phi');
% 
% subplot(1,3,2)
% plot(t_sym,obs_e11,t_sym,obs_e22);
% grid on;
% xlabel('t,sec');
% ylabel('e(t)')
% legend ('e_1','e_2')
% title('Obsver Error - \sigma')
% 
% subplot(1,3,3)
% plot(t_sym,obs_e111,t_sym,obs_e222);
% grid on;
% xlabel('t,sec');
% ylabel('e(t)')
% legend ('e_1','e_2')
% title('Obsver Error - \phi+\sigma')

% % 
% % %Adaptive system:
% figure(7)
% subplot(1,3,1)
% plot(t_sym,Y1);
% grid on;
% xlabel('t,sec');
% ylabel('y(t)')
% title('System Output - Parametric Configure');
% 
% subplot(1,3,2)
% plot(t_sym,Y2);
% grid on;
% xlabel('t,sec');
% ylabel('y(t)')
% title('System Output - Parametric+P')
% 
% subplot(1,3,3)
% plot(t_sym,Y3);
% grid on;
% xlabel('t,sec');
% ylabel('y(t)')
% title('System Output - Parametric+Signal')
% 
% %%%%%%%%%%%%%%%%%%%
% figure(8)
% subplot(3,3,1)
% plot(t_sym,U1);
% grid on;
% xlabel('t,sec');
% ylabel('U(t)')
% title('Control - Parametric Configure');
% 
% subplot(3,3,2)
% plot(t_sym,U2);
% grid on;
% xlabel('t,sec');
% ylabel('U(t)')
% title('Control - Parametric+P')
% 
% subplot(3,3,3)
% plot(t_sym,U3);
% grid on;
% xlabel('t,sec');
% ylabel('y(t)')
% title('Control - Parametric+Signal')
% %%%%%%%%%
% subplot(3,3,4)
% plot(t_sym,e1);
% grid on;
% xlabel('t,sec');
% ylabel('e(t)')
% title('System Error');
% 
% subplot(3,3,5)
% plot(t_sym,e2);
% grid on;
% xlabel('t,sec');
% ylabel('e(t)')
% title('System Error')
% 
% subplot(3,3,6)
% plot(t_sym,e3);
% grid on;
% xlabel('t,sec');
% ylabel('e(t)')
% title('System Error')
% %%%%%%%%%
% subplot(3,3,7)
% plot(t_sym,Kab1);
% grid on;
% xlabel('t,sec');
% ylabel('e(t)')
% title('Alghorithm Parameters');
% 
% subplot(3,3,8)
% plot(t_sym,Kab2);
% grid on;
% xlabel('t,sec');
% ylabel('e(t)')
% title('Alghorithm Parameters')
% 
% subplot(3,3,9)
% plot(t_sym,Kab3);
% legend('K_a_1','K_a_2','K_a_3')
% grid on;
% xlabel('t,sec');
% ylabel('e(t)')
% title('Alghorithm Parameters')


