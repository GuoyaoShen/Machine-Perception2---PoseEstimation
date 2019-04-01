function [E, bestInliers] = estimateEmatrixRANSAC(X1,X2)
% Estimate E matrix given a set of 
% pairs of matching *calibrated* points
% X1,X2: Nx2 matrices of calibrated points
%   i^th row of X1 matches i^th row of X2
%
% E: robustly estimated E matrix
% bestInliers: indices of the rows of X1 (and X2) that where in the
% largest consensus set

nIterations = 25000;  %500  1
sampleSize = 8;  %8  2

%fractionInliers = 0.6;
%nInliers = floor((size(X1,1) - sampleSize) * fractionInliers);
%bestError = Inf;
eps = 10^(-5);  %eps = 10^(-4);
bestNInliers = 0;

N = size(X1, 1);
X1_new = [X1, ones(N, 1)];  % Nx3
X2_new = [X2, ones(N, 1)];  % Nx3

for i=1:nIterations
    indices = randperm(size(X1,1));
    sampleInd = indices(1:sampleSize);
    testInd =  indices(sampleSize+1:length(indices));
    
    % Your code goes here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    E_sample = estimateEmatrix(X1(sampleInd, :), X2(sampleInd, :));
    % compute prepare matrix
    ehat = [0,-1,0;
            1,0,0;
            0,0,0];
    
    x1 = X1_new(testInd, :)';  % 3xn
    x2 = X2_new(testInd, :)';  % 3xn
    Ex1 = E_sample * x1;  % 3xn
    Ex2 = E_sample' * x2;  % 3xn
    x2Ex1 = x2 .* Ex1;  % 3xn
    x1Ex2 = x1 .* Ex2;  % 3xn
    upper1 = sum(x2Ex1, 1).^2;
    upper2 = sum(x1Ex2, 1).^2;
    
    e3Ex1 = ehat * Ex1;  % 3xn
    e3Ex2 = ehat * Ex2;  % 3xn
    lower1 = sum(e3Ex1.^2, 1);
    lower2 = sum(e3Ex2.^2, 1);   
    
    % compute residuals
    residuals = (upper1 ./ lower1) + (upper2 ./ lower2);  % Vector of residuals, same length as testInd.
                            % Can be vectorized code (extra-credit) 
                            % or a for loop on testInd
    lower = residuals < eps;
    curInliers = [sampleInd, testInd(lower)];    % don't forget to include the sampleInd
    
    % End of your code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    curNInliers = length(curInliers);

    if curNInliers > bestNInliers
        bestNInliers = curNInliers;
        bestInliers = curInliers;
        E = E_sample;
    end
end

% disp(['Best number of inliers: ' bestNInliers '/' size(X1,1)]); 
disp(['Best number of inliers: ' num2str(bestNInliers) '/' num2str(size(X1,1))]); 

%%  Function to calculate hat matrix of a vector
function e_hat = calcul_hat(e)
    e_hat = [0, -e(3), e(2);
             e(3), 0, -e(1);
             -e(2), e(1), 0];

