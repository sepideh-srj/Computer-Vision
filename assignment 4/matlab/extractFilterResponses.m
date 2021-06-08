function [filterResponses] = extractFilterResponses(I, filterBank)
% I = imread('../data/bedroom/sun_aacyfyrluprisdrx.jpg');
% filterBank = createFilterBank();
filterResponses = zeros(size(I,1), size(I,2), 3*size(filterBank,1));
I = im2double(I);
if (size(I,3) == 3)
    I = RGB2Lab(I);
else
    I = RGB2Lab(repmat(I, [1,1,3]));
end
% 
% figure()
% imshow(I);
for n=1:size(filterBank,1)    
    filter = filterBank{n};
    for i=1:3
        filterResponses(:,:,i+3*(n-1)) = imfilter(I(:,:,i),filter);
    end  
end

% figure()
% imshow(filterResponses(:,:,1),[]);
% figure()
% imshow(filterResponses(:,:,10),[]);
% figure()
% imshow(filterResponses(:,:,25),[]);
% figure()
% imshow(filterResponses(:,:,52),[]);

end