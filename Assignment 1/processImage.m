% Instantiate filename
filename = 'IMG_7264.jpg';

myImage = imread(filename);
imtool(myImage);

myImageInfo = imfinfo(filename);
display(myImageInfo);

myImageGray = rgb2gray(myImage);
imtool(myImageGray)

myImageGrayInfo = imfinfo('IMG_7264_Gray.jpg');
display(myImageGrayInfo)

% Examine the histogram of the grayscale image. 
originalHist = figure('Name', 'Original Histogram', 'Numbertitle', 'off');
originalHist; histogram(myImageGray)

% Image resizing. 
myImageGrayDouble = imresize(myImageGray, 2);
myImageGrayHalf = imresize(myImageGray, 0.5);

% Examine the Double sized and Half sized image
imtool(myImageGrayDouble)
imtool(myImageGrayHalf)

% Create and display histograms for both the double and half sized image.
dblHist = figure('Name', 'Double Histogram', 'NumberTitle', 'off');
dblHist; histogram(myImageGrayDouble)

halfHist = figure('Name', 'Half Histogram', 'NumberTitle', 'off');
halfHist; histogram(myImageGrayHalf)

% Save all of the images. 
imwrite(myImageGray, 'IMG_7264_Gray.jpg');
imwrite(myImageGrayDouble, 'IMG_7264_Gray_Double.jpg');
imwrite(myImageGrayHalf, 'IMG_7264_Gray_Half.jpg');

newCheckerboard = checkerboard();
imtool(newCheckerboard)

imwrite(newCheckerboard, 'checkerboard.jpg');