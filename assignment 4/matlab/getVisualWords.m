function [wordMap] = getVisualWords(I, filterBank, dictionary)
% filterBank = createFilterBank();
% 
% I = imread('../data/desert/sun_acqlitnnratfsrsk.jpg');
[h, w, d] = size(I);
% w = size(img, 2);
fResponses = extractFilterResponses(I, filterBank); 
 
fResponses = reshape(fResponses, h*w, size(fResponses, 3));   
wordMap = pdist2(fResponses, dictionary);   
[~, wordMap] = min(wordMap, [], 2);    
wordMap = reshape(wordMap, h, w, size(fResponses, 3));
% if (size(I,3) == 3)
%         I = rgb2gray(I);
% end
% filterBank = createFilterBank();
% [w,h,d] = size(I);
% 
% filterResponses = extractFilterResponses(I,filterBank);
% responses = reshape(filterResponses, h*w, size(filterResponses, 3));
% distance = pdist2(filterResponses', dictionary);
% d = min(distance,[],2);
% d = reshape(d, h,w);
% wordMap = d;
% map = int16(wordMap);
% labels = label2rgb(map);
% 
% imshow(labels);
end
