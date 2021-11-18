 function [X, Y] = DQ_AXYB(A, B, Xtrue, Ytrue)
% Implements the algorithm in Fu et al (2020)
%   Solves for X, Y in the matrix equation AX=YB given A, B
%
%   Input: A, B are 4 x 4 x n homogeneous matrices
%   Output: X, Y are 4 x 4 homogeneous matrices
%  
%   Zhongtao Fu
%   July, 2020
    
    t_start = clock;
    fprintf('Running DQ-based method...\n');
    
    nbr = size(A,3);    % number of datasets   
    
    %% construct linear equation
    H = [];
    for i = 1:nbr
        A_hm = A(:,:,i);
        B_hm = B(:,:,i);

        % Dual quaternion
        A_dq = hom2dq(A_hm);
        B_dq = hom2dq(B_hm);
        
        Xa_dq = hom2dq(Xtrue);
        Ya_dq = hom2dq(Ytrue);

        deltaQ1 = dqmult(A_dq,Xa_dq) - dqmult(Ya_dq,B_dq);
        deltaQ2 = dqmult(-A_dq,Xa_dq) - dqmult(Ya_dq,B_dq);
        
        if(norm(deltaQ1(:,2))<norm(deltaQ2(:,2)))
            deltaQ = deltaQ1;
        else
            A_dq = -A_dq;
            deltaQ = deltaQ2;
        end

        D = [q2mat_Lmult(A_dq(1:4,1)),                zeros(4,4), q2mat_Rmult(B_dq(1:4,1)),               zeros(4,4);
             q2mat_Lmult(A_dq(1:4,2)),  q2mat_Lmult(A_dq(1:4,1)), q2mat_Rmult(B_dq(1:4,2)), q2mat_Rmult(B_dq(1:4,1))];

        % construct H matrix
        H = [H;D];
    end

    % H*[qz;qzprime;qy;qyprime]=0, SVD
    [U,S,V] = svd(H);
    rank(H);

    %solution: mu1*v15+mu2*v16  null vectors of H
    v15 = V(:,15);
    w_11 = v15(1:4); w_12 = v15(5:8); w_13 = v15(9:12);  w_14 = v15(13:16);
    v16 = V(:,16);
    w_21 = v16(1:4); w_22 = v16(5:8); w_23 = v16(9:12);  w_24 = v16(13:16);

    flag = 1;
    if (flag ==1)
        w_11 = w_13;
        w_12 = w_14;
        w_21 = w_23;
        w_22 = w_24;
    end 
    a = w_11'*w_12;
    b = w_11'*w_22+w_21'*w_12;
    c = w_21'*w_22 ;
    s1 = (-b+sqrt(b^2-4*a*c))/(2*a);
    s2 = (-b-sqrt(b^2-4*a*c))/(2*a);
    s  = [s1; s2];

    % Find the maximum root
    [val,in] = max(s.^2*(w_11'*w_11) + 2*s*(w_11'*w_21) + w_21'*w_21);
    s = s(in);
    mu2 = sqrt(1/val);
    mu1 = s*mu2;

    deta = mu1*v15+mu2*v16;
    X_dq = [deta(1:4),deta(5:8)];
    Y_dq = [deta(9:12),deta(13:16)];

    X = dq2hom(X_dq);
    Y = dq2hom(Y_dq);
    
    err = getErrorAXYB(X, Y, Xtrue, Ytrue);
    if isreal(X) && isreal(X)
        fprintf('DQ based solution is found.\n');
        
        if norm(err) > 300
            fprintf('The false solution is:\n'); 
            display(X); display(Y)
            fprintf('The true solution is:\n'); 
            display(Xtrue); display(Ytrue)
            pause
        end
        
    else   
        error('DQ based method return false solution.');
    end
    t_end = clock;
    
    run_time = etime(t_end, t_start)
end