% 离散时间步的迭代---Henon 吸引子
%% whole status
n = 10000;
trajectories_x = zeros(1,n);
trajectories_y = zeros(1,n);
iterate_x = 0;
iterate_y = 0;
for i = 1:n
    [trajectories_x(i),trajectories_y(i)] = henon(iterate_x,iterate_y);
    iterate_x = trajectories_x(i);
    iterate_y = trajectories_y(i);
end
plot(trajectories_x(100:end),trajectories_y(100:end),'.');

%% single dynamics
n = 1000;
iterate_x = 0;
iterate_y = 0;
plot(iterate_x,iterate_y,'b.');
axis([-1.5,1.5,-0.4,0.4]);
hold on;
for i = 1:n
    [new_x,new_y] = henon(iterate_x,iterate_y);
    if i > 100
        dot2dot([iterate_x,new_x;iterate_y,new_y],[-1.5,1.5,-0.4,0.4]);
        iterate_x = new_x; iterate_y = new_y;
        hold on;
        pause(0.6);
    end
end
hold off;

%% how does it attract its neighbors
% 也就是说如果平面中的点都按照henon的规律来运行，那么那么它们的极限模式是什么样的
iterate_x = -1.5:0.04:1.5;
iterate_y = -0.4:0.01:0.4;
[iterate_x,iterate_y] = meshgrid(iterate_x,iterate_y);
status_matrix = [iterate_x(:),iterate_y(:)];
n = 1000;
grid on;
plot(status_matrix(:,1),status_matrix(:,2),'.','markersize',5,'color','blue');
axis([-1.8,1.8,-0.5,0.5]);
for i = 1:n
    [iterate_x,iterate_y] = henon(status_matrix(:,1),status_matrix(:,2));
    status_matrix =  [iterate_x,iterate_y];
    pause(0.4);
    plot(status_matrix(:,1),status_matrix(:,2),'.','markersize',5,'color','blue');
    axis([-1.8,1.8,-0.5,0.5]);
end
hold off;

%% Henon 吸引子的李指数
% 由于 Henon 吸引子是二维的，这导致两个方面的问题
% 第一个方面的问题是，在计算它的李指数时，需要考虑到两个方向的误差，即x方向和y方向的误差，并且在迭代的过程中误差的方向也应该保持一致
% 第二个方面的问题是，在二维的情况下，吸引子会有一个面积的度量，那么这个吸引子的面积在迭代的过程中的变化速度实际上也可以用李指数来描述

% 第一个方面的问题又有两个层次，第一个层次是采用比较朴素的数值迭代来解；第二个层次则是采用更为准确的变化率(微分)来解
% 首先来看第一个层次
%% The Lyapunov exponent for Henon
clc
phi = pi/2; % 方向，弧度制
epselon = 0.00001; % 误差
initial_point = [0,0];
iteration_times = 100000;
for i = 1:100 % 先进入吸引子
    initial_point = henon(initial_point(1),initial_point(2));
end
perturbed_point = initial_point + epselon*[cos(phi),sin(phi)]; % 初始化扰动点
lamda = 0;
for j = 1:iteration_times
    initial_point = henon(initial_point(1),initial_point(2));
    perturbed_point = henon(perturbed_point(1),perturbed_point(2));
    % 计算两点之间的距离
    d = norm(initial_point-perturbed_point);
    % 累加两次之间误差的比值(这里 d/epselon 相当于 书上 E1/E0)
    lamda = lamda + log(d/epselon);
    %epselon = d;
    % 重整化(解一个线性方程组)
    perturbed_point = initial_point + epselon/d*(perturbed_point-initial_point);
end
lamda = lamda/iteration_times; % lamda = 0.4203
%% The exact Lyapunov exponent for Henon( 新疆界 663 )
phi = pi/100;
error = [cos(phi);sin(phi)]; % 误差
initial_point = [0,0];
iteration_times = 100000;
lamda = 0;
for i = 1:100
    initial_point = henon(initial_point(1),initial_point(2));
end
for j = 1:iteration_times
    initial_point = henon(initial_point(1),initial_point(2));
    error = [-2*1.4*initial_point(1),1;0.3,0]*error;
    d = norm(error);
    % 这里 epselon = 1所以相当于没有除
    lamda = lamda+log(d);
    % 重整化
    error = error/d;
end
lamda = lamda/iteration_times;

% 那么为什么要重整化呢？
% 重整化使得每次迭代都是在该次迭代的准确轨道上的误差，而不是在之前已经通过误差迭代过的基础上进行的迭代。也就是说每次迭代后计算出来
% 距离是本次迭代所产生的误差，不涉及前面的迭代产生的误差，这样更能够准确反映每一次迭代误差它自己在一个方向上的增长速度。

% 对于 Henon 的第二个方面，在Henon吸引子上去一个圆盘，在动力学过程中，这个圆盘的面积以exp(0.3)的速率变小，而这个圆盘的面积是由
% 长轴和短轴来确定的，长轴在迭代过程中越来越长(对应误差越来越大，轨道分离的过程）,短轴在迭代过程中越来越短(对应误差慢慢减小，
% 轨道相互靠近的过程).长轴变长的速率已经由上面的计算给出：exp(lamda_1), 而我们知道圆盘的面积以exp(0.3)的速度减小，故而可以
% 解出短轴变短的速率：exp(0.3-lamda_1),而其指数就是Henon吸引子的第二李指数

























