function h = dot2dot(X,axisRange)
% DOT2DOT  Connect the points from a 2-by-n matrix.

%   Copyright 2014 Cleve Moler
%   Copyright 2014 The MathWorks, Inc.
X(:,end+1) = X(:,1); % ����һ�и��Ƶ����ź�����һ�У�ʹ�û�ͼʱ������β����
h = plot(X(1,:),X(2,:),'.-','markersize',10,'linewidth',1,'color','magenta');
axis(axisRange);
axis square
