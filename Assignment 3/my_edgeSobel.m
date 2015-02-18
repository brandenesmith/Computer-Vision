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

horizontalGradient = imfilter(image, horizontalOperator);
verticalGradient = imfilter(image, verticalOperator);

unThresholdedMagnitude = horizontalGradient + verticalGradient;
[height, width, channels] = size(unThresholdedMagnitude);

edgeMagnitude = zeros(height, width, channels);

unThresholdedRed = unThresholdedMagnitude(:,:,1);
unThresholdedGreen = unThresholdedMagnitude(:,:,2);
unThresholdedBlue = unThresholdedMagnitude(:,:,3);

thresholdedRed = threshold(unThresholdedRed, THRESHOLD_VAL);
thresholdedGreen = threshold(unThresholdedGreen, THRESHOLD_VAL);
thresholdedBlue = threshold(unThresholdedBlue, THRESHOLD_VAL);

edgeMagnitude(:,:, 1) = thresholdedRed;
edgeMagnitude(:,:, 2) = thresholdedGreen;
edgeMagnitude(:,:, 3) = thresholdedBlue;

    function thresholdedChannel = threshold(image, THRESHOLD_VAL)
        [x,y,z] = size(image);
        thresholdedChannel = zeros(x,y,z);
        
        for i=1:x
            for j=1:y
                if (image(i,j) >= THRESHOLD_VAL)
                    thresholdedChannel(i,j) = image(i,j);
                end
            end
        end
    end

edgeOrientation = zeros();
end

