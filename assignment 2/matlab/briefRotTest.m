% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
I1 = imread('cv_cover.jpg');
%% Convert images to grayscale, if necessary
 if (ndims(I1) == 3)
        I1 = rgb2gray(I1);
 end
 
%% Compute the features and descriptors
hist = zeros(1,37);
for i = 0:36
    % Rotate image
    I2 = imrotate(I1, i*10);
    % Compute features and descriptors
    [ locs1, locs2] = matchPics( I1, I2 );
    if(i == 8 || i == 24 || i == 30)
        figure()
        showMatchedFeatures(I1, I2, locs1, locs2, 'montage');
    end
    % Match features
    % Update histogram
    [hist(i+1),~] = size(locs1);

end


% Display histogram
i = (0:10:360);
figure()
plot(i,hist);


% Your solution to Q2.1.5 goes here!


 
%% Compute the features and descriptors
hist = zeros(1,37);
for i = 0:36
    %% Rotate image
    I2 = imrotate(I1, i*10);
    %% Compute features and descriptors
    corners1 = detectSURFFeatures(I1);
    corners2 = detectSURFFeatures(I2);

    %% Obtain descriptors for the computed feature locations

    [desc1, locs1] = extractFeatures(I1, corners1);
    [desc2, locs2] = extractFeatures(I2, corners2);

%% Match features using the descriptors
    threshold = 10;

    indexPairs = matchFeatures(desc1,desc2,'MatchThreshold', threshold, 'MaxRatio', 0.8);
    locs1 = locs1(indexPairs(:,1),:);
    locs2 = locs2(indexPairs(:,2),:);    
    if(i == 8 || i == 24 || i == 30)
        figure()
        showMatchedFeatures(I1, I2, locs1, locs2, 'montage');
    end
    %% Match features
    %% Update histogram
    [hist(i+1),~] = size(locs1);

end


%% Display histogram
i = (0:10:360);
figure()
plot(i,hist);
