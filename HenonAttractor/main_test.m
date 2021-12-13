% ��ɢʱ�䲽�ĵ���---Henon ������
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
% Ҳ����˵���ƽ���еĵ㶼����henon�Ĺ��������У���ô��ô���ǵļ���ģʽ��ʲô����
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

%% Henon �����ӵ���ָ��
% ���� Henon �������Ƕ�ά�ģ��⵼���������������
% ��һ������������ǣ��ڼ���������ָ��ʱ����Ҫ���ǵ��������������x�����y������������ڵ����Ĺ��������ķ���ҲӦ�ñ���һ��
% �ڶ�������������ǣ��ڶ�ά������£������ӻ���һ������Ķ�������ô��������ӵ�����ڵ����Ĺ����еı仯�ٶ�ʵ����Ҳ��������ָ��������

% ��һ���������������������Σ���һ������ǲ��ñȽ����ص���ֵ�������⣻�ڶ���������ǲ��ø�Ϊ׼ȷ�ı仯��(΢��)����
% ����������һ�����
%% The Lyapunov exponent for Henon
clc
phi = pi/2; % ���򣬻�����
epselon = 0.00001; % ���
initial_point = [0,0];
iteration_times = 100000;
for i = 1:100 % �Ƚ���������
    initial_point = henon(initial_point(1),initial_point(2));
end
perturbed_point = initial_point + epselon*[cos(phi),sin(phi)]; % ��ʼ���Ŷ���
lamda = 0;
for j = 1:iteration_times
    initial_point = henon(initial_point(1),initial_point(2));
    perturbed_point = henon(perturbed_point(1),perturbed_point(2));
    % ��������֮��ľ���
    d = norm(initial_point-perturbed_point);
    % �ۼ�����֮�����ı�ֵ(���� d/epselon �൱�� ���� E1/E0)
    lamda = lamda + log(d/epselon);
    %epselon = d;
    % ������(��һ�����Է�����)
    perturbed_point = initial_point + epselon/d*(perturbed_point-initial_point);
end
lamda = lamda/iteration_times; % lamda = 0.4203
%% The exact Lyapunov exponent for Henon( �½��� 663 )
phi = pi/100;
error = [cos(phi);sin(phi)]; % ���
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
    % ���� epselon = 1�����൱��û�г�
    lamda = lamda+log(d);
    % ������
    error = error/d;
end
lamda = lamda/iteration_times;

% ��ôΪʲôҪ�������أ�
% ������ʹ��ÿ�ε��������ڸôε�����׼ȷ����ϵ�����������֮ǰ�Ѿ�ͨ�����������Ļ����Ͻ��еĵ�����Ҳ����˵ÿ�ε�����������
% �����Ǳ��ε����������������漰ǰ��ĵ������������������ܹ�׼ȷ��ӳÿһ�ε���������Լ���һ�������ϵ������ٶȡ�

% ���� Henon �ĵڶ������棬��Henon��������ȥһ��Բ�̣��ڶ���ѧ�����У����Բ�̵������exp(0.3)�����ʱ�С�������Բ�̵��������
% ����Ͷ�����ȷ���ģ������ڵ���������Խ��Խ��(��Ӧ���Խ��Խ�󣬹������Ĺ��̣�,�����ڵ���������Խ��Խ��(��Ӧ���������С��
% ����໥�����Ĺ���).����䳤�������Ѿ�������ļ��������exp(lamda_1), ������֪��Բ�̵������exp(0.3)���ٶȼ�С���ʶ�����
% ��������̵����ʣ�exp(0.3-lamda_1),����ָ������Henon�����ӵĵڶ���ָ��

























