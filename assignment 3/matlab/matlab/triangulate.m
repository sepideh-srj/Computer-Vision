function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
s = size(pts1,1);
pts3d = zeros(s,3);
for i = 1:s
 a1 = pts1(i,2) * P1(3,:) - P1(2,:)
 a2 = P1(1,:) - pts1(i,1) * P1(3,:)
 a3 = pts2(i,2) * P2(3,:) - P1(2,:)
 a4 = P2(1,:) - pts2(i,1) * P2(3,:)
 
 A = [a1; a2; a3;a4]
 toSVD = A' * A
 
 [s,v,d] = svd(toSVD)
  P = d(:,end)'
  P = P / P(4);
  
  pts3d(i,1) = P(1);
  pts3d(i,2) = P(2);
  pts3d(i,3) = P(3);
  
end

end