% The function of this script is cut a 1024*1024 picture into 16 random subimage(256*256),
% then combine these subimages into 5 large(1024*1024) images.
%% read the data
clear all
close all
clc

HH=imread('./data/beautyTest.bmp');
s=size(HH);

A1=[];

E=cell(1,16);

%% rotate and calculation
angle=randi(360);
HHro=imrotate(HH,angle,'bicubic','loose');


for i=1:16
   if (angle>90 && angle<=180);
       theta=angle-90;
   elseif (angle>180 && angle<=270);
       theta=angle-180;
   elseif (angle>270 && angle<=360);
       theta=angle-270;
   else
       theta=angle;
   end

    a=128*sqrt(2)*cos((45-theta)*pi/180);

    x_origin=round(a+(1024-2*a)*rand(1));
    y_origin=round(a+(1024-2*a)*rand(1));

    [y_rotate,x_rotate]=rotate_spot(s,x_origin,y_origin,angle);

%     figure,
%     imshow(HH);
%     hold on;
%     plot(x_origin,y_origin,'ro');
%     hold off;
%
%     figure,
%     imshow(HHro);
%     hold on;
%     plot(x_rotate,y_rotate,'ro');
%     hold off;
%
%     figure,
   HH_cut=imcrop(HHro,[x_rotate-128 y_rotate-128 255 255]);
%     imshow(HH_cut);
   imwrite(HH_cut, ['./result/beauty_cut/',num2str(angle),'_',num2str(x_origin),'_',num2str(y_origin),'.bmp'],'bmp');

   E{1,i}=[im2double(HH_cut)];

end

E=cell2mat(E);

for i=1:4
   A1(256*(i-1)+1:256*i,:)=E(:,1024*(i-1)+1:1024*i);
end

imshow(A1);
imwrite(A1,'A2.bmp');
