 function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m
% Load image and paramters
% im1 = imread('data/im1.png');
% im2 = imread('data/im2.png');
% im1 = rgb2gray(im1);
% im2 = rgb2gray(im2);
% 
% load('data/intrinsics.mat', 'K1', 'K2');
% 
% load('data/extrinsics.mat', 'R1', 'R2', 't1', 't2');
c1 = -(K1 * R1)\(K1 * t1);
c2 = -(K2 * R2)\(K2 * t2);
dist = (c1(1) - c2(1))^2 + (c1(2) - c2(2))^2 + (c1(3) - c2(3))^2;
r1 = (c1 - c2)/ dist;
r2 = (cross(R1(3,:) , r1))';
r3 = cross(r1,  r2);

R = [r1 r2 r3] ;

t1n = -R' * c1;
t2n = -R' * c2;

M1 = K2* R * inv(K1*R1);
M2 = K2 * R * inv(K2*R2);

R1n = R';
R2n = R';

K1n = K2;
K2n = K2;

 end
