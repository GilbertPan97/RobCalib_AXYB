function X_new = Data_tran( X )
% ����    X����Ҫת����ʽ��������
% ���   X_new�����ת������ʽ��������
% ע�ͣ���һ����ά��������Xת���ɶ�ά���ŵ���ʽ

num = size(X,3);
X_new = zeros(4,4*num);
for i=1:num
    X_new(:,4*(i-1)+1:4*i) = X(:,:,i);
end

