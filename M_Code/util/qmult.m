function q_out=qmult(q1,q2)
% QMULT(Q1,Q2) calculates the product of two 4¡Á1 quaternions Q1 and Q2.
   q_s=q1(1)*q2(1)-q1(2:4)'*q2(2:4);
   q_v=q1(1)*q2(2:4)+q2(1)*q1(2:4)+cross(q1(2:4),q2(2:4));
   q_out=[q_s;q_v];
end


