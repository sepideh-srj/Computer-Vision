function [rhos, thetas] = myHoughLines(H, nLines)

[width, height] = size(H);
% P = houghpeaks(H, nLines);
% rhos = P(:,1);
% thetas = P(:,2);
% end
H1 = padarray(H, [1,1], 0);
rhos = zeros(nLines,1);
thetas = zeros(nLines,1);

 
for i=2:width +1 
    for j=2:height+1
        if H1(i,j) ~= max([H1(i,j), H1(i-1,j), H1(i+1,j), H1(i-1,j-1), H1(i-1,j+1), H1(i+1, j+1), H1(i+1, j-1), H1(i,j-1), H1(i,j+1)])
            H(i-1,j-1) = 0;
            H1(i,j) = 0;
        end
        
    end
end

for i=2:width + 1
    for j=2:height +1
        if H1(i,j) == (H1(i-1,j)|| H1(i+1,j)|| H1(i-1,j-1)|| H1(i-1,j+1)|| H1(i+1, j+1) || H1(i+1, j-1)|| H1(i,j-1)|| H1(i,j+1))
            H(i-1,j-1) = 0;
            H1(i,j) = 0;
        end
        
    end
end


for i=1:nLines
    [row, col] = find(ismember(H, max(H(:))), 1,'first');
    H(row,col) = 0;
    
    rhos(i) = row;
    thetas(i) =  col;
    
end

% print(rhos)
% print(thetas)
% figure(3)
% imshow(H);
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% plot(T(thetas),R(rhos),'s','color','white');




end
        