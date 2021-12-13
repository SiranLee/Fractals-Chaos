function result = euler_rossler(prev_point,delta_t)
    a = 0.2;
    b = 0.2;
    c = 5.7;
    result = zeros(1,3);
    result(1) = -(prev_point(2)+prev_point(3))*delta_t;
    result(2) = (prev_point(1)+a*prev_point(2))*delta_t;
    result(3) = (b+prev_point(1)*prev_point(3)-c*prev_point(3))*delta_t;
end