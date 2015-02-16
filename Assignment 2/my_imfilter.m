function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
%output = imfilter(image, filter);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% How the filtering actually happens.
% h[x,y] = \sum_{k,l} g[k,l]f[x+k, y+l]

% The algorithm cannot use filters with even dimensions so
% it must throw an exception if even filter dimenstions are
% provided.
[width,height] = size(filter);
if (mod(width,2) == 0 || mod(height, 2) == 0)
    msgID = 'filter:inputError';
    msgText = 'Filter dimensions must be odd';
    exception = MException(msgID, msgText);
    throw(exception);
end


% Get the size of the image and the number of channels.
[x,y,c] = size(image);

% Allocate the space for the output image to avoid
% dynamically resizing.
output = zeros(x,y,c);

% The algorithm must handle color images and grayscale images.
% Thus if the images is three channels we will filter each
% channel separately and combine them in the output.
if (c == 3)
    red = image(:,:,1);
    green = image(:,:,2);
    blue = image(:,:,3);
    
    % We combine the filtered channels as the output.
    output(:,:,1) = filterChannel(red, filter);
    output(:,:,2) = filterChannel(green, filter);
    output(:,:,3) = filterChannel(blue, filter);
    
elseif (c == 1)
    output = filterChannel(image, filter);
end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Helper function to actually do the filtering
    % on three channel images this needs to be
    % called three times.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function filtered = filterChannel(img, filter)
        % Get the size of the filter
        [r,s] = size(filter);
        
        % Get the size of the image.
        [p, q, c2] = size(img);
        
        % Padd the edges of the image.
        paddedImg = padarray(img, [ceil(r/2), ceil(s/2)], 'symmetric');
        
        %pre-allocate the size of the filtered image for efficiency.
        filtered = zeros(p, q, c2);
        
        for i = 1:p
            for j = 1:q
                A = paddedImg(i:(i+(r-1)), j:(j+(s-1)));
                A = A.*filter;
                value = sum(sum(A));
                filtered(i,j) = value;
            end
        end
    end
end



