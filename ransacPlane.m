function [plane, inliers] = ransacPlane(pts, threshold)

%total times to run
n = 10000;

%params
%threshold = 0.1;
npts = size(pts,2);
bestError = realmax;
bestPlane = [];
bestInliers = [];

for i=1:n
    
    %randomly select 3 points for plane
    plane_pts_idx = randperm(npts);
    plane_pts_idx = plane_pts_idx(1:3);
    plane_pts = pts(:,plane_pts_idx);
    
    %build plane
    planeCandidate = getPlane(plane_pts(:,1)', plane_pts(:,2)', plane_pts(:,3)');
    
    %compute total error for each model
    totalError = 0;
    allInliers = [];
    for i_x=1:npts
        pointError = distancePointPlane(pts(:,i_x)', planeCandidate);
        if(pointError < threshold)
            allInliers = [allInliers i_x];
        end
        totalError = totalError + pointError;
    end

    if numel(allInliers)>numel(bestInliers) || ( totalError < bestError && numel(allInliers)>=numel(bestInliers) )
        bestError = totalError;
        bestInliers = allInliers;
        bestPlane = planeCandidate;
        fprintf('new best model with %i inliers and %d total error\n', numel(bestInliers), bestError);
    end
    
end


plane = bestPlane;
inliers = bestInliers;

end