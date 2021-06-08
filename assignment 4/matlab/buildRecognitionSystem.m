load('../data/traintest.mat');

% load('dictionaryRandom.mat', 'filters', 'dictionary');
% K = 100;
% trainFeatures = zeros(size(train_imagenames,2), K);
% 
% filterBank = filters;
% for i=1: size(train_imagenames,2)
%     
%     image = imread(strcat('../data/', train_imagenames{i}));
%     wordMap = getVisualWords(image, filterBank, dictionary);
%     h = getImageFeatures(wordMap, K);
%     trainFeatures(i, :) = h;
%     
%     
% end
% 
% trainLabels = train_labels;
% save('visionRandom.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels'); 

load('dictionarySurf.mat', 'filterBank', 'dictionary');
K = 100;

trainFeatures = zeros(size(train_imagenames,2), K);

for i=1: size(train_imagenames,2)
    
    image = imread(strcat('../data/', train_imagenames{i}));
    wordMap = getVisualWords(image, filterBank, dictionary);
    h = getImageFeatures(wordMap, K);
    trainFeatures(i, :) = h;
    
end

trainLabels = train_labels;         
save('visionHarrisNew.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels'); 

