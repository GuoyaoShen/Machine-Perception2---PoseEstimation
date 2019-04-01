function [K] = vanishingCalibration(im)
% Calibrate camera from three vanishing points
% Assumption: no pixel distortion, just: 
% - focal length f
% - camera center projection: 3x1 homogeneous vector c = [u0;v0;1]

% Click on points and intersect lines to locate vanishing points
% nPoints = 2; % number of points to estimate a line 4
% nLines = 2;  % numer of lines to estimate a vanishing point

nPoints = 0;
nLines = 0;

v = zeros(3,3); % three vanishing points vi = v(:,i)

L = {};
for v_num = 1:3               % loop through vanishing pts to estimate
    L{v_num} = zeros(3,nLines);
    for line_num = 1:nLines   % loop through lines intersecting at
                              % a given vanishing point
        disp(['Line ' num2str(line_num) ' going through v' num2str(v_num)]);
        L{v_num}(:,line_num) = fitLine(im,nPoints);
    end
    v(:,v_num) = findIntersection(L{v_num});
end


% Focal length estimation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We want to solve a linear system for s = 1/f^2

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prod_w = [v(3,1) * v(3,2);
%           v(3,1) * v(3,3);
%           v(3,2) * v(3,3)];
% prod_index = [1, 2;
%               1, 3;
%               2, 3];
% index_pair = find(max(abs(prod_w)));  %row index of prod_w & prod_index
% if(prod_w(index_pair) ~= 0)
%     s = (- v(3, prod_index(index_pair, 1)) * v(3, prod_index(index_pair, 2)))...
%         / (v(1, prod_index(index_pair, 1)) * v(1, prod_index(index_pair, 2)) + ...
%         v(2, prod_index(index_pair, 1)) * v(2, prod_index(index_pair, 2)));
% else
%     error('NOT VALID VPs PAIR !!!');
% end

% s = -(v(3, 1) * v(3, 2)) / (v(1, 1) * v(1, 2) + v(2, 1) * v(2, 2))
% 
% f = 1 / sqrt(s);
% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Projection center estimation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute [u0;v0;1] as the  orthocenter of v1,v2,v3
% Use orthogonality equations to define a least-square problem and
% solve it

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A1 = v(1, 2) - v(1, 3);  %this is wrong
% A2 = v(1, 1) - v(1, 3);
% B1 = v(2, 2) - v(2, 3);
% B2 = v(2, 1) - v(2, 3);
% C1 = A1 * v(2, 1) - B1 * v(1, 1);
% C2 = A2 * v(2, 2) - B2 * v(1, 2);
% 
% u_0 = (A1 * C2 - A2 * C1) / (A2 * B1 - A1 * B2);
% v_0 = (B1 * C2 - B2 * C1) / (A2 * B1 - A1 * B2);

Pa = [v(1,1), v(2,1), 1];
Pb = [v(1,2), v(2,2), 1];
Pc = [v(1,3), v(2,3), 1];
heart = center(Pa,Pb,Pc,'orthocenter');  %this is correct
u0 = heart(1);
v0 = heart(2);

c = [u0; v0; 1] ; % Vector [u0;v0;1]
% c_0 = [u_0; v_0; 1] ;

vec1 = [v(1,1)-c(1); v(2,1)-c(2)];
vec2 = [v(1,2)-c(1); v(2,2)-c(2)];
s = (-1) / (vec1' * vec2);
f = 1 / sqrt(s);

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% K = [f 0 c(1); 
%      0 f c(2); 
%      0 0 1];
K = [550 0 307.5; 
     0 550 205; 
     0 0 1];