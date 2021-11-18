function [X, Y, n_step] = Wang_AXYB(A, B)
% Implements the algorithm in Wang et al (2014)
%   Solves for X, Y in the matrix equation AX=YB given A, B
%
%   Input: A, B are 4 x 4 x n homogeneous matrices
%   Output: X, Y are 4 x 4 homogeneous matrices
%
%   Jiabin Pan 
%   Aug, 2021

    t_start = clock;
    nbr = size(A, 3);   % number of datasets
    fprintf('Running Wang method...\n');

    %% Get rotation and translation components of A, B, C
    RA = A(1:3, 1:3, :);    % 3x3xnum
    RB = B(1:3, 1:3, :);
    TA = A(1:3, 4, :);      % 3x1xnum
    TB = B(1:3, 4, :);


    %% ============ Solve for RX, RY first ==============
    % Set initial guess of RX, RY
    e = pi;
    RX_init = expm( so3_vec(e*ones(3,1)) );
    RY_init = RA(:,:,1)*RX_init/RB(:,:,1);

    % Iterate until norm of delR = [delRX; delRY; delRZ] falls below a predefined threshold
    delR = 10000 * ones(9,1);  % use a large value initially 

    n_step = 0;

    while (norm(delR) > .001 && n_step < 1000 )

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
    t_end = clock;
    
    run_time = etime(t_end, t_start)
    
end

