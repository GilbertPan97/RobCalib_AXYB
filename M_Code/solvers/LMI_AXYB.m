function [Hx_correct, Hy_correct] = LMI_AXYB(A, B)
% Solves the problem AX = YB, proposed method.
%   This function is used to generate calibration input data,
%   which will be utilized to solve AX=YB via python calibrator
%
%   Input: A, B are 4 x 4 x n homogeneous matrices
%   Output: X, Y are 4 x 4 homogeneous matrices
%
%   Jiabin Pan
%   Aug, 2021

    %% Calibration data generate for python calibrator
    t0 = clock;
    fprintf('Running LMI method...\n');
    n = size(A, 3);    % size of data
    for i = 1:n
        Ra = A(1:3,1:3,i);
        Rb = B(1:3,1:3,i);
        ta = A(1:3,4,i);
        tb = B(1:3,4,i);
        Hi = [kron(Ra, Rb),            -eye(9),   zeros(9,3), zeros(9,3);
                zeros(3,9),  kron(eye(3), tb'),          -Ra,     eye(3)];
        ome_i = [zeros(9,1); ta];
        
        H(12*i-11:12*i, 1:24) = Hi;
        omega(12*i-11:12*i, 1) = ome_i;
    end
    
    [Q, R] = qr(H);
    Q1 = Q(:,1:24);
    Q2 = Q(:,25:end);
    R1 = R(1:24,:);
    
    rho1 = Q1'*omega;
    rho2 = Q2'*omega;
    
    t1 = clock;

    %% save data in a temporary folder, and execute calibrator
    save ./tmp_Data/calibInput.mat rho1 rho2 R1
    
    t2 = clock;
    gotoPath = 'cd ..';
    execommand = 'venv/bin/python AXYB_Calibrator.py';
    status = system([ gotoPath ' && ' execommand]);
    
    if status ~= 0
        error('Error! Python calibrator call failed.')
    end
    t3 = clock;
    
    load tmp_Data/solution.mat
    
    %% Applied Schmidt orthogonalization for correct solution
    t4 = clock;
    Rx = Hx(1:3, 1:3);  tx = Hx(1:3, 4);
    Ry = Hy(1:3, 1:3);  ty = Hy(1:3, 4);
    
    Rx_ortho = Schmidt_orthogonalization(Rx);
    Ry_ortho = Schmidt_orthogonalization(Ry);
    
    Hx_correct = [Rx_ortho, tx; zeros(1,3), 1];
    Hy_correct = [Ry_ortho, ty; zeros(1,3), 1];
    
    t5 = clock;
    
    run_time = etime(t1, t0)+etime(t3, t2)+etime(t5, t4)
end






