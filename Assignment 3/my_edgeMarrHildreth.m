%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_edgeMarrHildreth.m
%
% Author: Branden E. Smith & Mathew Reny
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function edgeMagnitude = my_edgeMarrHildreth(image, sigma)

% Determine filter size N = [sigma x 3] x 2 + 1 and the
% size of the image.
N = ceil(sigma * 3)*2 + 1;
[height, width, channels] = size(image);

log = fspecial('log', N, sigma);
conv = double(imfilter(image, log));

% Threshold the image
conv = im2bw(conv, 0);

padded = padarray(conv, [1,1]);
edgeMagnitude = zeros(height, width, channels);

% Zero Crossings
for i=1:height
    for j=1:width
        if (padded(i+1, j+1) == 0)
            A = padded(i:(i+2) , j:(j+2));
            colSum = sum(A);
            totSum = sum(colSum);
            if (totSum == 0)
                edgeMagnitude(i,j) = 1;
            end
        end
    end
end

end