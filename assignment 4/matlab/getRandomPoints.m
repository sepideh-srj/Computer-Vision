function [points] = getRandomPoints(I, alpha)
%     alpha = 50;
%     I = imread('../data/campus/sun_albthhletanyjwjn.jpg');
    x=round(rand(1,alpha)*(size(I,1)-1)+1);
    y=round(rand(1,alpha)*(size(I,2)-1)+1);

    points = [x(1,:); y(1,:)]';
    
%     imshow(I)
%     hold on
%     plot(points(:,2), points(:,1), 'r*')
% 
% 
%     hold off

end