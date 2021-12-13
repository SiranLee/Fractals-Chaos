function dvar = rossler(t,var)
    % 这里的t表示随时间的变化，就算微分方程中没有，也不能省去
    % 这里的var表示所有的变量，如这里Rossler方程是三维的，所以变量由 x ,y, z
    a = 0.2;
    b = 0.2;
    c = 5.7;
    dvar = zeros(3,1); % 定义微分方程的函数必须返回一个三维列向量，里面的元素分别表示每个变量的微分
    dvar(1)=-(var(2)+var(3));
    dvar(2)=var(1)+a*var(2);
    dvar(3)=b + var(1)*var(3) - c*var(3);
end