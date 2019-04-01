% load('calib_images.mat')
% open('calib_images.mat')
% 
% load calib_images
% image1 = calib_images{1};
% K = vanishingCalibration(image1);
% figure(1)
% imshow(image1)

%======================================================

% figure(2)
% imshow(calib_images{2})
% figure(3)
% imshow(calib_images{3})
% figure(4)
% imshow(calib_images{4})

%========================================================

% X1 = [1,2;
%       1,3;
%       1,4];
% X2 = [2,2;
%       2,3;
%       2,4];
% % E = estimateEmatrix(X1,X2);
% [E, bestInliers] = estimateEmatrixRANSAC(X1,X2);

%====================================================

E = [1,2,3;
     4,5,6;
     7,8,9];
[transfoCandidates] = poseCandidatesFromE(E);