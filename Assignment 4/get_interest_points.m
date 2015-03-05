%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get_interest_points.m
%
% Author: Branden E. Smith
%
% Finds interesting points (corners) in an image and returns them.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function points = get_interest_points(image)
% Sigma for Gaussian Blur
SIGMA = 1;
alpha = .04;

% Image size information (if needed).
[x, y, z] = size(image);

%%
% Compute the horizontal and vertical derivatives of the image by
% convolving the original image with derivatives of Guassians.
filter = fspecial('Gaussian', 7, SIGMA);
image = double(imfilter(image, filter));

% Partial derivative filters
d_x = [-1 0 1; -1 0 1; -1 0 1];
d_y = transpose(d_x);

% Filter the image with partial derivative filters.
I_x = imfilter(image, d_x);
I_y = imfilter(image, d_y);

%%
% Compute the three images corresponding to the outer products of these
% gradients. (The matrix is symmetric, so only three entries are needed.
I_xx = I_x.*I_x;
I_yy = I_y.*I_y;
I_xy = I_x.*I_y;

%%
% Convolve each of these images with a larger Gaussian.
I_xxg = imfilter(I_xx, filter);
I_yyg = imfilter(I_yy, filter);
I_xyg = imfilter(I_xy, filter);

%%
% Compute a scalar interest measure. i.e. Find points whose surrounding 
% window gave large corner response
% i.e. (f > threshold).
response = ((I_xxg.*I_yyg)-(I_xyg.*I_xyg)) - alpha*(I_xxg + I_yyg).^2;

%%
% Find local maxima above a certain threshold and report them as detected
% feature point locations. 

points = response;
end