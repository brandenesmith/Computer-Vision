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

% Compute M matrix for each image window to get their cornerness
% scores.

% (Optionally) blur the image and compute the 
% partial derivatives of the image with respect 
% to x and y. This can be tweeked to provide
% varying results. 
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


% Find points whose surrounding window gave large corner response
% i.e. (f > threshold).

% Take the points of local maxima, i.e., perform non-maximum suppression.

end