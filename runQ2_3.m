addpath('lib'); 
addpath('data');

I1 = imread('i1.jpg');
I2 = imread('i2.jpg');
normalization_constant = max(max(size(I1), size(I2)));


load('noisy_correspondences.mat');
[F,inliers] = ransacF(pts1, pts2, normalization_constant);


displayEpipolarF(I1,I2,F);