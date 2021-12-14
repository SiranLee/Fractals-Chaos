function result = distance(X,ref_point,dim,indexes)
% ����X��ÿ������ref_point�ľ���
    n = length(indexes);
    result = zeros(dim,dim);
    for j = 1:n
       dis = norm(X(indexes(j),:)-ref_point);
       row = ceil(indexes(j)/dim);
       col = mod(indexes(j),dim);
       if col == 0
           col = dim;
       end
       result(row,col) = dis;
    end
end