% ����ʱ�䲽�ı仯--Rossler ������
%% Whole Trajectories 
tspan = [0,1000]; % �������΢�ַ�����ʱ�䲽�仯����������ʱ������
var_0 = [-1,0,0]; % ��ʼ����
[t,result] = ode45('rossler',tspan,var_0);
plot3(result(:,1),result(:,2),result(:,3));

%% single dynamics--ʹ��ŷ����
n = 1000;
delta_t = 0.01;
iteration_times = 100000;
prev_point = [-1,0,0];
plot3(prev_point(1),prev_point(2),prev_point(3),'b.','markersize',7);
axis_range = [-10,15,-12,8,0,25];
axis(axis_range);
hold on;
grid on;
for i = 1:iteration_times
    delta_result = euler_rossler(prev_point,delta_t);
    prev_point = prev_point+delta_result;
    plot3(prev_point(1),prev_point(2),prev_point(3),'b.','markersize',7);
    pause(0.01);
    hold on;
    axis(axis_range);
end
hold off;
