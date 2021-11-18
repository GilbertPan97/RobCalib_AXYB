function [X, Y] = InitializeXY(opt)
% Generate one triple of [X, Y] as the ground truth
    if opt == 1
        
        x = randn(6,1); x = x./norm(x); X = expm(se3_vec(x));    % Generate a Random X
        y = randn(6,1); y = y./norm(y); Y = expm(se3_vec(y));    % Generate a Random Y

    elseif opt == 2
        
        X =[ 0.0162    0.9995    0.0289  -33.9684;
            -0.9996    0.0168   -0.0207    2.6628;
            -0.0211   -0.0285    0.9994   -4.7191;
                  0         0         0    1.0000];

        Y = [-0.99908 -0.03266  0.02786  165;
              0.02737  0.01553  0.99950  300;
             -0.03308  0.99935 -0.01462 -662;
              0.00000  0.00000  0.00000  1.00000;];
          
    elseif opt == 2.1
          
        X = [0.7384   -0.6744   -0.0051   259;
             0.6742    0.7383   -0.0188  -266;
             0.0164    0.0104    0.9998   227;
                  0         0         0    1];
              
        Y = [-0.0949   -0.8690    0.4856  223;
             -0.9955    0.0858   -0.0410  217;
             -0.0060   -0.4873   -0.8732 -221;
                   0         0         0   1];

    elseif opt == 3

        X(1:3,1:3) = rotx(pi/3)*rotz(pi/4);
        Y(1:3,1:3) = rotz(pi/4)*roty(pi/6);

    else
        
        fprintf('The given opt = %d is not an option. \n', opt);
        return
        
    end   
end
