% Draw lines between corresponding points in two image
%   img1, img2, two images of equal size
%   pts1, pts2 - a 2xN matrix of points 
function [] = plotMatches( img1, pts1, img2, pts2);
if (size(img1) ~= size(img2))
    fprintf('Images must be the same size.\n');
    return
end

img = [img1 img2];
imshow(img);
axis equal;

lx = [pts1(1,:); pts2(1,:)+size(img1,2)];
ly = [pts1(2,:); pts2(2,:)];

perm = randperm(size(pts1,2)) ;
sel = perm(1:min([100 size(pts1,2)])) ;

line(lx(:,sel),ly(:,sel),'Color','g');


end
