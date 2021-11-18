function [Mean, Cov] = meanCov( X )
%�����ֵ��Э���������
%% �ڴ�Ԥ����
N = size(X,3);  %������
Mean = eye(4);
Cov = zeros(6,6);

%% Initial approximation of Mean
sum_se = zeros(4,4);
for i = 1:N
    sum_se = sum_se + logm(X(:,:,i));
end
Mean = expm(1/N*sum_se);

%% Iterative process(��������) to calculate the true Mean
diff_se = ones(4,4);
max_num = 100;
tol = 1e-5;
count = 1;
while norm(diff_se,'fro') >= tol && count <= max_num
    diff_se = zeros(4,4);
    for i = 1:N
        diff_se = diff_se + logm((Mean)\X(:,:,i));
    end
    Mean = Mean*expm(1/N * diff_se);
    count = count+1;
end
% disp(['Number of iterations: ', num2str(count)]);

%% Covariance���������100������Э�����ƽ��ֵCov=6*6��ʵ�������й�ʽ17b�ļ��㣩
for i = 1:N
    diff_se = logm(Mean\X(:,:,i));
    diff_vex = [vex(diff_se(1:3,1:3)); diff_se(1:3,4)];     %vex��skew���෴������
    Cov = Cov + diff_vex * diff_vex';
end
Cov = Cov/N;

%% Check
% meanCovCheck(Mean, Cov, X);
% len = 0.1;
% figure; hold on; axis equal;
% trplot(Mean,'color','r', 'length', len)
% for i = 1:N
%     trplot(X(:,:,i), 'color', 'b', 'length', len)
% end