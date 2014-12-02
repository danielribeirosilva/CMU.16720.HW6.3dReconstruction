addpath('lib'); 
addpath('data');

I1 = imread('i1.jpg');
I2 = imread('i2.jpg');
normalization_constant = max(max(size(I1), size(I2)));


%load('noisy_correspondences.mat'); 
%[F,inliers] = ransacF(pts1, pts2, normalization_constant);

load('clean_correspondences.mat');
F = eightpoint_norm(pts1, pts2, normalization_constant);

%intrinsic parameters K
load('K.mat');

%essential matrix
E = K'*F*K;

%camera matrices
M1 = K*[eye(3) zeros(3,1)];
M2 = camera2(F, K, K, pts1, pts2);

%triangulate
P = triangulate(M1, pts1, M2, pts2);

%ransac for first plane
[plane1, inliers1] = ransacPlane(P, 0.1);
P1 = P(:,inliers1); %points in first plane
%plotPlaneAndPoints(P, plane1, inliers1);

remainingPoints = P;
remainingPoints(:,inliers1)=[];

%ransac for second plane
[plane2, inliers2] = ransacPlane(remainingPoints, 0.1);
P2 = remainingPoints(:,inliers2); %points in second plane
%plotPlaneAndPoints(remainingPoints, plane2, inliers2);

frame = drawNovelView(plane1', plane2', M1);
imshow(frame);

%M for view form higher angle
%M = buildM(K,40,0,0,1,2,3);
%frame = drawNovelView(plane1', plane2', M);
%imshow(frame);


