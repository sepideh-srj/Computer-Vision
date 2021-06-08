layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = true;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
images = zeros(28*28,5);
folder = '../images/';
for i =1:5
    im1 = dir(sprintf('../images/%d.jpg',i)).name;
    I=im2double(imread(fullfile(folder,im1)));  
    if size(I,3)==3
        I = rgb2gray(I);
    end
    I = padarray(I,[10,10],1);

    I = imresize(I,[28,28]);
    level = graythresh(I);
    
    I = imbinarize(I,level);
    imshow(I);
    I = 1 - I;
    I = I';
    I = I(:);
    
    images(:,i) = I;
end
% for i=100:size(xtest,2)
%     data = xtest(:, i:i+99);
% %     data(:,1) = I;
%     in.data = I;
%     in.width = 28;
%     in.height = 28;
%     in.channel = 1;
%     in.batch_size = 1;
%     [output, P] = convnet_forward(params, layers, in);
%     [~, result] = max(P);
%     
% % end

data = xtest(:, 1:100);
data(:,1:5) = images;
[output, result] = convnet_forward(params, layers, data);
[~, result] = max(result);
for i=1:5
    im1 = dir(sprintf('../images/%d.jpg',i)).name;
    I=imread(fullfile(folder,im1)); 
    subplot(1,5,i);
    imshow(I);
    title(result(1,i)-1);
end