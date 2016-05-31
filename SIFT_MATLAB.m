clear all
close all
clc

I1=rgb2gray(imread('../MATLABbin/data/1509292059f1270b98bdc2d73e.jpg'));
I2=rgb2gray(imread('../MATLABbin/data/1509292100b22e60f6eb91963a.jpg'));

rPWF=imread('../MATLABbin/data/1509292059f1270b98bdc2d73e.jpg');
rVV=imread('../MATLABbin/data/1509292100b22e60f6eb91963a.jpg');

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);

indexPairs = matchFeatures(f1, f2) ;
matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2(indexPairs(:, 2));

figure; ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage','Parent',ax);
title(ax, 'SIFT point matches');
legend(ax, 'Matched points 1','Matched points 2');