load('../data/traintest.mat');
load('idf.mat');
labelEuc = zeros(size(test_labels));
labelChi = zeros(size(test_labels));
ChiDistance = zeros(size(train_imagenames,2),1);
EucDistance = zeros(size(train_imagenames,2),1);
K = 100;


for i=1: size(test_imagenames,2)
    
    image = imread(strcat('../data/', test_imagenames{i}));
    wordMap = getVisualWords(image, filterBank, dictionary);
    testH = getImageFeatures(wordMap, K).*idf;
    for j=1:size(train_imagenames,2)
        trainH = trainFeatures(j,:).*idf;
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

