load('../data/traintest.mat');
filters = createFilterBank();
imgPaths = train_imagenames;
alpha = 400;
K = 100;

num = size(imgPaths, 2);
pixelResponses= zeros(alpha*num, 3*size(filters,1));

for t=1:size(train_imagenames,2)
   image = imread(strcat('../data/', imgPaths{t}));
   filterResponses = extractFilterResponses(image, filters);
   
    if (size(image,3) == 3)
        image = rgb2gray(image);
    end
   points = detectSURFFeatures(image).Location;

   for i=1:size(points,1)
       pixelFilter = filterResponses(round(points(i, 2)), round(points(i, 1)), :);
       pixelResponses(i+ (t-1)*alpha, :) = reshape(pixelFilter, 1,3*size(filters,1));
   end
end
filterBank = filters;
[~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
save('dictionarySurf.mat', 'filterBank', 'dictionary');




% load('dictionaryHarris.mat', 'filterBank', 'dictionary');
% K = 100;
% 
% trainFeatures = zeros(size(train_imagenames,2), K);
% 
% for i=1: size(train_imagenames,2)
%     
%     image = imread(strcat('../data/', train_imagenames{i}));
%     h = extractHOGFeatures(image)
%     trainFeatures(i, :) = h;
%     
% end
% 
% trainLabels = train_labels;         
% save('visionHarrisHOG.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels'); 
% 

