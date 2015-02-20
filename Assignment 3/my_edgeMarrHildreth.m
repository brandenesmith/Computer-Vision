%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_edgeMarrHildreth.m
% 
% Author: Branden E. Smith & Mathew Reny
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function edgeMagnitude = my_edgeMarrHildreth(image, sigma)

% Determine filter size N = [sigma x 3] x 2 + 1
N = (sigma * 3)*2 + 1;

% Differential Operators
partialX = [0 0 0; 0 -1 1; 0 0 0];
partialY = [0 0 0; 0 -1 0; 0 1 0];

% Gaussian filter of size N as shown on the slide in class.
G = double(zeros(N));

for i=1:N
    for j=1:N
        G(i,j) = exp(-(i^2 + j^2)/(2*pi*(sigma^2)));
    end
end

% Step one
iPrime = imfilter(image, G);

% Take the first Derivative of iPrime
iPrimeFirstDerivX = imfilter(iPrime, partialX);
iPrimeFirstDerivY = imfilter(iPrime, partialY);

% Take the second Derivative of iPrime
iPrimeSecondDerivX = imfilter(iPrimeFirstDerivX, partialX);
iPrimeSecondDerivY = imfilter(iPrimeFirstDerivY, partialY);

iDoublePrime = iPrimeSecondDerivX + iPrimeSecondDerivY;

edgeMagnitude = iDoublePrime;

end