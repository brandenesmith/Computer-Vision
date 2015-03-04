%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get_interest_points.m
%
% Author: Branden E. Smith
%
% Finds interesting points (corners) in an image and returns them.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function points = get_interest_points(image)
% Sigma for Gaussian Blur
SIGMA = 7;

% Image size information (if needed).
[x, y, z] = size(image);

%%
% Compute the horizontal and vertical derivatives of the image by
% convolving the original image with derivatives of Guassians.

filter = fspecial('Gaussian', 7, SIGMA);
image = imfilter(image, filter);

% Partial derivative filters
partialX = [-1 1];
partialY = [-1; 1];

% Filter the image with partial derivative filters.
partialX = imfilter(image, partialX);
partialY = imfilter(image, partialY);

% Square the partial derivative images.
partial_x_squared = partialX.*partialX;
partial_y_squared = partialY.*partialY;

% Convert Partials to Gray
partial_x_squared = rgb2gray(partial_x_squared);
partial_y_squared = rgb2gray(partial_y_squared);

%%
% Compute the three images corresponding to the outer products of these
% gradients. (The matrix is symmetric, so only three entries are needed.


%%
% Convolve each of these images with a larger Gaussian.

%%
% Compute a scalar interest measure. i.e. Find points whose surrounding 
% window gave large corner response
% i.e. (f > threshold).

%%
% Find local maxima above a certain threshold and report them as detected
% feature point locations. 


end