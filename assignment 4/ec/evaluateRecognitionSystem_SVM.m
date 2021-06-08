load('../data/traintest.mat');
% t = templateSVM('KernelFunction','gaussian');
t = templateSVM('KernelFunction','linear');
Mdl = fitcecoc(trainFeatures,train_labels,'Learners',t);
save('visionSVMHarris.mat','Mdl');
K = 100;
label = zeros(size(test_labels));

for i=1: size(test_imagenames,2)
    
    image = imread(strcat('../data/', test_imagenames{i}));
    wordMap = getVisualWords(image, filterBank, dictionary);
    testH = getImageFeatures(wordMap, K);
    label(i)=predict(Mdl,testH);
end

  accuracy = sum(test_labels == label)/ size(test_labels,2);

  Confusion = confusionmat(test_labels,label);