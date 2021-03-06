%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_edgeSobel.m
%
% Author Branden E. Smith & Mathew Reny
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [edgeMagnitude, edgeOrientation] = my_edgeSobel(image, THRESHOLD_VAL)

% The two sobel operators that are commonly used
% the first horizontalOperator shold be scaled by the partial with
% respect to x and the verticalOperator should be scaled with respect to
% y. Omitting the 1/8 th term makes no difference in edge detection 
% however, it is necessary for computing the correct gradient. 
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

% The direction of the gradient (theta) is the tangent inverse of
% partial with respct to y divided by the partial with respect to x
edgeOrientation = atan(verticalGradient./horizontalGradient);

% For each channel if the value of the edgeMagnitude image is greater
% than the threhold keep it otherwise set the value to zero.
% We also clean up the edgeOrientation image. It is ok for an edge to have 
% the orientation zero however, if there is no edge in the magnitude image
% there should be no oritentation edge in the orientation image. 
for c=1:channels
    for k=1:height
        for l=1:width
            if (edgeMagnitude(k,l,c) < THRESHOLD_VAL)
                edgeMagnitude(k,l,c) = 0;
            end
            if (edgeMagnitude(k,l,c) == 0)
                edgeOrientation(k,l,c) = -inf;
            end
        end
    end
end

end