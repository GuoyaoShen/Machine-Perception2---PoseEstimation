% syms f;
% syms u;
% syms v;
% K = [f,0,u;
%      0,f,v;
%      0,0,1];
% K_inv = inv(K);
% K_t = K_inv';
% K_res = K_t * K_inv;
% disp(K_inv);
% disp(K_t);
% disp(K_res);

% v = [1;2;3];
% disp(inv(v));


% 3xN shape
% x = [1, 2, 2, 1;
%      1, 2, 3, 2;
%      1, 2, 4, 1];
% y = [3, 4, 5, 5;
%      3, 4, 6, 6;
%      3, 4, 7, 5];
%  
% p = polyfit(x(:,4),y(:,4),1);
% a = p(1);
% b = p(2);

% R =[-0.0947750986158936,-0.961981576100763,-0.256142788157384;
%     0.536517848195224,-0.266094054700956,0.800838655798264;
%     0.838550105390438,0.0615256149542248,-0.541339375488418];
% T = [-0.341932739780101;-0.172783426357872;-0.923703355543601];
% disp(-R' * T);

% X1 = [1,2;
%       1,3;
%       1,4];
% X2 = [2,3;
%       2,4;
%       2,5];
% E = estimateEmatrix(X1,X2);

lambdas = [1,2,0,4,5,6,0;
           2,1,0,5,4,6,0];  % 3 7
% index = all(lambdas,1)==0;
index = find(all(lambdas,1)==0);
% index = find((lambdas, 2) == 0);