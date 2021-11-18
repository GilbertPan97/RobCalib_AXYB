function dq = hom2dq(H)
% Converts 4x4 homogeneous matrix H to a dual quaternion dq represented as dq(:,1) + epslion*dq(:,2)
    R = H(1:3,1:3);
    t = H(1:3,4);
    
%     r = rodrigues(R);  %Rodrigues formula: logm
%     theta = norm(r);
%     l = r/norm(theta);
%     q = [cos(theta/2); sin(theta/2)*l];
    q = rot2q(R);
    qprime = 1/2*qmult([0;t],q);
    
    dq=[q, qprime];
end
