function HTM = xyzwpr2HTM(Mat_pose)
% xyzwpr2HTM 
%   Input:
%       Matpose:
%   Output:
%       HTM: 
    
    nbr = size(Mat_pose, 1);
    HTM = zeros(4,4,nbr);
    
    for i = 1:nbr
        Vec_pose = Mat_pose(i,:);
        HTM(:,:,i) = [rpy2r(Vec_pose(4:6),'deg','zyx') Vec_pose(1:3)';
                      0 0 0 1];
    end
end

