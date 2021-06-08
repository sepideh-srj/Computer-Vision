function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
% 
% im1 = imread('data/im1.png');
% im2 = imread('data/im2.png');
% data = load('../data/someCorresp.mat');
% F = eightpoint(data.pts1, data.pts2, data.M);
% pts1 = data.pts1;   
[s,~] = size(pts1);
pts2 = zeros(s,2);




Ls = F * [pts1'; ones(1,s)];
Ls = Ls'
window=5;
bound = 25;
pts1 = round(pts1);
im1 = double(im1);
im2 = double(im2);
im1 = imgaussfilt(im1);
 for i=1:s
     
    x = (pts1(i,1)-bound:pts1(i,1)+bound) ;
    a = Ls(i,1);
    b = Ls(i,2);
    c = Ls(i,3);
    y= (-a*x  - c)/b ;
    y = round(y);
    finalError = inf;
    toCheck1 = im1( pts1(i,1)-window:pts1(i,1)+window, pts1(i,2)-window:pts1(i,2)+window ) ;
    for j=1:size(x,2)
        toCheck2= im2(x(j)-window:x(j)+window,round(y(j))-window:round(y(j))+window) ;
        toCheck2 = imgaussfilt(toCheck2);
        
        error= sum(sqrt((toCheck1(:,1)-toCheck2(:,1)).^2 + (toCheck1(:,2)-toCheck2(:,2)).^2)); 
        
        if (error < finalError)
            finalError = error;
            pts2(i,1) = x(j);
            pts2(i,2) = y(j);
        end
    end
 end

end
