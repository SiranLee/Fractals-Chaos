function result = henon(prev_x,prev_y)
   a = 1.4;
   b = 0.3;
   result = [0,0];
   result(1) = prev_y+1-a*prev_x.^2;
   result(2) = b*prev_x;
end