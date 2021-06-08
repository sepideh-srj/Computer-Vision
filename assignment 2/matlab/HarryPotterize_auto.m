%Q2.2.4
clear all;
close all;

cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');
hp_img = imread('../data/hp_cover.jpg');

%% Extract features and match
[locs1, locs2] = matchPics(cv_img, desk_img);

%% Compute homography using RANSAC
[bestH2to1, ~] = computeH_ransac(locs1, locs2);

%% Scale harry potter image to template size
% Why is this is important?
scaled_hp_img = imresize(hp_img, [size(cv_img,1) size(cv_img,2)]);
% figure(1)

%% Display warped image.
% imshow(warpH(scaled_hp_img, inv(bestH2to1), size(desk_img)));

%% Display composite image
img = compositeH(inv(bestH2to1), scaled_hp_img, desk_img);
figure()
imshow(img)
% template = scaled_hp_img;

% img = desk_img;
% 
% 
% %% Create mask of same size as template
% [h,w,d] = size(template);
% 
% mask = zeros(h,w,d);
% %% Warp mask by appropriate homography
% mask =warpH(mask, inv(bestH2to1), size(img),1);
% mask = uint8(mask);
% imshow(mask)
% %% Warp template by appropriate homography
% template =warpH(template, inv(bestH2to1), size(img));
% 
% %% Use mask to combine the warped template and the image
% image = img .* mask;
% image = image + template;
% imshow(image)