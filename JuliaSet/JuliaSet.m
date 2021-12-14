% constant c
% c = -1;
% c = 0.4;
% c = -2;
c = 1i;
% c = -0.5+0.5i;
% threshold
threshold = max(abs(c),2);
% x-y plane
x = -5:0.0025:5;
y = (-5:0.0025:5);
n = length(x);
[x,y] = meshgrid(x,y);
points = x+1i*y;
% distance matrix
prison_steps = zeros(n,n);
% iterate
iterative_times = 50;

for k = 1:iterative_times
    points = points.^2+c;
    indexes = abs(points)<threshold;
    prison_steps(indexes) = k;
end

image(prison_steps);
axis image;
% colormap(flipud(parula(32)))
colormap(gray(32));
