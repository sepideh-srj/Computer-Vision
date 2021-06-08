%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat
confusion = zeros(10,10);
% GT = zeros(100,1);
% label = zeros(100,1);
%% Testing the network
% Modify the code to get the confusion matrix
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [~, labels] = max(P);
    for cnt=0:99
        label = labels(cnt+1);
        GT = ytest(i+cnt);
        confusion(GT, label) = confusion(GT, label) +1;
        
    end
end