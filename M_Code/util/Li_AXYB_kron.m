%% implements the Kronecker product method in Li et al (2010) paper
function [X, Y] = Li_AXYB_kron( A, B )

num = size(A, 3); % number of measurements

RA = A(1:3, 1:3, :); % 3x3xnum
RB = B(1:3, 1:3, :);
TA = A(1:3, 4, :);  % 3x1xnum
TB = B(1:3, 4, :);

K = zeros(12*num, 24);
t = zeros(12*num, 1);
for i = 1:num
  K( (i-1)*12+1:(i-1)*12+9, 1:9 ) = kron( RA(:,:,i), eye(3) );
  K( (i-1)*12+1:(i-1)*12+9, 10:18 ) = -kron( eye(3), RB(:,:,i)' );
  K( (i-1)*12+10:i*12, 10:18 ) = kron(eye(3), TB(:,:,i)' );
  K( (i-1)*12+10:i*12, 19:21 ) = -RA(:,:,i);
  K( (i-1)*12+10:i*12, 22:24 ) = eye(3);
  t( (i-1)*12+10:i*12 ) = TA(:,:,i);
end

% solve Kv = t using least squares
v = pinv(K) * t; % 24x1

X = zeros(4,4); X(4,4) = 1;
Y = zeros(4,4); Y(4,4) = 1;

% reform the X, Y homogeneous matrices from the vectorized versions
X(1:3,1:3) = reshape(v(1:9), 3, 3)'; %need transpose because reshape goes down col first then row
Y(1:3,1:3) = reshape(v(10:18), 3, 3)';
X(1:3, 4) = reshape(v(19:21), 3, 1);
Y(1:3, 4) = reshape(v(22:24), 3, 1);
end