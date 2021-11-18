function [A, B] =  generateAB_random(length, optPDF, M, Sig, X, Y)
%% Data generation for AX = YB problem
% Input:
%       length: number of generated data pairs(Num=100)
%       optPDF: option for generating data using different distributions
%       M:      mean of perturbance in lie algebra
%       Sig:    covariance of perturbance in lie algebra（代数中扰动的协方差）
%       X, Y:   ground truths
% Output:
%       A, B:   4 x 4 x length or 4 x 4 
%               noise-free data streams with correspondence
%
% Authors: Jiabin Pan, gilbertpan97@gmail.com; 

%% Times of simulation steps
len = length; 

%% 修正A、B或C，如固定A时，A=A_initial;给B添加扰动，求解C

A = zeros(4, 4, len);
B = zeros(4, 4, len);

for m = 1:len 
    %% randomize A and generate B
    % This can be applied to both serial-parallel and robot arm calibrations
    a = randn(6,1); a = a./norm(a); A_initial = expm(se3_vec(a));
    A_initial(1:3,4) = A_initial(1:3,4)*1000;
    B_initial = Y\A_initial*X;

    A(:,:,m) = A_initial;
    % three different ways to add noise
    if optPDF == 1
        B(:,:,m) = expm(se3_vec(mvg(M, Sig, 1)))*B_initial;     % this way is not applicable
    elseif optPDF == 2
        B(:,:,m) = B_initial*expm(se3_vec(mvg(M, Sig, 1)));
    elseif optPDF == 3
        gmean = [0; 0; 0; 0; 0; 0];
        % Assume Sig is a matrix with the same diagonal values
        B(:,:,m) = sensorNoise(B_initial, gmean, Sig(1), 1);
    end
end
