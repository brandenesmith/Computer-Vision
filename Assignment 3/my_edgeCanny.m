%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_edgeCanny.m
%
% Author: Branden E. Smith & Mathew Reny
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function canny = my_edgeCanny(image, L, H, sigma)

% Setup
[height, width, channels] = size(image);

% Filter Size
N = ceil(sigma *3)*2 + 1;

% Filter image with the x,y derivatives of the Gaussian
gaussian = fspecial('Gaussian', N, sigma);
gaussianImage = imfilter(image, gaussian);

partialX = [-1 1];
partialY = [-1; 1];

derivOfGaussianX = double(imfilter(gaussianImage, partialX));
derivOfGaussianY = double(imfilter(gaussianImage, partialY));

% Find magnitude and orientation of gradient
xSquared = derivOfGaussianX.^2;
ySquared = derivOfGaussianY.^2;

gradientMagnitude = double(sqrt(xSquared + ySquared));

% Non-maximum suppression (Thin multi-pixel "ridges" down to single pixel
% width

tempValues = ones(height, width, channels);
tempValues = floor(gradientMagnitude./H);
tempValues = tempValues./tempValues;

boxFilter = [1 1 1; 1 1 1; 1 1 1];

filtered = ones(height, width, channels);

while (max(filtered(:)) >= 1)
    tempValues(isnan(tempValues)) = 0;
    filtered = imfilter(tempValues, boxFilter);
    filtered = filtered./filtered;
    filtered = filtered - tempValues;
    filtered(isnan(filtered)) = 0;
    filtered = floor(gradientMagnitude./L).*filtered;
    tempValues = tempValues + filtered;
    tempValues = tempValues./tempValues;
end

canny = im2bw(tempValues, 0);
end