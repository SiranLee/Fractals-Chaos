% 连续时间的变化--洛伦兹吸引子
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
epselon = 0.0001; % 误差
iteration_times = 400;
delta_t = 1/iteration_times; % 迭代的时间步长
exact_point = [1;1;1];
lamda = 0;
% 先把这个prev_point迭代到胃(迭代到attractor上)
for i = 1:300
    [delta_x,delta_y,delta_z] = euler_solution(exact_point(1),exact_point(2),exact_point(3),delta_t);
    exact_point = exact_point + [delta_x,delta_y,delta_z]';
end
perturbed_point = exact_point+epselon*[sin(phi)*cos(theta);sin(phi)*sin(theta);cos(phi)];
for i = 1:10000
    % 这400个delta_t算作一步
    for j = 1:iteration_times
        [delta_x,delta_y,delta_z] = euler_solution(exact_point(1),exact_point(2),exact_point(3),delta_t);
        exact_point = exact_point + [delta_x,delta_y,delta_z]';
        [deltap_x,deltap_y,deltap_z] = euler_solution(perturbed_point(1),perturbed_point(2),perturbed_point(3),delta_t);
        perturbed_point = perturbed_point + [deltap_x,deltap_y,deltap_z]';
    end
    d = norm(exact_point-perturbed_point);
    % 这一步(400个delta_t算完之后才算总的距离)  为什么这样做？
    lamda = lamda + log(d/epselon);
    % 重整化
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

% 用四阶龙格-库塔来解点
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
    % 重整化
    error = error/d;
end
lamda = lamda/10000; 


























