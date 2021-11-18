clear;clc;

data1 = load('./sim_solutions/noise.mat');
data2 = load('./sim_solutions/datasets.mat');

noise = data1.coeff;
error_dq = data1.ERROR_DQ;
error_lmi = data1.ERROR_lmi;
error_wang = data1.ERROR_wang;

datasets = data2.Num;
noise1 = data2.coeff;
error1_dq = data2.ERROR_DQ;
error1_lmi = data2.ERROR_lmi;
error1_wang = data2.ERROR_wang;

%% ----------- plot result1 ------------ %%
figure(1),
box on,
hold on,
grid on,
set(gca,'fontsize',14, 'linewidth', 1.2)
plot(noise',error_wang(:,1), 'r','linewidth',1.5);
plot(noise',error_dq(:,1), 'g','linewidth',1.5);
plot(noise',error_lmi(:,1),'b','linewidth',1.5);
plot(noise',error_wang(:,2), 'r-o','linewidth',1.5);
plot(noise',error_dq(:,2), 'g-o','linewidth',1.5);
plot(noise',error_lmi(:,2),'b-o','linewidth',1.5);
xlabel('Noise standard deviation \sigma_N')
ylabel('Rotational errors of X and Y')
legend({'Iterative method for X','DQ-based method for X','Proposed method for X','Iterative method for Y','DQ-based method for Y','Proposed method for Y'},'Location','northwest')

figure(2),
box on,
hold on,
grid on,
set(gca,'fontsize',14, 'linewidth', 1.2)
plot(noise',error_wang(:,3), 'r','linewidth',1.5);
plot(noise',error_dq(:,3), 'g','linewidth',1.5);
plot(noise',error_lmi(:,3),'b','linewidth',1.5);
plot(noise',error_wang(:,4), 'r-o','linewidth',1.5);
plot(noise',error_dq(:,4), 'g-o','linewidth',1.5);
plot(noise',error_lmi(:,4),'b-o','linewidth',1.5);
xlabel('Noise standard deviation \sigma_N')
ylabel('Translational errors of X and Y')
legend({'Iterative method for X','DQ-based method for X','Proposed method for X','Iterative method for Y','DQ-based method for Y','Proposed method for Y'},'Location','northwest')
hold off;

%% ----------- plot result2 ------------ %%
figure(3),
box on,
hold on,
grid on,
set(gca,'fontsize',14, 'linewidth', 1.2)
plot(datasets',error1_wang(:,1), 'r','linewidth',1.5);
plot(datasets',error1_dq(:,1), 'g','linewidth',1.5);
plot(datasets',error1_lmi(:,1),'b','linewidth',1.5);
plot(datasets',error1_wang(:,2), 'r-o','linewidth',1.5);
plot(datasets',error1_dq(:,2), 'g-o','linewidth',1.5);
plot(datasets',error1_lmi(:,2),'b-o','linewidth',1.5);
xlabel('Number of simulation data pair')
ylabel('Rotational errors of X and Y')
legend({'Iterative method for X','DQ-based method for X','Proposed method for X','Iterative method for Y','DQ-based method for Y','Proposed method for Y'},'Location','northeast')

figure(4),
box on,
hold on,
grid on,
set(gca,'fontsize',14, 'linewidth', 1.2)
plot(datasets',error1_wang(:,3), 'r','linewidth',1.5);
plot(datasets',error1_dq(:,3), 'g','linewidth',1.5);
plot(datasets',error1_lmi(:,3),'b','linewidth',1.5);
plot(datasets',error1_wang(:,4), 'r-o','linewidth',1.5);
plot(datasets',error1_dq(:,4), 'g-o','linewidth',1.5);
plot(datasets',error1_lmi(:,4),'b-o','linewidth',1.5);
xlabel('Number of simulation data pair')
ylabel('Translational errors of X and Y')
legend({'Iterative method for X','DQ-based method for X','Proposed method for X','Iterative method for Y','DQ-based method for Y','Proposed method for Y'},'Location','northeast')
hold off;

