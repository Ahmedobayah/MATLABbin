%% preconduct
clear all
close all
clc

PWF=imread('./data/patches0002.bmp');
VV=imread('./data/294_797_712.bmp');

rPWF=gray2r(PWF);
rVV = gray2r(VV);

[matches,scores,f1,f2]=sift_mosaic(PWF,VV,rPWF,rVV);
