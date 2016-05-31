%% read the images
% we first cut the image,save them,and creat checkerboard chart,
clear all
close all
clc

A=imread('.\data\LDualPWF1.bmp');
B=imread('.\data\LDualVV1.bmp');
C=imread('.\data\LDualPWF1.bmp');
D=imread('.\data\LDualVV1.bmp');


%% processing
for i=1:16
    for j=1:16
        Ccrop=imcrop(C,[(64*(j-1)+1) (64*(i-1)+1) 63 63]);
        imwrite(Ccrop,['AsubImage',num2str(i),'_',num2str(j),'.png'],'png');%cut the image

        Dcrop=imcrop(D,[(64*(j-1)+1) (64*(i-1)+1) 63 63]);
        imwrite(Dcrop,['BsubImage',num2str(i),'_',num2str(j),'.png'],'png');%cut the image

         if(ceil(mod(i+j,2))~=0)
         A((64*(i-1)+1):(64*i),(64*(j-1)+1):(64*j))=Dcrop;%replacing

        B((64*(i-1)+1):(64*i),(64*(j-1)+1):(64*j))=Ccrop;%replacing
        end

        
    end
end

%% show and save
figure
imshow(A);
imwrite(A,'A.png')
hold off;

figure
imshow(B);
imwrite(B,'B.png')
hold off;
%% note that the x and y in image processing function are different from those in matrix
