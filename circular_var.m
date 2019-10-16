function [vc,va,vs] = circular_var(theta,w,d)
%%  circular_var - calculates variance
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
%       vc      - circular variance - Mardia(1972a:45)
%       va      - angular variance  - Batschelet(1965,1981:34)
%       vs      - standard variance - Mardia(1972a:45)
%
%   AUTHOR:
%       Boguslaw Obara

%% setup
if nargin<2; w = ones(size(theta)); end
if nargin<3; d = 1; end

%% var
R = circular_r(theta,w,d);
vc = 1-R;
va = 2*(1-R);
vs = -2*log(R);

end