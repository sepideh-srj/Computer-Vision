
load('../data/traintest.mat');
labelEuc = zeros(size(test_labels));
labelChi = zeros(size(test_labels));
ChiDistance = zeros(size(train_imagenames,2),1);
EucDistance = zeros(size(train_imagenames,2),1);
accuracyEuc = zeros(40,1);
K = 100;
% filterBank = filter_bank;
for kNN=1:40
for i=1: size(test_imagenames,2)
    
    image = imread(strcat('../data/', test_imagenames{i}));
    wordMap = getVisualWords(image, filterBank, dictionary);
    testH = getImageFeatures(wordMap, K);
    for j=1:size(train_imagenames,2)
        trainH = trainFeatures(j,:);
        EucDistance(j) = getImageDistance(testH, trainH, 'chi2');
    end
    [~, MinDs] = mink(EucDistance, kNN);
    labels = zeros(8,1);
    for n = 1:kNN
        l = train_labels(MinDs(n));
        labels(l) = labels(l) + 1;
    end
    [~, finalLabel] = max(labels);

    labelEuc(i) = finalLabel;

   
end
accuracyEuc(kNN) = sum(test_labels == labelEuc)/ size(labelEuc,2);

ConfusionEuc = confusionmat(test_labels,labelEuc);
fprintf('k is: %d', kNN);
fprintf('%f', accuracyEuc(kNN));
disp(ConfusionEuc);
end

plot(accuracyEuc);