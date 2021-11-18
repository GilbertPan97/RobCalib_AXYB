function camera_HTM = camera_Calibrator(imgsPath, nbrImgs, squareSize)
% Calibrator is a function to obtain HTM from camera frame {C} to world(chessboard) {W} frame
%   Input:  
%       imgsPath(string): the path of the camera to collect images (image with suffix .jpg)
%       nbrImgs: the number of chessboard images
%       squareSize: square size of the calibration board (mm)
%   Output:
%       camera_HTM: the HTM of chessboard frame {W} relative to camera frame {C}
% Note: camera_HTM is not equal to matrix B, represent the inverse of B
    
    %% Define images to process
    imageFileNames = cell(1, nbrImgs);
    for i = 1: nbrImgs
        imageFileNames{i} = [imgsPath, num2str(i), '.bmp'];
    end

    % Detect checkerboards in images
    [imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);

    % Generate world coordinates of the checkerboard keypoints
    % squareSize = 10;  % in units of 'millimeters'
    worldPoints = generateCheckerboardPoints(boardSize, squareSize);

    % Read the first image to obtain image size
    originalImage = imread(imageFileNames{1});
    [mrows, ncols, ~] = size(originalImage);

    %% Calibrate the camera
    [cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
        'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
        'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
        'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
        'ImageSize', [mrows, ncols]);

    % % View reprojection errors
    % h1=figure; showReprojectionErrors(stereoParams);

    % Visualize pattern locations
    h2 = figure; showExtrinsics(cameraParams, 'CameraCentric');

    % % Display parameter estimation errors
    % displayErrors(estimationErrors, stereoParams);
    
    %% generate the HTM
    camera_HTM = zeros(4,4,nbrImgs);
    for i = 1:nbrImgs
        R_cam = cameraParams.RotationMatrices(:,:,i);
        t_cam = cameraParams.TranslationVectors(i,:);
        camera_HTM(:,:,i) = [R_cam', t_cam'; zeros(1,3), 1];
    end
    
    %% plot frame {C} and calibrate board frame {W}
    figure(2)
    HTM_Cam = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    trplot(HTM_Cam, 'frame', 'C', 'length', 20);
    for i = 1:nbrImgs
       hold on
       trplot(HTM_Cam*camera_HTM(:,:,i),'length', 15, 'rviz');
    end
    axis auto
end

