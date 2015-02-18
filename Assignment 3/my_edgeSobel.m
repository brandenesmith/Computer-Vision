%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_edgeSobel.m
%
% Author Branden E. Smith & Mathew Reny
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [edgeMagnitude, edgeOrientation] = my_edgeSobel(image, THRESHOLD_VAL)

% Partial derivatives (discrete) with respect to x and y.
% partialX = image(x+1, y) - image(x,y);
% partialY = image(x, y+1) - image(x,y);

% The two sobel operators that are commonly used
% the first horizontalOperator shold be scaled by the partial with
% respect to x and the verticalOperator should be scaled with respect to
% y
horizontalOperator = [-1 0 1; -2 0 2; -1 0 1];
verticalOperator = [1 2 1; 0 0 0; -1 -2 -1];

% Get the size of the image.
[height, width, channels] = size(image);

% Compute the horizontal and vertical gradients with double precision.
horizontalGradient = double (imfilter(image, horizontalOperator));
verticalGradient = double (imfilter(image, verticalOperator));

% The idea is that the magnitude of the gradient is the square root
% of the partial with respect to x squared plus the partial with respect
% to y squared. 
horizontalSquared = horizontalGradient.^2;
verticalSquared = verticalGradient.^2;
sumOfSquared = horizontalSquared + verticalSquared;
edgeMagnitude = sqrt(sumOfSquared);


% For each channel if the value of the edgeMagnitude image is greater
% than the threhold keep it otherwise set the value to zero. 
for c=1:channels
    for k=1:height
        for l=1:width
            if (edgeMagnitude(k,l,c) < THRESHOLD_VAL)
                edgeMagnitude(k,l,c) = 0;
            end
        end
    end
end

edgeOrientation = zeros(height, width, channels);
end

