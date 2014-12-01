addpath('lib'); 
addpath('data');

I1 = imread('i1.jpg');
I2 = imread('i2.jpg');
normalization_constant = max(max(size(I1), size(I2)));


load('clean_correspondences.mat');
pts1 = pts1(:,1:7);
pts2 = pts2(:,1:7);
Fclean = sevenpoint_norm(pts1, pts2, normalization_constant);
displayEpipolarF(I1,I2,Fclean{1});