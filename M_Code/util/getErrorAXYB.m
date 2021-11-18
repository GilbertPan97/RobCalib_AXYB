function xyzError = getErrorAXYB(X_f, Y_f, XActual, YActual)
% Compute the rotational and translational errors for X, Y 

    xyzError(1) = roterror(X_f, XActual);
    xyzError(2) = roterror(Y_f, YActual);
    
    xyzError(3) = tranerror(X_f, XActual);
    xyzError(4) = tranerror(Y_f, YActual);

end