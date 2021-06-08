load('../data/traintest.mat');
labelEuc = zeros(size(test_labels));
labelChi = zeros(size(test_labels));
ChiDistance = zeros(size(train_imagenames,2),1);
EucDistance = zeros(size(train_imagenames,2),1);
K = 100;
% filterBank = filter_bank;
% for i=1: size(test_imagenames,2)
%     
%     image = imread(strcat('../data/', test_imagenames{i}));
%     wordMap = getVisualWords(image, filterBank, dictionary);
%     testH = getImageFeatures(wordMap, K);
%     for j=1:size(train_imagenames,2)
%         trainH = trainFeatures(j,:);
%         EucDistance(j) = getImageDistance(testH, trainH, 'euclidean');
%     end
%     
%     [~, minEucD] = min(EucDistance);
%     
%     labelEuc(i) = train_labels(minEucD);
%    
% end
% accuracyEuc = sum(test_labels == labelEuc)/ size(labelEuc,2);
% 
% ConfusionEuc = confusionmat(test_labels,labelEuc);

% fprintf(' accuracy with random points and euclidian distance is: %f', accuracyEuc);
% fprintf(' confusion matrix with random points and chi2 distance is:');
% disp(ConfusionEuc);

for i=1: size(test_imagenames,2)
    
    image = imread(strcat('../data/', test_imagenames{i}));
    wordMap = getVisualWords(image, filterBank, dictionary);
    testH = getImageFeatures(wordMap, K);
    for j=1:size(train_imagenames,2)
        trainH = trainFeatures(j,:);
        ChiDistance(j) =  getImageDistance(testH, trainH, 'chi2');
    end
    
    [~, minChiD] = min(ChiDistance);
    
    labelChi(i) = train_labels(minChiD);
   
end
accuracyChi = sum(test_labels == labelChi)/ size(labelEuc,2);

ConfusionChi = confusionmat(test_labels,labelChi);

fprintf(' accuracy with random points and chi2 distance is: %f', accuracyChi);
fprintf(' confusion matrix with random points and chi2 distance is:');
disp(ConfusionChi);

