% A test script using templeCoords.mat
%
% Write your code here
%

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
data = load('../data/someCorresp.mat');
F = eightpoint(data.pts1, data.pts2, data.M);

% epipolarMatchGUI(im1,im2,F)
load('../data/templeCoords.mat');
pts2 = epipolarCorrespondence(im1,im2,F,pts1) ;

intrinsicData = load('../data/intrinsics.mat');
K1 = intrinsicData.K1;
K2 = intrinsicData.K2;
E = essentialMatrix(F,K1,K2)
% displayEpipolarF(im1,im2,F);
%epipolarMatchGUI(im1,im2,F);
P1 = K1 * [eye(3,3),zeros(3,1)];
P2s = camera2(E);
depths = zeros(4,1);
compare = -100;

for i=1:4
    P2 = K2 * P2s(:,:,i);
    pts3d = triangulate(P1, pts1, P2, pts2);
    depths = sum(sum(pts3d(:,3)>0));
    if compare < depths
        final = pts3d;
        P2final = P2;
        compare = depths;
    end
end
R1t1 = inv(K1) * P1;
R2t2 =  inv(K2) * P2final;
R1 = R1t1(:,1:3);
R2 = R2t2(:,1:3);
t1 = R1t1(:,4);
t2 = R2t2(:,4);
scatter3(final(:,1), final(:,2), final(:,3),'filled')
s = size(pts3d,1);
pts1fromP1 = (P1 * [final' ; ones(1,s)])';
pts2fromP2 = (P2final * [final' ; ones(1,s)])';


for i = 1:s
    finalPts1(i,:) =  pts1fromP1(i, 1:2)/pts1fromP1(i, 3);
end

for i = 1:s
    finalPts2(i,:) =  pts2fromP2(i, 1:2)/pts2fromP2(i, 3);
end

err1 = mean(sqrt(sum(finalPts1 - pts1)'.^2))/length(pts1);
err2 = mean(sqrt(sum(finalPts2 - pts2)'.^2))/length(pts2);
% save extrinsic parameters for dense reconstruction
save('data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
