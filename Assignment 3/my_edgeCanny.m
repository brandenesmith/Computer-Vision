%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_edgeCanny.m
%
% Author: Branden E. Smith & Mathew Reny
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function canny = my_edgeCanny(image, L, H, sigma)

% Setup
[height, width, channels] = size(image);

% Filter image with the x,y derivatives of the Gaussian
gaussian = fspecial('Gaussian', [5, 5], sigma);
gaussianImage = imfilter(image, gaussian);

partialX = [-1 1];
partialY = [-1; 1];

derivOfGaussianX = double(imfilter(gaussianImage, partialX));
derivOfGaussianY = double(imfilter(gaussianImage, partialY));

% Find magnitude and orientation of gradient
xSquared = derivOfGaussianX.^2;
ySquared = derivOfGaussianY.^2;

gradientMagnitude = double(sqrt(xSquared + ySquared));

% Threshold magnitude at min value
for c=1:channels
    for i=1:height
        for j=1:width
            if (gradientMagnitude(i,j,c) < L)
                gradientMagnitude(i,j,c) = 0;
            end
        end
    end
end

gradientOrientation = double(atan(derivOfGaussianY./derivOfGaussianX));

% Non-maximum suppression (Thin multi-pixel "ridges" down to single pixel
% width

% Hysteresis thresholding and linking
% -Define two thresholds: low and high
% -Use the high threshold to start edge curves and the
%  low to continue them
canny = gaussianImage;
end