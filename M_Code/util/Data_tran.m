function X_new = Data_tran( X )
% 输入    X：需要转换形式的数据流
% 输出   X_new：输出转换好形式的数据流
% 注释：将一个三维的数据流X转换成二维并排的形式

num = size(X,3);
X_new = zeros(4,4*num);
for i=1:num
    X_new(:,4*(i-1)+1:4*i) = X(:,:,i);
end

