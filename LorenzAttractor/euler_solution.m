function [next_x,next_y,next_z] = euler_solution(prev_x,prev_y,prev_z,delta_t)
    next_x = 10*(prev_y-prev_x)*delta_t;
    next_y = (prev_x*(28-prev_z)-prev_y)*delta_t;
    next_z = (prev_x*prev_y- 8/3 *prev_z)*delta_t;
end