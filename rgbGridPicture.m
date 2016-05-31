function [ imgout ] =rgbGridPicture( PictureName , countForEachStep )
% input a gray picture,output a "rgbPicture"

imgout = imread( PictureName);  %# Load a sample 3-D RGB image
imgout=gray2r(imgout);
imgout(countForEachStep:countForEachStep:end,:,:) = 0;       %# Change every tenth row to black
imgout(:,countForEachStep:countForEachStep:end,:) = 0;       %# Change every tenth column to black

% imshow(imgout);                  %# Display the image

