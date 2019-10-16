function R = circular_r(theta,w,d)
%%  circular_r - calculates mean resultant vector length
%   
%   REFERENCE:
%       N.I. Fisher, Statistical Analysis of Circular Data
%
%   INPUT:
%       theta   - angles in radians
%       w       - weights
%       d       - dimension
%
%   OUTPUT:
%       R       - mean resultant vector length
%
%   AUTHOR:
%       Boguslaw Obara
%

%% setup
if nargin<2; w = ones(size(theta)); end
if nargin<3; d = 1; end

%% R
R = sum(w.*exp(1i*theta),d);
R = abs(R)./sum(w,d);

end