function [ H2to1 ] = computeH( x1, x2 )

%COMPUTEH Computes the homography between two sets of points
set1 = x1;
set2 = x2;

[num, ~] = size(set1);
A = zeros(2*num, 9);
for i=1:num
        Row1 = [set2(i,1) set2(i,2) 1 0 0 0 -set2(i,1)*set1(i,1) -set2(i,2)*set1(i,1) -set1(i,1)];
        A(i*2-1,:)= Row1;
        Row2 = [ 0 0 0 set2(i,1) set2(i,2) 1 -set2(i,1)*set1(i,2) -set2(i,2)*set1(i,2) -set1(i,2)];
        A(i*2,:)= Row2;
end

[U,sum, V] = svd(A);
H2to1 = (reshape(V(:,end), 3, 3)).';
% targets = zeros(num,2);
% for i=1:num
%     t = H2to1*[set2(i,1); set2(i,2); 1];
%     x = t(1)/t(3);
%     y = t(2)/t(3);
%     targets(i,:)= [x,y];
%     
% end

% for i=1:num
%     r = randi(length(targets));
%     point1(i) = targets(r);
%     point2(i) = set2(r);
%     
% end

% showMatchedFeatures(I1, I2, targets, locs2, 'montage') 


end
