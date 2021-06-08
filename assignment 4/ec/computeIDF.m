load('visionHarrisNew.mat');
k = 100;
idf = zeros(1,100);
for i=1:100
    weight = 0;
    for j =1:size(trainFeatures,1)
        if (trainFeatures(j,i)~=0)
            weight = weight + 1;
        end
    end
    if (weight~=0)
        idf(1,i) = log( size(trainFeatures,1) / weight );
        
    end
end
