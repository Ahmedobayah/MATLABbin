function [rot_i, rot_j]=rotate_spot(s,i,j,angle)
marker=zeros(s(1:2));
marker(j,i)=66;
marker_rot = imrotate(marker,angle,'bicubic','loose');
[rot_i,rot_j]=find(marker_rot==max(marker_rot(:)));