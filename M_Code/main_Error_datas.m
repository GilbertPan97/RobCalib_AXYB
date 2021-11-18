% This is the main file for AX = YB problem

clear; close all; clc

%% Add file dependencies
addpath util/
addpath solvers/

%% Initialize Parameters
counter = 0;
gmean = [0; 0; 0; 0; 0 ;0];
coeff = 0.05;
cov = eye(6,6); % coeff1*cov
num = 5;        % number of simulations
Num = 10:10:100;       % number of data
optPlot = 'lineplot'; % Plot the averaged error : 'lineplot' & ''boxplot'
opt_XY = 2;     % generate optional X, Y

%% Set the true value of X Y
[XActual, YActual] = InitializeXY(opt_XY);

%% Error container initialization
Err_DQ = zeros(length(Num), 4, num);
Err_wang = zeros(length(Num), 4, num);
Err_lmi = zeros(length(Num), 4, num);

for k = Num
    counter = counter + 1;
    
    for s = 1:num   % Simulation 5 times
        %% Simulation data generate
        optPDF = 3;
        [A, B] =  generateAB_random(k, optPDF, gmean, coeff*cov, XActual, YActual);

        %% -------------- simulation --------------- %%
        [X_DQ, Y_DQ] = DQ_AXYB(A, B, XActual, YActual);
        [X_wang, Y_wang] = Wang_AXYB(A, B);
        [X_lmi, Y_lmi] = LMI_AXYB(A, B);
        
                %% ----- Error Analysis ------ %%
        % ------- li Error with Data of 3rd Distribution ------ %
        Err_DQ(counter,:,s) = getErrorAXYB(X_DQ, Y_DQ, XActual, YActual);
        % ------- shah Error with Data of 3rd Distribution ------ %
        Err_wang(counter,:,s) = getErrorAXYB(X_wang, Y_wang, XActual, YActual);
        % ------- pan Error with Data of 3rd Distribution ------ %
        Err_lmi(counter,:,s) = getErrorAXYB(X_lmi, Y_lmi, XActual, YActual);
    end
end

ERROR_DQ= sum(Err_DQ, 3)/size(Err_DQ, 3);
ERROR_wang= sum(Err_wang, 3)/size(Err_wang, 3);
ERROR_lmi= sum(Err_lmi, 3)/size(Err_lmi, 3);
% save ./results/datasets.mat coeff Num ERROR_DQ ERROR_lmi ERROR_wang
label = {'DQ-SVD-based', 'Iterative', 'LMI-SDP'};
Sim_Cov_plot( ERROR_DQ , ERROR_wang, ERROR_lmi ,Num, label);

%% ----------- plot functions ------------- %%
function Sim_Cov_plot(ERROR_1 , ERROR_2, ERROR_3 , Num, label)

    figure
    subplot(221)
    plot(Num, ERROR_1(:,1),'r->','linewidth',1.15)
    hold on
    plot(Num, ERROR_2(:,1),'g-+','linewidth',1.15)
    plot(Num, ERROR_3(:,1),'b-o','linewidth',1.15)
    set(gca,'fontsize',14)
    xlabel('Number of simulation datas');
    ylabel('Rotation error of X (rad)');
    legend(label{1},label{2},label{3});

    subplot(222)
    plot(Num, ERROR_1(:,2),'r->','linewidth',1.15)
    hold on
    plot(Num, ERROR_2(:,2),'g-+','linewidth',1.15)
    plot(Num, ERROR_3(:,2),'b-o','linewidth',1.15)
    set(gca,'fontsize',14)
    xlabel('Number of simulation datas');
    ylabel('Rotation error of Y (rad)');
    legend(label{1},label{2},label{3});
    axis auto

    subplot(223)
    plot(Num, ERROR_1(:,3),'r->','linewidth',1.15)
    hold on
    plot(Num, ERROR_2(:,3),'g-+','linewidth',1.15)
    plot(Num, ERROR_3(:,3),'b-o','linewidth',1.15)
    set(gca,'fontsize',14)
    xlabel('Number of simulation datas');
    ylabel('Translation error of X (mm)');
    legend(label{1},label{2},label{3});

    subplot(224)
    plot(Num, ERROR_1(:,4),'r->','linewidth',1.15)
    hold on
    plot(Num, ERROR_2(:,4),'g-+','linewidth',1.15)
    plot(Num, ERROR_3(:,4),'b-o','linewidth',1.15)
    set(gca,'fontsize',14)
    xlabel('Number of simulation datas');         % xticks(0:0.002:0.01);
    ylabel('Translation error of Y (mm)');    % yticks(0:0.01:0.05);
    legend(label{1},label{2},label{3});
end