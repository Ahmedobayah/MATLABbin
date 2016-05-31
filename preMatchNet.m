%% read the images
% we place each pair of patches from two images together
clear
close all
clc

A=imread('./data/LDualPWF1.bmp');
B=imread('./data/LDualVV1.bmp');

C=[];
D=[];

E=cell(1,256);

%% processing
for i=1:16
    for j=1:16
        Acrop=imcrop(A,[(64*(j-1)+1) (64*(i-1)+1) 63 63]);

        Bcrop=imcrop(B,[(64*(j-1)+1) (64*(i-1)+1) 63 63]);

        E{16*(i-1)+j}=[im2double(Acrop),im2double(Bcrop)];

    end
end

        E=cell2mat(E);

        for i=1:16
            C((64*(i-1)+1):(64*i),1:1024)=E(1:64,(1024*(i-1)+1):(1024*i));
        end
        
         for i=1:16
            D((64*(i-1)+1):(64*i),1:1024)=E(1:64,(1024*(i-1)+16385):(1024*i+16384));
        end
        
        
%% show and save
figure
imshow(C);
imwrite(C,'C.bmp')
hold off;

figure
imshow(D);
imwrite(D,'D.bmp')
hold off;
%% note that the x and y in image processing function are different from those in matrix
