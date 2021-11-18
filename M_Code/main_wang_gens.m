
clc
clear;

%% Set the true value of X Y
opt_XY = 2;     % generate the given true value of X, Y
[XActual, YActual] = InitializeXY(opt_XY);

%% Datasets generation(using the same datasets to calibrate in different generations)
optPDF = 3;     % option for generating data using distributions 3
nbr = 50;       % number of datasets
gmean = [0; 0; 0; 0; 0 ;0];
coeff = 0;
cov = eye(6,6); % coeff1*cov
optPlot = 'lineplot'; % Plot the averaged error : 'lineplot' & ''boxplot'
opt_XY = 2;     % generate random X, Y
[A, B] =  generateAB_random(nbr, optPDF, gmean, coeff*cov, XActual, YActual);

%% Get rotation and translation components of A, B, C
RA = A(1:3, 1:3, :);    % 3x3xnum
RB = B(1:3, 1:3, :);
TA = A(1:3, 4, :);      % 3x1xnum
TB = B(1:3, 4, :);

%% Initial parameters
gens_step = 1;      % the step of generations(Iteration)
gens_max = 20;    % the maximun of generations(Iteration)
cnt = 0;

for gens = 0:gens_step:gens_max
    
    cnt = cnt+1;
    %% ============ Solve for RX, RY first ==============
    % Set initial guess of RX, RY by first set data
    e = pi;
    RX_init = expm( so3_vec(e*ones(3,1)) ); % set the same initial value in different loop
    RY_init = RA(:,:,1)*RX_init/RB(:,:,1);

    % Iterate until norm of delR = [delRX; delRY; delRZ] falls below a predefined threshold
    delR = 10000 * ones(9,1);  % use a large value initially 

    n_step = 0;

    while (n_step < gens)

      q = zeros(9, 1, nbr); % q_tilde in paper
      F = zeros(9, 6, nbr); % F_tilde in paper

      for i = 1:nbr
        qq = RY_init*RB(:,:,i)-RA(:,:,i)*RX_init;
        q(:,:,i) = [qq(:,1); qq(:,2); qq(:,3)];     % qi = 9x1

        F11 = -RA(:,:,i)*so3_vec(RX_init(:,1));     % 3x3
        F21 = -RA(:,:,i)*so3_vec(RX_init(:,2));
        F31 = -RA(:,:,i)*so3_vec(RX_init(:,3));

        tmp = RY_init*RB(:,:,i);
        F12 = so3_vec(tmp(:,1));
        F22 = so3_vec(tmp(:,2));
        F32 = so3_vec(tmp(:,3));

        F(:,:,i) = [ F11 F12; F21 F22; F31 F32];    % Fi = 9x6
      end

      % stack calibration datasets, reshape F and q
      F = stack_in_rows(F);
      q = stack_in_rows(q);

      delR = (F'*F)\F'*q;  % solve for delta_Rx and delta_Ry

      % Iterative update initial value of Rx and Ry by delta_R
      thetaX = norm( delR(1:3) );
      RX_init = skewexp( delR(1:3)/thetaX, thetaX ) * RX_init;

      thetaY = norm( delR(4:6) );
      RY_init = skewexp( delR(4:6)/thetaY, thetaY ) * RY_init;

      n_step = n_step + 1;
    end

    %% ============ Solve for TX, TY next ==============
    J = zeros(3, 6, nbr); % J_tilde
    p = zeros(3, 1, nbr); % p_tilde

    for i = 1:nbr
      J(:,:,i) = [ RA(:,:,i)  -eye(3)];
      p(:,:,i) = RY_init*TB(:,:,i)-TA(:,:,i);
    end

    % stack calibration datasets, reshape J and p
    J = stack_in_rows(J);
    p = stack_in_rows(p);

    t_vec = (J'*J)\J'*p;
    tX = t_vec(1:3);
    tY = t_vec(4:6);

    %% Form the homogeneous matrices for X, Y
    X = zeros(4); Y = zeros(4);
    X(4,4) = 1;   Y(4,4) = 1;
    X(1:3,1:3) = RX_init;   X(1:3,4) = tX;
    Y(1:3,1:3) = RY_init;   Y(1:3,4) = tY;
    
    %% Gen error of wang method in different generations
    Err_wang(cnt,:) = getErrorAXYB(X, Y, XActual, YActual);
end

%% -----------  Simulation visualization  ------------- %%
label = {'E_{R_{X}}(rad)', 'E_{R_{Y}}(rad)', 'E_{t_{X}}(mm)', 'E_{t_{Y}}(mm)'};
iters = 0:gens_step:gens_max;
save ./sim_solutions/wang_iter.mat Err_wang iters

figure
subplot(221)
semilogy(iters, Err_wang(:,1), 'k-d', iters, Err_wang(:,2), 'b-o','linewidth',1.15)
set(gca,'fontsize',14)
xlabel('Iteration');
ylabel('Rotation error of wang method.');
legend(label{1}, label{2});
axis auto

subplot(222)
semilogy(iters, Err_wang(:,3), 'k-d', iters, Err_wang(:,4),'b-o','linewidth',1.15)
set(gca,'fontsize',14)
xlabel('Iteration');
ylabel('Translation error of wang method.');
legend(label{3}, label{4});
axis auto



