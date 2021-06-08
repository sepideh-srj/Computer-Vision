% function [dictionary] = getDictionary(imgPaths, alpha, K, method)
load('../data/traintest.mat');
filters = createFilterBank();
imgPaths = train_imagenames;
alpha = 500;
K = 100;
method = 'harris';

num = size(imgPaths, 2);
pixelResponses= zeros(alpha*num, 3*size(filters,1));

for t=1:size(train_imagenames,2)
   image = imread(strcat('../data/', imgPaths{t}));
   filterResponses = extractFilterResponses(image, filters);
   if (strcmp(method,'random'))
       points = getRandomPoints(image, alpha);
   else
       points = getHarrisPoints(image, alpha, K);
   end

   for i=1:alpha
       pixelFilter = filterResponses(points(i, 1), points(i, 2), :);
       pixelResponses(i+ (t-1)*alpha, :) = reshape(pixelFilter, 1,3*size(filters,1));
   end
end
filterBank = filters;
[~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
save('dictionaryHarris.mat', 'filterBank', 'dictionary');

% end