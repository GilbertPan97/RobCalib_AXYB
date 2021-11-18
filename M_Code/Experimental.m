% This is the main file for AX = YB problem

clear; close all; clc

%% Add file dependencies
addpath util/
addpath solvers/

%% Initialize Parameters
Num = 16;       % number of data
optPlot = 'lineplot'; % Plot the averaged error : 'lineplot' & ''boxplot'
opt_XY = 2;     % generate random X, Y

%% Load datas -> A
path1 = './ExperimentData/data_A/robot_tcp.xlsx';
[robot_tcp, txt, raw] = xlsread(path1);
A = xyzwpr2HTM(robot_tcp(1:Num,2:7));

%% Camera calibrate -> B
B = zeros(4,4,Num);
squareSize = 10;
path = './ExperimentData/Images/';
B_inv = camera_Calibrator(path, Num, squareSize);
for i = 1:Num
    B(:,:,i) = inv(B_inv(:,:,i));
end

%% the evaluate value of X and Y
X_eva =...
   [0.7377   -0.6739    0.0405   61.9842;
    0.6734    0.7388    0.0280  -64.4769;
   -0.0488    0.0066    0.9988   30.0404;
         0         0         0    1.0000];
Y_eva = ...
    [0.5214   -0.8234    0.2239  668.2798;
    -0.7189   -0.5652   -0.4047   17.5273;
     0.4598    0.0500   -0.8866 -161.6618;
          0         0         0    1.0000];

%% calibrate
[X_wang, Y_wang] = Wang_AXYB(A, B)
[X_dq, Y_dq] = DQ_AXYB(A,B,X_eva,Y_eva)
[X_lmi, Y_lmi] = LMI_AXYB1(A, B)

%% error plot
Err_wang = zeros(2,Num);
Err_dq = zeros(2,Num);
Err_lmi = zeros(2,Num);
for i = 1:Num
%% -------------- Error Analysis ------------ %%
    Hl_wang = A(:,:,i)*X_wang;  Hr_wang = Y_wang*B(:,:,i);
    Hl_dq = A(:,:,i)*X_dq;      Hr_dq = Y_dq*B(:,:,i);
    Hl_lmi = A(:,:,i)*X_lmi;    Hr_lmi = Y_lmi*B(:,:,i);
    
    X_err_wang = X_wang - A(:,:,i)\Y_wang*B(:,:,i);
    X_err_dq = X_dq - A(:,:,i)\Y_dq*B(:,:,i);
    X_err_lmi = X_lmi - A(:,:,i)\Y_lmi*B(:,:,i);
    
    Equ_err_wang = A(:,:,i)*X_wang-Y_wang*B(:,:,i);
    Equ_err_dq = A(:,:,i)*X_dq-Y_dq*B(:,:,i);
    Equ_err_lmi = A(:,:,i)*X_lmi-Y_lmi*B(:,:,i);
    
    % ------- wang Error with Data of 3rd Distribution ------ %
    Err_wang(1,i) = norm( so3_vec(skewlog( Equ_err_wang(1:3, 1:3))));
    Err_wang(2,i) = norm( Equ_err_wang(1:3, 4));
    % ------- wang Error with Data of 3rd Distribution ------ %
    Err_dq(1,i) = norm( so3_vec(skewlog( Equ_err_dq(1:3, 1:3))));
    Err_dq(2,i) = norm( Equ_err_dq(1:3, 4));
    % ------- lmi Error with Data of 3rd Distribution ------ %
    Err_lmi(1,i) = norm( so3_vec(skewlog( Equ_err_lmi(1:3, 1:3))));
    Err_lmi(2,i) = norm( Equ_err_lmi(1:3, 4));
end

%% result output
fprintf('The average rotational error is:\n')
Iterative = sum(Err_wang(1,:))/Num
DQ_based = sum(Err_dq(1,:))/Num
LMI_based = sum(Err_lmi(1,:))/Num

fprintf('The average translational error is:\n')
Iterative1 = sum(Err_wang(2,:))/Num
DQ_based1 = sum(Err_dq(2,:))/Num
LMI_based1 = sum(Err_lmi(2,:))/Num

%% result plot
figure(3)
box on, hold on, grid on, axis auto
set(gca,'fontsize', 14, 'linewidth', 1.2)
scatter(Err_wang(1,:), Err_wang(2,:),'^','r', 'linewidth', 1.2)
hold on
scatter(Err_dq(1,:), Err_dq(2,:),'d','k', 'linewidth', 1.2)
hold on
scatter(Err_lmi(1,:), Err_lmi(2,:),'+','b', 'linewidth', 1.2)
xlabel('Rotation error (rad).');
ylabel('Translation error (mm).');
legend({'Iterative method','{\it{DQ}}-based method','Proposed method (LMI)'})





