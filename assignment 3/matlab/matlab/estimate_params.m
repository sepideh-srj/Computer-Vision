function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.

[~,~,v] = svd(P);
c = v(:,end);
M = P(1:3,1:3);
PP1 = [0 0 1; 0 1 0; 1 0 0];
% PP2 = [0 0 0 1; 0 0 1 0; 0 1 0 0; 1 0 0 0];

A = PP1* M;
c = -inv(M) * P(:,4);
[QQ, RR] = qr(A');
R = PP1 * (QQ');
K = PP1 * (RR') * PP1;
t = -RR * c;

end