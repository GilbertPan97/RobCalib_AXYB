% This is the main file for AX = YB problem

clear; close all; clc

%% Add file dependencies
addpath util/
addpath solvers/

%% Initialize Parameters
counter = 0;
gmean = [0; 0; 0; 0; 0 ;0];
coeff = 0:0.01:0.1;
cov = eye(6,6); % coeff1*cov
num = 5;        % number of simulations
Num = 50;       % number of data
optPlot = 'lineplot'; % Plot the averaged error : 'lineplot' & ''boxplot'
opt_XY = 2;     % generate optional X, Y

%% Set the true value of X Y
[XActual, YActual] = InitializeXY(opt_XY);

%% Error container initialization
Err_DQ = zeros(length(coeff), 4, num);
Err_wang = zeros(length(coeff), 4, num);
Err_lmi = zeros(length(coeff), 4, num);

for k = coeff
    counter = counter + 1;
    
    for s = 1:num   % Simulation 5 times
        %% ------- Simulation data generate -------- %%
        optPDF = 3;     % optPDF == 2 or 3, and 1 is not applicable for this problem
        [A, B] =  generateAB_random(Num, optPDF, gmean, k*cov, XActual, YActual);

        %% -------------- simulation --------------- %%
        [X_DQ, Y_DQ] = DQ_AXYB(A, B, XActual, YActual);
        [X_wang, Y_wang] = Wang_AXYB(A, B);
        [X_lmi, Y_lmi] = LMI_AXYB(A, B);
        
        %% ------------- Error Analysis ------------ %%
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

Error_container(:,:,1) = ERROR_DQ;
Error_container(:,:,2) = ERROR_wang;
Error_container(:,:,3) = ERROR_lmi;
% save ./results/noise.mat coeff ERROR_DQ ERROR_lmi ERROR_wang
label = {'DQ-SVD-based', 'Iterative', 'LMI-SDP'};
Sim_Cov_plot( Error_container ,coeff, label);

%% ----------- plot functions ------------- %%
function Sim_Cov_plot(Error_container , coeff, label)

    nbr = size(Error_container, 3);
    figure
    for i = 1:4
        for j = 1:nbr
            subplot(220+i)
            if j == 1
                plot(coeff, Error_container(:,i,j),'r->','linewidth',1.15)
                legend(label{1});
            elseif j == 2
                hold on
                plot(coeff, Error_container(:,i,j),'g-+','linewidth',1.15)
                legend(label{1},label{2});
            elseif j == 3
                hold on
                plot(coeff, Error_container(:,i,j),'b-o','linewidth',1.15)
                legend(label{1},label{2},label{3});
            end
            set(gca,'fontsize',14)
            
            if i == 1
                xlabel('\sigma_N');
                ylabel('E_{R_{X}}(rad)');
            elseif i == 2
                xlabel('\sigma_N');
                ylabel('E_{R_{Y}}(rad)');
            elseif i == 3
                xlabel('\sigma_N');
                ylabel('E_{t_{Y}}(mm)');
            elseif i == 4
                xlabel('\sigma_N');
                ylabel('E_{t_{X}}(mm)');
            end
        end
        axis auto
    end   
end












