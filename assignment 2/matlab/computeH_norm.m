function [H2to1] = computeH_norm(x1, x2)
% clear;
% I1 = imread('cv_cover.jpg');
% I2 = imread('cv_desk.png');
%  if (ndims(I1) == 3)
%         I1 = rgb2gray(I1);
%  end
%  
%   if (ndims(I2) == 3)
%         I2 = rgb2gray(I2);
%  end
% corners1 = detectFASTFeatures(I1);
% corners2 = detectFASTFeatures(I2);
% 
% 
% [desc1, locs1] = computeBrief(I1, corners1.Location);
% [desc2, locs2] = computeBrief(I2, corners2.Location);
% 
% threshold = 10;
% 
% indexPairs = matchFeatures(desc1,desc2,'MatchThreshold', threshold, 'MaxRatio', 0.7);
% x1 = locs1(indexPairs(:,1),:);
% x2 = locs2(indexPairs(:,2),:);

x1temp = x1;
x2temp = x2;
%% Compute centroids of the points
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid
shift1 = [1 0 -centroid1(1); 0 1 -centroid1(2); 0 0 1];
shift2 = [1 0 -centroid2(1); 0 1 -centroid2(2); 0 0 1];
[num, ~] = size(x1);
for i= 1:num
    temp = shift1 * [x1(i,1); x1(i,2) ;1];
    x1temp(i,1) = temp(1);
    x1temp(i,2) = temp(2);
end
for i= 1:num
    temp = shift2 * [x2(i,1); x2(i,2) ;1];
    x2temp(i,1) = temp(1);
    x2temp(i,2) = temp(2);
end
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
distance1 = 0;
for i =1:num
    distance1 = distance1 + x1temp(i,1)^2 + x1temp(i,2)^2;
end
% avgDistance1 = distance/2*num;
% s1 = sqrt(2)/avgDistance1;
% 
distance2 = 0;
for i =1:num
    distance2 = distance2 + (x2temp(i,1)^2 + x2temp(i,2)^2);
end
% avgDistance2 = distance/2*num;
% s2 = sqrt(2)/avgDistance2;

s1 = sqrt(1/(2*num)*(distance1)); 
s2 = sqrt(1/(2*num)*(distance2)); 

%% similarity transform 1
T1 = [1/s1, 0, -centroid1(1)/s1; 0, 1/s1, -centroid1(2)/s1; 0, 0, 1];
[num, ~] = size(x1);
x1prim = zeros(num,3);
for i= 1:num
    temp = T1 * [x1(i,1); x1(i,2) ;1];
    x1prim(i,1) = temp(1);
    x1prim(i,2) = temp(2);
end


%% similarity transform 2
T2 = [1/s2, 0, -centroid2(1)/2; 0, 1/s2, -centroid2(2)/s2; 0, 0, 1];
x2prim = zeros(num,3);
for i= 1:num
    temp = T2 * [x2(i,1); x2(i,2) ;1];
    x2prim(i,1) = temp(1);
    x2prim(i,2) = temp(2);
end
%% Compute Homography
H2to1 = computeH(x1prim,x2prim);


%% Denormalization
H2to1 = inv(T1) * H2to1 * T2;
% targets = zeros(num,2);
% for i=1:num
%     t = H2to1*[x2(i,1); x2(i,2); 1];
%     x = t(1)/t(3);
%     y = t(2)/t(3);
%     targets(i,:)= [x,y];
%     
% end
% 
% showMatchedFeatures(I1, I2, targets, x2, 'montage') 

