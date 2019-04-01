function [transfoCandidates] = poseCandidatesFromE(E)
% Return the 4 possible transformations for an input matrix E
% transfoCandidates(i).T is the 3x1 translation
% transfoCandidates(i).R is the 3x3 rotation

transfoCandidates = repmat(struct('T',[],'R',[]),[4 1]);
% Fill in the twisted pair for E and the twisted pair for -E
% The order does not matter.

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[U, ~, V] = svd(E);
T_temp = U(:, end);
R_plus = [0, -1, 0;
          1, 0, 0;
          0, 0, 1];
R_minus = [0, 1, 0;
           -1, 0, 0;
           0, 0, 1];

transfoCandidates(1).T = T_temp;
transfoCandidates(1).R = U * R_plus' * V';
transfoCandidates(2).T = T_temp;
transfoCandidates(2).R = U * R_minus' * V';
transfoCandidates(3).T = - T_temp;
transfoCandidates(3).R = U * R_plus' * V';
transfoCandidates(4).T = - T_temp;
transfoCandidates(4).R = U * R_minus' * V';

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%