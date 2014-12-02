function [] = plotPlaneAndPoints(points, plane, inliers)

P = points(:,inliers);

%points
scatter3(P(1,:), P(2,:), P(3,:));

%get plane points
p1 = [0,0,-plane(4)/plane(3)];
p2 = [0,-plane(4)/plane(2),0];
p3 = [-plane(4)/plane(1),0,0];
p = [p1' p2' p3'];

%plot plane
hold on;
fill3(p(1,:), p(2,:), p(3,:), 'r');

end