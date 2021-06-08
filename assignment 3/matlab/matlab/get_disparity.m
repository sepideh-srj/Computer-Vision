function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
% im1 = imread('../data/im1.png');
% im2 = imread('../data/im2.png');
% im1 = rgb2gray(im1);
% im2 = rgb2gray(im2);
% load('rectify.mat', 'M1', 'M2', 'K1n', 'K2n', 'R1n', 'R2n', 't1n', 't2n');
windowSize = 5;
maxDisp = 20;
[width,height] = size(im1);
w = (windowSize-1)/2 ;
dispM=zeros(size(im1,1),size(im1,2)) ;
values=zeros(size(im1,1),size(im1,2)) ;
mask = ones(w,w);

for i = 1+windowSize : width - windowSize
    for j = 1 + windowSize + maxDisp : height - windowSize - maxDisp
        values(i,j) = inf;
        for d = 1:maxDisp
            dist = double(im1(i-windowSize:i+windowSize, j-windowSize:j+windowSize) - im2(i-windowSize:i+windowSize, j-windowSize-d:j+windowSize-d));
            dist = conv2(dist,mask);
            dist = dist(1).^2 + dist(2).^2;
            if (values(i,j) > dist)
                values(i,j) = dist;
                dispM(i,j) = d;
            end
            
        end
    end
end
end
