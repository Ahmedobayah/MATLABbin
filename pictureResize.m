% The function of this module is resize 1024*1024 picture to 256*256
% image,then fill another 1024*1024 image with repeated 256 images.
%% input the data
clear all
close all
clc

C=zeros(1024,1024,'uint8');
C1=zeros(1024,1024,'uint8');
D=zeros(1024,1024,'uint8');
D1=zeros(1024,1024,'uint8');

A=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0000.bmp');
A1=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0001.bmp');
B=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0002.bmp');
B1=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0003.bmp');

%% Resize
A=imresize(A,0.25);
A1=imresize(A1,0.25);
B=imresize(B,0.25);
B1=imresize(B1,0.25);
%% joint
for i=1:4
    for j=1:4
        C(256*(i-1)+1:256*i,256*(j-1)+1:256*j)=A;
        C1(256*(i-1)+1:256*i,256*(j-1)+1:256*j)=A1;
        D(256*(i-1)+1:256*i,256*(j-1)+1:256*j)=B;
        D1(256*(i-1)+1:256*i,256*(j-1)+1:256*j)=B1;       
    end
end
%% Save
imwrite(C,'./result/resize/patches0000.bmp');
imwrite(C1,'./result/resize/patches0001.bmp');
imwrite(D,'./result/resize/patches0002.bmp');
imwrite(D1,'./result/resize/patches0003.bmp');