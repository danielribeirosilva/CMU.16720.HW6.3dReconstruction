function F = sevenpoint_norm(pts1, pts2, normalization_constant)

%------------------------------------------------
% Normalize points
%------------------------------------------------
pts1 = pts1'/normalization_constant;
pts2 = pts2'/normalization_constant;

%------------------------------------------------
% Determine F1 and F2
%------------------------------------------------

%Find A
X1 = pts1(:,1);
Y1 = pts1(:,2);
X2 = pts2(:,1);
Y2 = pts2(:,2);
A = [X2.*X1 X2.*Y1 X2 Y2.*X1 Y2.*Y1 Y2 X1 Y1 ones(size(X1))];

%Get singular vector of smallest singular value
[~,~,V] = svd(A);
f1 = V(:,9);
f2 = V(:,8);
F1 = reshape(f1,3,3)';
F2 = reshape(f2,3,3)';

%------------------------------------------------
% Enforce det(F1 + lambda*F2)=0 constraint
%------------------------------------------------

%F1
a = F1(1,1); b = F1(1,2); c = F1(1,3);
d = F1(2,1); e = F1(2,2); f = F1(2,3);
g = F1(3,1); h = F1(3,2); i = F1(3,3);
%F2
j = F2(1,1); k = F2(1,2); l = F2(1,3);
m = F2(2,1); n = F2(2,2); o = F2(2,3);
p = F2(3,1); q = F2(3,2); r = F2(3,3);

% compute the polynomial det = A*lambda^3 + B*lambda^2 + C*lambda + D
D = a*e*i - a*f*h - b*d*i + b*f*g + c*d*h - c*e*g;
C = a*e*r - a*f*q - a*h*o + a*i*n - b*d*r + b*f*p + b*g*o - b*i*m + c*d*q - c*e*p - c*g*n + c*h*m + d*h*l - d*i*k - e*g*l + e*i*j + f*g*k - f*h*j;
B = a*n*r - a*o*q - b*m*r + b*o*p + c*m*q - c*n*p - d*k*r + d*l*q + e*j*r - e*l*p - f*j*q + f*k*p + g*k*o - g*l*n - h*j*o + h*l*m + i*j*n - i*k*m;
A = j*n*r - j*o*q - k*m*r + k*o*p + l*m*q - l*n*p;

%solve polynomial
all_roots = roots([A B C D]);

%select all real roots and get corresponding solution
%(at least one is guaranteed to be real, since it's an odd-order polynomial with real coefficients)
real_roots=[];
for i=1:3
    if(isreal(all_roots(i)))
        real_roots = [real_roots all_roots(i)];
    end
end

nr = numel(real_roots);
F = cell(1,nr);

for i=1:nr
    F{i} = F1 + real_roots(i)*F2;
end

%------------------------------------------------
% Denormalization
%------------------------------------------------
T = eye(3)/normalization_constant;
T(3,3)=1;
for i=1:nr
    F{i} = T'*F{i}*T;
end


end