x = [1,2,3]; y = [0,3,0];
plot(x,y);
hold on;
axis([0,4,0,4]);
exp_times = 5000;
point0 = [0,4];
for i = 1:exp_times
    target_point = roll_dice(x,y);
    next_point = (target_point + point0)./2;
    point0 = next_point;
    plot(next_point(1),next_point(2),'.');
    pause(0.01);
end
hold off;