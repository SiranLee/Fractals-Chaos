% ����ʱ��ı仯--������������
%% Whloe Trajectories
tspan = [0,100];
x0 = [1;1;1];
[t,x] = ode45('odefun',tspan,x0);
grid on;
plot3(x(:,1),x(:,2),x(:,3),'-')
grid on;

%% The First Lyapunov Exponent for Lorenz Attractor
phi = pi/100;
theta = pi/4;
epselon = 0.0001; % ���
iteration_times = 400;
delta_t = 1/iteration_times; % ������ʱ�䲽��
exact_point = [1;1;1];
lamda = 0;
% �Ȱ����prev_point������θ(������attractor��)
for i = 1:300
    [delta_x,delta_y,delta_z] = euler_solution(exact_point(1),exact_point(2),exact_point(3),delta_t);
    exact_point = exact_point + [delta_x,delta_y,delta_z]';
end
perturbed_point = exact_point+epselon*[sin(phi)*cos(theta);sin(phi)*sin(theta);cos(phi)];
for i = 1:10000
    % ��400��delta_t����һ��
    for j = 1:iteration_times
        [delta_x,delta_y,delta_z] = euler_solution(exact_point(1),exact_point(2),exact_point(3),delta_t);
        exact_point = exact_point + [delta_x,delta_y,delta_z]';
        [deltap_x,deltap_y,deltap_z] = euler_solution(perturbed_point(1),perturbed_point(2),perturbed_point(3),delta_t);
        perturbed_point = perturbed_point + [deltap_x,deltap_y,deltap_z]';
    end
    d = norm(exact_point-perturbed_point);
    % ��һ��(400��delta_t����֮������ܵľ���)  Ϊʲô��������
    lamda = lamda + log(d/epselon);
    % ������
    perturbed_point = exact_point + epselon/d*(perturbed_point-exact_point);
end
lamda = lamda/10000; 
%% The Exact First Lyapunov Exponent for Lorenz Attractor
delta = 10; R = 28; B = 8/3;
delta_t = 0.01;
phi = pi/100;
theta = pi/4;
epselon = [sin(phi)*cos(theta);sin(phi)*sin(theta);cos(phi)];
error = epselon;
exact_point = [1;1;1];
lamda = 0;
iteration_times = 400;
derivative_matrix = [-delta,delta,0;R-exact_point(3),-1,-exact_point(1);exact_point(2),exact_point(1),-B];

% ���Ľ�����-���������
tspan = [0,400];
x0 = [1;1;1];
[t,x] = ode45('odefun',tspan,x0);
exact_point = [x(end,1);x(end,2);x(end,3)];

for i = 1:1000
    error = derivative_matrix * error;
    [t,x] = ode45('odefun',[i*400,(i+1)*400],exact_point);
    exact_point = [x(end,1);x(end,2);x(end,3)];
    d = norm(error);
    lamda = lamda + log(d);
    % ������
    error = error/d;
end
lamda = lamda/10000; 


























