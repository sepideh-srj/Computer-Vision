function [img1] = myImageFilter(img0, h)

[sizeOfFilter, ~] = size(h);
paddingSize = floor(size(h)/2);
[width,height] = size(img0);
img0 = padarray(img0, paddingSize, 'replicate');
img1 = zeros(width,height, 'double');

for i = 1:width 
    for j=1:height
       img1(i,j) = sum(sum(img0(i: i+sizeOfFilter-1,j: j+sizeOfFilter-1).*h));
    end
end

end
