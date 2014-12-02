function [F,inliers] = ransacF(pts1, pts2, normalization_constant)

%total times to run
n = 100000;

%params
threshold = 0.0008;
npts = size(pts1,2);
bestError = realmax;
bestF = [];
bestInliers = [];

%adjusted data
X1 = [pts1; ones(1,npts)];
X2 = [pts2; ones(1,npts)];

for i=1:n
    
    %randomly select 7 points for model
    model_pts_idx = randperm(npts);
    model_pts_idx = model_pts_idx(1:7);
    model_pts1 = pts1(:,model_pts_idx);
    model_pts2 = pts2(:,model_pts_idx);
    
    %build model
    Fcandidates = sevenpoint_norm(model_pts1, model_pts2, normalization_constant);
    
    %compute total error for each model
    for i_f=1:numel(Fcandidates)
        F = Fcandidates{i_f};
        
        totalError = 0;
        allInliers = [];
        for i_x=1:npts
            pointError = abs(X2(:,i_x)'*F*X1(:,i_x));
            if(pointError < threshold)
                allInliers = [allInliers i_x];
            end
            totalError = totalError + pointError;
        end
        
        if  numel(allInliers)>numel(bestInliers) || ( totalError < bestError && numel(allInliers)>=numel(bestInliers) )
            bestError = totalError;
            bestInliers = allInliers;
            bestF = F;
            fprintf('new best model with %i inliers and %d total error\n', numel(bestInliers), bestError);
        end
        
    end
    
end


F = bestF;
inliers = bestInliers;

end