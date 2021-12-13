% delta_t = 0.01;
% x = 1; y = 1; z = 1;
% plot3(x,y,z,'b.');
% grid on;
% hold on;
% iterative_times = 2000;
% xlabel('x'); ylabel('y'); zlabel('z');
% for i = 1:iterative_times
%     [delta_x,delta_y,delta_z] = euler_solution(x,y,z,delta_t);
%     x = x + delta_x; y = y + delta_y; z = z + delta_z;
%     plot3(x,y,z,'b.');
%     axis([-30,30,-30,30,0,60]);
%     grid on;
%     pause(delta_t);
% end
% hold off;
delta_t = 0.0001;
z = 0:5:60;
y = -30:5:30;
x = y;
[X,Y,Z] = meshgrid(x,y,z);
matrix = [X(:),Y(:),Z(:)];
n = length(matrix);
iterative_times = 5000;
for i = 1:iterative_times
    for j = 1:n
        cur_point = matrix(j,:);
        [delta_x,delta_y,delta_z] = euler_solution(cur_point(1),cur_point(2),cur_point(3),delta_t);
        matrix(j,:) = cur_point + [delta_x,delta_y,delta_z];
    end
    plot3(matrix(:,1),matrix(:,2),matrix(:,3),'.');
    axis([-30,30,-30,30,0,60]);
    view(-17,30);
    grid on;
    pause(0.01);
end
hold off;

    