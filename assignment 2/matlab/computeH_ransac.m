function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

threshold = 10;

[num, ~] = size(locs1);
x1 = zeros(4,2);
x2 = zeros(4,2);
cnt = 1;
maxInliers = 0;
bestX1 = zeros(4,2);
bestX2 = zeros(4,2);
while(cnt < 200)
inliers =0;
n= 1;
while (n<5)
    toTest = locs1;
    r = rand;
    randomIndex = ceil(r*num);
    if (toTest(randomIndex) ~= -1)
        x1(n,:) = locs1(randomIndex,:);
        x2(n,:) = locs2(randomIndex,:);
        n = n+1;
        toTest(randomIndex) = -1;
    end  
end
   H2to1=computeH_norm(x1,x2);
   
   targets = zeros(num,2);
   for i=1:num
        t = H2to1*[locs2(i,1); locs2(i,2); 1];
        x = t(1)/t(3);
        y = t(2)/t(3);
        targets(i,:)= [x,y];
   end
   threshold = 15;
   for i=1:num
       if ( sqrt((targets(i,1) - locs1(i,1))^2 + (targets(i,2) - locs1(i,2))^2) < threshold)
           inliers = inliers+1;
       end
   end
   if (inliers > maxInliers)
       maxInliers = inliers;
       bestH2to1 = H2to1;
       bestX1 = x1;
       bestX2 = x2;
   end
   cnt = cnt+1;
end  
%   for i=1:num
%         t = bestH2to1*[locs2(i,1); locs2(i,2); 1];
%         x = t(1)/t(3);
%         y = t(2)/t(3);
%         targets(i,:)= [x,y];
%   end
%   figure()
% showMatchedFeatures(I1, I2, bestX1, bestX2, 'montage') 
%    figure()
% showMatchedFeatures(I1, I2, targets, locs2, 'montage') 

end

