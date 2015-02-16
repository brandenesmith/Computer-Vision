% Before trying to construct hybrid images, it is suggested that you
% implement my_imfilter.m and then debug it using test_filtering.m

% Debugging tip: You can split your MATLAB code into cells using "%%"
% comments. The cell containing the cursor has a light yellow background,
% and you can press Ctrl+Enter to run just the code in that cell. This is
% useful when projects get more complex and slow to rerun from scratch

close all; % closes all figures

%% Setup
% read images and convert to floating point format
% assumes that there is a data folder with images one level up
image1 = im2single(imread('./_data/dog.bmp'));
image2 = im2single(imread('./_data/cat.bmp'));
image3 = im2single(imread('./_data/bird.bmp'));
image4 = im2single(imread('./_data/plane.bmp'));
image5 = im2single(imread('./_data/bicycle.bmp'));
image6 = im2single(imread('./_data/motorcycle.bmp'));
image7 = im2single(imread('./_data/marilyn.bmp'));
image8 = im2single(imread('./_data/einstein.bmp'));
image9 = im2single(imread('./_data/fish.bmp'));
image10 = im2single(imread('./_data/submarine.bmp'));


% Several additional test cases are provided for you, but feel free to make
% your own (you'll need to align the images in a photo editor such as
% Photoshop). The hybrid images will differ depending on which image you
% assign as image1 (which will provide the low frequencies) and which image
% you asign as image2 (which will provide the high frequencies)

%% Filtering and Hybrid Image construction
cutoff_frequency = 8; 
cutoff_frequency2 = 5;
cutoff_frequency3 = 11; 
cutoff_frequency4 = 7; 
cutoff_frequency5 = 6; %This is the standard deviation, in pixels, of the 
% Gaussian blur that will remove the high frequencies from one image and 
% remove the low frequencies from another image (by subtracting a blurred
% version from the original version). You will want to tune this for every
% image pair to get the best results.
filter = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
filter2 = fspecial('Gaussian', cutoff_frequency2*4+1, cutoff_frequency2);
filter3 = fspecial('Gaussian', cutoff_frequency3*4+1, cutoff_frequency3);
filter4 = fspecial('Gaussian', cutoff_frequency4*4+1, cutoff_frequency4);
filter5 = fspecial('Gaussian', cutoff_frequency5*4+1, cutoff_frequency5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE BELOW. Use my_imfilter create 'low_frequencies' and
% 'high_frequencies' and then combine them to create 'hybrid_image'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the high frequencies from image1 by blurring it. The amount of
% blur that works best will vary with different image pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

low_frequencies = my_imfilter(image1, filter);
low_frequencies2 = my_imfilter(image3, filter2);
low_frequencies3 = my_imfilter(image5, filter3);
low_frequencies4 = my_imfilter(image7, filter4);
low_frequencies5 = my_imfilter(image9, filter5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the low frequencies from image2. The easiest way to do this is to
% subtract a blurred version of image2 from the original version of image2.
% This will give you an image centered at zero with negative values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

image2_blurred = my_imfilter(image2, filter);
high_frequencies = image2 - image2_blurred;

image4_blurred = my_imfilter(image4, filter2);
high_frequencies2 = image4 - image4_blurred;

image6_blurred = my_imfilter(image6, filter3);
high_frequencies3 = image6 - image6_blurred;

image8_blurred = my_imfilter(image8, filter4);
high_frequencies4 = image8 - image8_blurred;

image10_blurred = my_imfilter(image10, filter5);
high_frequencies5 = image10 - image10_blurred;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine the high frequencies and low frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hybrid_image = low_frequencies + high_frequencies;
hybrid_image2 = low_frequencies2 + high_frequencies2;
hybrid_image3 = low_frequencies3 + high_frequencies3;
hybrid_image4 = low_frequencies4 + high_frequencies4;
hybrid_image5 = low_frequencies5 + high_frequencies5;

%% Visualize and save outputs
figure(1); imshow(low_frequencies)
figure(2); imshow(high_frequencies + 0.5);
vis = vis_hybrid_image(hybrid_image);
figure(3); imshow(vis);
imwrite(low_frequencies, './_output/low_frequencies.jpg', 'quality', 95);
imwrite(high_frequencies + 0.5, './_output/high_frequencies.jpg', 'quality', 95);
imwrite(hybrid_image, './_output/hybrid_image.jpg', 'quality', 95);
imwrite(vis, './_output/hybrid_image_scales.jpg', 'quality', 95);

%% Visualize and save outputs for second set.
figure(4); imshow(low_frequencies2)
figure(5); imshow(high_frequencies2);
vis2 = vis_hybrid_image(hybrid_image2);
figure(6); imshow(vis2)
imwrite(low_frequencies2, './_output/low_frequencies2.jpg', 'quality', 95);
imwrite(high_frequencies2 + 0.5, './_output/high_frequencies2.jpg', 'quality', 95);
imwrite(hybrid_image2, './_output/hybrid_image2.jpg', 'quality', 95);
imwrite(vis2, './_output/hybrid_image_scales2.jpg', 'quality', 95);

%% Visualize and save outputs for third set.
figure(7); imshow(low_frequencies3)
figure(8); imshow(high_frequencies3);
vis3 = vis_hybrid_image(hybrid_image3);
figure(9); imshow(vis3)
imwrite(low_frequencies3, './_output/low_frequencies3.jpg', 'quality', 95);
imwrite(high_frequencies3 + 0.5, './_output/high_frequencies3.jpg', 'quality', 95);
imwrite(hybrid_image3, './_output/hybrid_image3.jpg', 'quality', 95);
imwrite(vis3, './_output/hybrid_image_scales3.jpg', 'quality', 95);

%% Visualize and save outputs for fourth set.
figure(10); imshow(low_frequencies4)
figure(11); imshow(high_frequencies4);
vis4 = vis_hybrid_image(hybrid_image4);
figure(12); imshow(vis4)
imwrite(low_frequencies4, './_output/low_frequencies4.jpg', 'quality', 95);
imwrite(high_frequencies4 + 0.5, './_output/high_frequencies4.jpg', 'quality', 95);
imwrite(hybrid_image4, './_output/hybrid_image4.jpg', 'quality', 95);
imwrite(vis4, './_output/hybrid_image_scales4.jpg', 'quality', 95);

%% Visualize and save outputs for fourth set.
figure(13); imshow(low_frequencies5)
figure(14); imshow(high_frequencies5);
vis5 = vis_hybrid_image(hybrid_image5);
figure(15); imshow(vis5)
imwrite(low_frequencies5, './_output/low_frequencies5.jpg', 'quality', 95);
imwrite(high_frequencies5 + 0.5, './_output/high_frequencies5.jpg', 'quality', 95);
imwrite(hybrid_image5, './_output/hybrid_image5.jpg', 'quality', 95);
imwrite(vis5, './_output/hybrid_image_scales5.jpg', 'quality', 95);

