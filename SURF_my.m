%% preconduct
clear all
close all
clc

PWF=imread('./data/AsubImage6_10.png');
VV=imread('./data/BsubImage6_10.png');

figure
P_SURF_points = detectSURFFeatures(PWF);
imshow(PWF); hold on;
plot(P_SURF_points.selectStrongest(10));

figure
V_SURF_points = detectSURFFeatures(VV);
imshow(VV); hold on;
plot(V_SURF_points.selectStrongest(10));

