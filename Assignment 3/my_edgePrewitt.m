%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_edgePrewitt.m
%
% Author: Branden E. Smith & Mathew Reny
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [edgeMagnitude, edgeOrientation] = my_edgePrewitt(image, THRESHOLD)

% Get the size of the image.
[height, width, channels] = size(image);

% The prewitt operators.
horizontalOperator = [-1 0 1; -1 0 1; -1 0 1];
verticalOperator = [-1 -1 -1; 0 0 0; 1 1 1];


horizontalGradient = double(imfilter(image, horizontalOperator));
verticalGradient = double(imfilter(image, verticalOperator));

% Get the magnitude.
horizontalSquared = horizontalGradient.^2;
verticalSquared = verticalGradient.^2;
sumOfSquared = horizontalSquared + verticalSquared;
edgeMagnitude = sqrt(sumOfSquared);

edgeOrientation = atan(verticalGradient./horizontalGradient);


for c=1:channels
    for i=1:height
        for j=1:width
            if (edgeMagnitude(i,j,c) < THRESHOLD)
                edgeMagnitude(i,j,c) = 0;
            end
            if (edgeMagnitude(i,j,c) == 0)
                edgeOrientation(i,j,c) = -inf;
            end
        end
    end
end
