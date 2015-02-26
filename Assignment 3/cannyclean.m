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
g = imfilter(image, gaussian);

partialX = [-1 1];
partialY = [-1; 1];

dogx = double(imfilter(g, partialX));
dogy = double(imfilter(g, partialY));

% Find magnitude and orientation of gradient
gmag = double(sqrt(dogx.^2 + dogy.^2));

% Non-maximum suppression
% edges = ones(height, width, channels);
edges = floor(gmag./H); % throw away values less than H
edges = edges./edges;   % set nonzero values to 1.

% This will be used to create a 3x3 window around 
% nonzero pixels in any direction.
meanFilter = [1 1 1; 1 1 1; 1 1 1];

% Throw away magnitudes less than the lower threshold
% here to save computation within the while loop.
gmagGtL = floor(gmag./L);

% create 'filtered' here so that we can use it within
% the while loop.
filtered = ones(height, width, channels);

% loop until the filtered image has 
% no more paths to follow.
while (max(filtered(:)) >= 1)
	% remove NaN from the matrix.
	edges(isnan(edges)) = 0; 

	% apply the mean filter to the edges.
	% This will create a 3x3 window of 
	% nonzero values around detected edges.
	filtered = imfilter(edges, meanFilter);
	
	% set nonzero values to 1 since the filter
	% will only look within the 3x3 windows and
	% all we need to know is whether or not an
	% element is interesting.	
	filtered = filtered./filtered;
	
	% remove already detected edges since
	% we already know they are in the final
	% binary image we create.
	filtered = filtered - edges;
	
	% remove NaN from the matrix.
	filtered(isnan(filtered)) = 0;
	
	% Throw away values within the created
	% windows that are lower than L by 
	% multiplying by the filtered image which
	% contains only ones. Any gradient magnitude
	% that is above L is then added to the 
	% edges matrix.
	filtered = gmagGtL.*filtered;
	edges = edges + filtered;
	edges = edges./edges;
end

% collapse the channels and return a binary image
canny = im2bw(edges, 0);
end
