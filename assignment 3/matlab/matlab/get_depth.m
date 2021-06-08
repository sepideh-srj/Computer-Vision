function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
% im1 = imread('../data/im1.png');
% im2 = imread('../data/im2.png');
% im1 = rgb2gray(im1);
% im2 = rgb2gray(im2);
% load('rectify.mat', 'M1', 'M2', 'K1n', 'K2n', 'R1n', 'R2n', 't1n', 't2n');
% K1 = K1n;
% K2 = K2n;
% R1 = R1n;
% R2 = R2n;
% 
% t1 = t1n;
% t2 = t2n;

c1 = -(K1 * R1)\(K1 * t1);
c2 = -(K2 * R2)\(K2 * t2);
b = (c1(1) - c2(1))^2 + (c1(2) - c2(2))^2 + (c1(3) - c2(3))^2;

f = K1(1,1);

depthM(:,:) = b* f ./(dispM(:,:) + 0.0001);

end