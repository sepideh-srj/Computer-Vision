function F = eightpoint(pts1, pts2, M)
% data = load('../data/someCorresp.mat');
% pts1 = data.pts1;
% pts2 = data.pts2;
% M = data.M;
pts1 = pts1/M;
pts2 = pts2/M;
[s, ~] = size(pts1);
A = zeros(s,9);
for i=1:s
temp = [pts1(i,1)*pts2(i,1); pts2(i,1)*pts1(i,2); pts2(i,1); pts2(i,2)*pts1(i,1); pts2(i,2)*pts1(i,2); pts2(i,2); pts1(i,1); pts1(i,2); 1];
A(i,:) = temp;

end

[u,s,v] = svd(A);
F = v(:,9);
F = reshape(F,3,3)';
F = F./norm(F);
[uprim, sprim, vprim] = svd(F);
F = refineF(F, pts1, pts2);

sprim(3,3) = 0;
F = uprim * sprim * vprim';

scaling = [1/M, 0, 0; 
           0, 1/M, 0;
           0, 0, 1];
F = scaling' * F * scaling       
end
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
