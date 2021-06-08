function [points] = getHarrisPoints(I, alpha, k)
% k = 0.05;
% alpha = 150;
%     I = imread('../data/campus/sun_albthhletanyjwjn.jpg');


if (size(I,3) == 3)
        Ig = rgb2gray(I);
else
    Ig = I;
end
% 
% % I = double(I);
% % h = fspecial('gaussian');
% % smoothed = conv2(I ,h,'same');
% % 
% % Gx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
% % Gy = Gx';
% % imgx = conv2(smoothed, Gx, 'same');
% % imgy = conv2(smoothed, Gy, 'same');
% 
[imgx,imgy] = imgradientxy(Ig);

Ixx = imgx .* imgx;
Ixy = imgx .* imgy;
Iyy = imgy .* imgy;

w = ones(5,5);
M1 = imfilter(Ixx,w);
M2 = imfilter(Ixy,w);
M3 = M2;
M4 = imfilter(Iyy,w);

M = [M1, M2; M3, M4];
detM = M1 .* M4 - M3 .* M2;

traceM = M1 + M4;
R = detM - k* traceM.^2;
R(R<0) = 0;

maxRegion = imregionalmax(R, 8);
R=R.*maxRegion;

[~,indices]=maxk(R(:), alpha);
[row, col]=ind2sub(size(Ig),indices);
points=[row,col];

% imshow(I)
% hold on
% plot(points(:,2), points(:,1), 'r*')
% 
% 
% hold off

end