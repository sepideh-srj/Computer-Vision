function [img1] = myEdgeFilter(img0, sigma)


hsize = 2 * ceil(3 * sigma) + 1;
h = fspecial('gaussian',hsize,sigma);
smoothed = myImageFilter(img0,h);

Gx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
Gy = Gx';
imgx = myImageFilter(smoothed, Gx);
imgy = myImageFilter(smoothed, Gy);



angle = atan2(imgy, imgx)*180/pi + 180;
magnitude = sqrt((imgx.^2) + (imgy.^2));


mapto0 = ((angle >= 0 ) & (angle < 22.5)) | ((angle>= 157.5) & (angle < 202.5)) | ((angle>= 337.5) & (angle<= 360));
angle(mapto0) = 0;
mapto45 = ((angle >= 22.5 & angle< 67.5) | (angle >= 202.5 & angle < 247.5));
angle(mapto45) = 45;
mapto90 = ((angle >= 67.5 & angle < 112.5) | (angle >= 247.5 & angle < 292.5));
angle(mapto90) = 90;
mapto135 = ((angle >= 112.5 & angle < 157.5) | (angle >= 292.5 & angle < 337.5));
angle(mapto135) = 135;

[width,height] = size(img0);
img1 = zeros(width, height);

for i=2:width-1
    for j=2:height-1
        if (angle(i,j)==0 && (magnitude(i,j) == max([magnitude(i,j), magnitude(i,j+1), magnitude(i,j-1)])))
            img1(i,j) = magnitude(i,j);
        elseif (angle(i,j)==135 && (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j-1), magnitude(i-1,j+1)])))
            img1(i,j) = magnitude(i,j);
        elseif (angle(i,j)==90 && (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j), magnitude(i-1,j)])))
            img1(i,j) = magnitude(i,j);
        elseif (angle(i,j)==45 && (magnitude(i,j) == max([magnitude(i,j), magnitude(i+1,j+1), magnitude(i-1,j-1)])))
           img1(i,j) = magnitude(i,j);
        end;
    end;
end;


end
    
                
        
        
