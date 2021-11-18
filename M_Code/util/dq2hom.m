function H = dq2hom(dq)
% Converts dual quaternion dq represented as dq(:,1) + epslion*dq(:,2) to a 4¡Á4 homogeneous matrix H
    q = dq(:,1); qe = dq(:,2);

    R = [    1-2*(q(3)^2+q(4)^2),  2*(q(2)*q(3)-q(1)*q(4)), 2*(q(2)*q(4)+q(1)*q(3));
         2*(q(1)*q(4)+q(2)*q(3)),      1-2*(q(2)^2+q(4)^2), 2*(q(3)*q(4)-q(1)*q(2));
         2*(q(2)*q(4)-q(1)*q(3)),  2*(q(1)*q(2)+q(3)*q(4)),    1-2*(q(2)^2+q(3)^2)];

    q_conj = [q(1);-q(2:4)];
    t = 2*qmult(qe,q_conj);

    H = [R, t(2:4); 
         0,0,0,1];
end