function createfigure(X1, YMatrix1)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  x 数据的向量
%  YMATRIX1:  y 数据的矩阵

%  由 MATLAB 于 17-Oct-2021 18:39:27 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 使用 plot 的矩阵输入创建多行
plot1 = plot(X1,YMatrix1,'LineWidth',1.5,'Parent',axes1);
set(plot1(1),'DisplayName','Iterative method for X','Color',[1 0 0]);
set(plot1(2),'DisplayName','DQ-based method for X','Color',[0 1 0]);
set(plot1(3),'DisplayName','Proposed method for X','Color',[0 0 1]);
set(plot1(4),'DisplayName','Iterative method for Y','Marker','o',...
    'Color',[1 0 0]);
set(plot1(5),'DisplayName','DQ-based method for Y','Marker','o',...
    'Color',[0 1 0]);
set(plot1(6),'DisplayName','Proposed method for Y','Marker','o',...
    'Color',[0 0 1]);

% 创建 ylabel
ylabel('Rotational errors of X and Y');

% 创建 xlabel
xlabel('Number of simulation datas');

box(axes1,'on');
grid(axes1,'on');
hold(axes1,'off');
% 设置其余坐标区属性
set(axes1,'FontSize',14,'LineWidth',1.2);
% 创建 legend
legend(axes1,'show');

