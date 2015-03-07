%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get_interest_points.m
%
% Author: Branden E. Smith
%
% Finds interesting points (corners) in an image and returns them.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [points, locations] = get_interest_points(image)
% Sigma for Gaussian Blur
SIGMA = 1;
ALPHA = .04;

% Image size information (if needed).
[x, y, channels] = size(image);

if (channels > 1)
    image = rgb2gray(image);
end

%%
% Compute the horizontal and vertical derivatives of the image by
% convolving the original image with derivatives of Guassians.
gaussian_1 = fspecial('Gaussian', 3, SIGMA);
gaussian_2 = fspecial('Gaussian', 7, SIGMA);
image = double(imfilter(image, gaussian_1));

% Partial derivative filters
d_x = [-1 0 1; -1 0 1; -1 0 1];
d_y = transpose(d_x);

% Filter the image with partial derivative filters.
I_x = imfilter(image, d_x);
I_y = imfilter(image, d_y);

%%
% Compute the three images corresponding to the outer products of these
% gradients. (The matrix is symmetric, so only three entries are needed.
I_xx = I_x.^2;
I_yy = I_y.^2;
I_xy = I_x.*I_y;

%%
% Convolve each of these images with a larger Gaussian.
I_xxg = imfilter(I_xx, gaussian_2);
I_yyg = imfilter(I_yy, gaussian_2);
I_xyg = imfilter(I_xy, gaussian_2);

%%
% Compute a scalar interest measure. i.e. Find points whose surrounding
% window gave large corner response
% i.e. (f > threshold).
response = ((I_xxg.*I_yyg)-(I_xyg.^2)) - ALPHA*(I_xxg + I_yyg).^2;

%%
% Find local maxima above a certain threshold and report them as detected
% feature point locations.

% Create a padded array to traverse for non-max suppresion.
padded = padarray(response, [1, 1], 0);

% Pre-allocate points for speed
points = zeros(x, y);
locations = [];

for i=1:x
    for j=1:y
        A = padded(i:(i+2), j:(j+2));
        max_column_vals = max(A);
        max_val = max(max_column_vals);
        if (max_val == A(2, 2) && max_val > 300000)
            points(i,j) = max_val;
            location = [j, i];
            locations = [locations; location];
        end
    end
end

locations = cornerPoints(locations);
end