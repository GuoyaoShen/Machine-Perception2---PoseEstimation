function E = estimateEmatrix(X1,X2)
% Estimate E matrix given a set of 
% pairs of matching *calibrated* points
% X1,X2: Nx2 matrices of calibrated points
%   i^th row of X1 matches i^th row of X2

% Kronecker products
% Your code goes here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = size(X1, 1);
X1_new = [X1, ones(N, 1)];  % Nx3
X2_new = [X2, ones(N, 1)];  % Nx3
A = [X1_new(:, 1) .* X2_new, X1_new(:, 2) .* X2_new, X1_new(:, 3) .* X2_new];  % Nx9

[~,~,V] = svd(A);
e = V(:, end);
E_temp = [e(1:3), e(4:6), e(7:end)];

% Project E on the space of essential matrices
diag = [1, 0, 0;
        0, 1, 0;
        0, 0, 0];
[Ue,~,Ve] = svd(E_temp);
E = Ue * diag * Ve';

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
