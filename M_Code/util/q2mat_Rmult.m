function q_mat=q2mat_Rmult(Q)
% q2mat_Rmult(Q) calculate the right matrix form of quaternion Q.

  q0=Q(1);
  q_vec=Q(2:4);
  
  q_mat=[q0, -q_vec';
         q_vec, q0*eye(3)-skew(q_vec)];
end