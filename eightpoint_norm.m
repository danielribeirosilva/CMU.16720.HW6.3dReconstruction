function F = eightpoint_norm(pts1, pts2, normalization_constant)

%------------------------------------------------
% Normalize points
%------------------------------------------------
pts1 = pts1'/normalization_constant;
pts2 = pts2'/normalization_constant;

%------------------------------------------------
% Determine F without the det=0 constraint
%------------------------------------------------

%Find A
X1 = pts1(:,1);
Y1 = pts1(:,2);
X2 = pts2(:,1);
Y2 = pts2(:,2);
A = [X2.*X1 X2.*Y1 X2 Y2.*X1 Y2.*Y1 Y2 X1 Y1 ones(size(X1))];

%Get singular vector of smallest singular value
[~,~,V] = svd(A);
f = V(:,9);
F = reshape(f,3,3)';

%------------------------------------------------
% Enforce det=0 constraint on F
%------------------------------------------------
[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';

%------------------------------------------------
% Denormalization
%------------------------------------------------
T = eye(3)/normalization_constant;
T(3,3)=1;
F = T'*F*T;


end