% The function of this module is to locate the 256*256 patch in the bigger
% image, so that we can find every matched pairs of 64*64 patches with
% MatchNet.
%JUST ONE 256*256

clear
close all
clc

%% load the images
addpath('../Pre_MatchNet/');

A = imread('/home/yiran/matchnet test/data/phototour/notredame/4pSuccessTest/patches0003.bmp');
B = imread('/home/yiran/matchnet test/data/phototour/notredame/4pSuccessTest/patches0002.bmp');
%% statement
D=zeros(4,4,4,4);

E=cell(4,4);
F=cell(4,4);

G=cell(4,4);
H=cell(4,4);

matchIndex=[];
matchPatch=[];

%% cut the image and save them
for i=1:4
    for j=1:4
        Acrop=imcrop(A,[(256*(j-1)+1) (256*(i-1)+1) 255 255]);

        Bcrop=imcrop(B,[(256*(j-1)+1) (256*(i-1)+1) 255 255]);

        E{i,j}=im2double(Acrop);
        F{i,j}=im2double(Bcrop);
        
        G{i,j}=(layerFea(Acrop,40))';
        H{i,j}=(layerFea(Bcrop,40))';
        
    end
end

%% calculate the euclidean distance
for i=1:4
    for j=1:4
        for k=1:4
             for l=1:4
                 
                 D(i,j,k,l)=pdist([G{i,j};H{k,l}],'euclidean');  % euclidean distance
                 
             end
        end
    end
end
 
%% save the match index and patches
for i=1:4
    for j=1:4
        ind = find(D==min(D(i,j,:)));
        [i1,j1,k_min,l_min] = ind2sub([4 4 4 4],ind);
        
        matchIndex=[matchIndex;i1,j1,k_min,l_min];
        matchPatch=[matchPatch;E{i1,j1},F{k_min,l_min}];
    end
end

%% show the image
for i=1:16
   figure, imshow(matchPatch(256*(i-1)+1:256*(i),:))
end

%% read the file and write our data into them

ind = find(D==min(D(:)));
[i_min,j_min,k_min,l_min] = ind2sub([4 4 4 4],ind);

write_txt(matchIndex,'./result/m50.txt')
