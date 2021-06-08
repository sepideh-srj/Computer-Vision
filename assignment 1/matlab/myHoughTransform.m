function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
[width,height] = size(Im);
i = 1:width;
j = 1:height;
Im(i,j) = Im(i,j) > threshold;



D = sqrt((width - 1)^2 + (height - 1)^2);
nrho =ceil(D);

theta = 180;
thetaRes = thetaRes * 180/pi;
ntheta = theta;

rhoScale = -nrho:rhoRes:nrho;

thetaScale = 0:thetaRes:179;
H = zeros(2*ceil(nrho/rhoRes), ceil(ntheta/thetaRes));


for i = 1:width
    for j = 1:height
        if Im(i,j)
            for t = 0:thetaRes:179
                rho = round(j*cosd(t) + i*sind(t));
                if (rho < nrho && rho > -nrho)
                    H(round(nrho/rhoRes)+ round(rho/rhoRes), t/thetaRes+1) = H(round(nrho/rhoRes)+ round(rho/rhoRes), t/thetaRes+1) +1;
                end    
            end
        end
    end
end


rhoScale = rhoScale * pi/180;
        
end
        