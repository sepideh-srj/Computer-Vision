% Q3.3.1
book = loadVid('../data/book.mov');
panda = loadVid('../data/ar_source.mov');
pandaVideo = VideoReader('../data/ar_source.mov');

cv_img = imread('../data/cv_cover.jpg');
[~, s] = size(panda);
imshow(panda(10).cdata)
workingDir = '../results';
outputVideo = VideoWriter(fullfile(workingDir,'out.avi'));
outputVideo.FrameRate = pandaVideo.FrameRate;
open(outputVideo)

for k = 1 :s
    desk_img = book(k).cdata;
    [locs1, locs2] = matchPics(cv_img, desk_img);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
%     imshow(panda(k).cdata)
    img = imcrop(panda(k).cdata,[208.5 45.5 206 273]);
    scaled_hp_img = imresize(img, [size(cv_img,1) size(cv_img,2)]);
    composite_img = compositeH(inv(bestH2to1), scaled_hp_img, desk_img);
%     imshow(composite_img)
    writeVideo(outputVideo,composite_img)
    


end
