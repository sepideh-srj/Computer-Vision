function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!
% I11 = imread('cv_cover.jpg');
% I22 = imread('cv_desk.png');
%% Convert images to grayscale, if necessary
 if (ndims(I1) == 3)
        I1 = rgb2gray(I1);
 end
 
  if (ndims(I2) == 3)
        I2 = rgb2gray(I2);
 end
%% Detect features in both images
corners1 = detectFASTFeatures(I1);
corners2 = detectFASTFeatures(I2);

%% Obtain descriptors for the computed feature locations

[desc1, locs1] = computeBrief(I1, corners1.Location);
[desc2, locs2] = computeBrief(I2, corners2.Location);

%% Match features using the descriptors
threshold = 10;

indexPairs = matchFeatures(desc1,desc2,'MatchThreshold', threshold, 'MaxRatio', 0.7);
locs1 = locs1(indexPairs(:,1),:);
locs2 = locs2(indexPairs(:,2),:);
% showMatchedFeatures(I11, I22, locs1, locs2, 'montage') 
end

