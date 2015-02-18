%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_edgeSobel.m
% 
% Author Branden E. Smith & Mathew Reny
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [edgeMagnitued, edgeOrientation] = my_edgeSobel(image, THRESHOLD_VAL)

% Partial derivatives (discrete) with respect to x and y.
partialX = image(x+1, y) - image(x,y);
partialY = image(x, y+1) - image(x,y);

% The two sobel operators that are commonly used
% the first horizontalOperator shold be scaled by the partial with 
% respect to x and the verticalOperator should be scaled with respect to
% y
horizontalOperator = [-1 0 1; -2 0 2; -1 0 1];
verticalOperator = [1 2 1; 0 0 0; -1 -2 -1];

