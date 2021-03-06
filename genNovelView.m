function genNovelView
	addpath(genpath('.'));
	load('data/K.mat'); %intrinsic parameters K
	I1 = imread('data/i1.jpg');
	I2 = imread('data/i2.jpg');

    normalization_constant = max(max(size(I1), size(I2)));


    %load('noisy_correspondences.mat'); 
    %[F,inliers] = ransacF(pts1, pts2, normalization_constant);

    load('noisy_correspondences.mat');
    [F,~] = ransacF(pts1, pts2, normalization_constant);

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
    %plotPlaneAndPoints(P, plane1, inliers1);

    remainingPoints = P;
    remainingPoints(:,inliers1)=[];

    %ransac for second plane
    [plane2, inliers2] = ransacPlane(remainingPoints, 0.1);
    %plotPlaneAndPoints(remainingPoints, plane2, inliers2);

    frame = drawNovelView(plane1', plane2', M1);
    imshow(frame);

    %M for view form higher angle
    %M = buildM(K,40,0,0,1,2,3);
    %frame = drawNovelView(plane1', plane2', M);
    %imshow(frame);
    
    
    %improvement
    %{
    reg1 = regress(P1(3,:)',[P1(1:2,:)' ones(size(P1(3,:)'))]);
    reg1 = [reg1(1) reg1(2) -1 reg1(3)];
    plane1_improved = reg1/norm(reg1);

    reg2 = regress(P2(3,:)',[P2(1:2,:)' ones(size(P2(3,:)'))]);
    reg2 = [reg2(1) reg2(2) -1 reg2(3)];
    plane2_improved = reg2/norm(reg2);

    frame = drawNovelView(plane1_improved', plane2_improved', M1);
    imshow(frame);
    %}


end

