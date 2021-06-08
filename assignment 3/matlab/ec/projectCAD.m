data = load('../data/PnP.mat')
X = data.X;
x = data.x;
cad = data.cad;
image = data.image;

p = estimate_pose(x,X);

[K,R, t] = estimate_params(p);
s = size(X,2);
projectedxs = p* [X; ones(1,s)];
pxs = zeros(2,s);
for i=1:s
    pxs(1,i) = projectedxs(1,i) / projectedxs(3,i);
    pxs(2,i) = projectedxs(2,i) / projectedxs(3,i);
end
figure(1);
imshow(image);
hold on 
scatter(pxs(1,:), pxs(2,:), 'g', '*');
scatter(x(1,:), x(2,:),  'k', 'o');
hold off

Vs = cad.vertices;
Fs = cad.faces;
v = R * (Vs');
figure(2);
trimesh(Fs, v(1,:), v(2,:), v(3,:), 'FaceColor', 'r', 'EdgeColor', 'b');

Vs = [Vs'; ones(1,size(v,2))];
projectedV = p * Vs;
pv = zeros(2,size(projectedV,2));
for i=1:size(projectedV,2)
    pv(1,i) = projectedV(1,i) / projectedV(3,i);
    pv(2,i) = projectedV(2,i) / projectedV(3,i);
end
pv = pv';
figure(3);
hold on
imshow(image);
p = patch('Faces',Fs,'Vertices',pv,'FaceColor','r', 'EdgeColor','none','FaceAlpha',0.2,'lineWidth', 2);
hold off

