function target_point = roll_dice(x,y)
    rand_result = rand*3;
    if 0<=rand_result && rand_result <1
        target_point = [x(1),y(1)];
    elseif 1 <= rand_result && rand_result < 2
        target_point = [x(2),y(2)];
    elseif 2 <= rand_result && rand_result < 3
        target_point = [x(3),y(3)];
    end
end