function ds = dqmult(dq,dr)
%  DQMULT Dual quaternion multiplication
    ds0 = qmult(dq(1:4,1),dr(1:4,1));
    ds1 = qmult(dq(1:4,1),dr(1:4,2))+qmult(dq(1:4,2),dr(1:4,1));
    ds = [ds0 , ds1];
end
    

