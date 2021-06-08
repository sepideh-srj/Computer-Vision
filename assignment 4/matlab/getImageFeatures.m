function [ h ] = getImageFeatures(wordMap, dictionarySize)

% dictionarySize = 100;
h = histcounts(wordMap,dictionarySize);
h = h/sum(h);



end