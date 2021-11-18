function q_mat=q2mat_Lmult(Q)
% q2mat_Lmult(Q) calculate the left matrix form of quaternion Q.

  p0=Q(1);
  p_vec=Q(2:4);
  
  q_mat=[p0, -p_vec';
         p_vec, p0*eye(3)+skew(p_vec)];
end