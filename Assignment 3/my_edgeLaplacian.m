%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_edgeLaplacian.m
%
% Author: Branden E. Smith & Mathew Reny
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function edgeMagnitude = my_edgeLaplacian(image, THRESHOLD)

% Get the size of the image.
[height, width, channels] = size(image);

laplacianOperator = [-2 1 -2; 1 4 1; -2 1 -2];

% Other laplaician operators
% laplacianOperator = [-1 -1 -1; -1 8 -1; -1 -1 -1];
% laplacianOperator = [0 -1 0; -1 4 -1; 0 -1 0];

edgeMagnitude = double(imfilter(image, laplacianOperator));

% Itterating through the channels of the image allow it to take both
% color and grayscale images. 
for c=1:channels
    for i=1:height
        for j=1:width
            if (edgeMagnitude(i,j,c) < THRESHOLD)
                edgeMagnitude(i,j,c) = 0;
            end
        end
    end
end
end