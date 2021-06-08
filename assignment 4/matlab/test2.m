

% img = imread('../dat/beach/sun_aaxoqeosqjioeukn.jpg');

% output = getVisualWords(img, filterBank, dictionary);

% 
% a = imagesc(wordMap);
% 
% set(gca,'LooseInset',get(gca,'TightInset'))
% set(gca,'Visible','off')
% data = getimage(gca);
% 
% image_data = a.CDataMapping;
map = int16(wordMap);
labels = label2rgb(wordMap);

imshow(labels);
% % imwrite(image_data, 'test.jpg');
% 
% data = getimage(gca);