function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]
% Script for testing Pose Estimation part in the project 5
%
% Chen Kong.

% Random generate camera matrix
% K = [1,0,1e2;0,1,1e2;0,0,1];
% 
% [R, ~, ~] = svd(randn(3));
% t = randn(3, 1);
% 
% P = K*[R, t];
% 
% % Random generate 2D and 3D points
% N = 10;
% X = randn(3, N);
% x = P*[X; ones(1, N)];
% x(1, :) = x(1, :)./x(3, :);
% x(2, :) = x(2, :)./x(3, :);
% x = x(1:2, :);

n = size(x,2);

A = zeros(n*2,12);

for i=1:n
    a1 = [X(1,i) X(2,i) X(3,i) 1 0 0 0 0 -x(1,i)* X(1,i) -x(2,i)* X(1,i) -x(1,i)* X(3,i) -x(1,i)];
    a2 =  [0 0 0 0 X(1,i) X(2,i) X(3,i) 1 -x(2,i)* X(1,i) -x(2,i)* X(2,i) -x(2,i)* X(3,i) x(2,i)];
    A(2*i-1,:) = a1; 
    A(i*2,:) = a2;
end


[u,s,v] = svd(A);
P = v(:,9);
P = reshape(P,4,3)';
end
