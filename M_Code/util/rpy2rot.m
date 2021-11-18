function R_mat = rpy2rot( alpha, beta, gama )

    ca=cos(alpha);sa=sin(alpha);
    cb=cos(beta); sb=sin(beta);
    cg=cos(gama); sg=sin(gama);

    R_mat=[ca*cb, ca*sb*sg-sa*cg, ca*sb*cg+sa*sg;
           sa*cb, sa*sb*sg+ca*cg, sa*sb*cg-ca*sg;
             -sb,          cb*sg,          cb*cg];
end

