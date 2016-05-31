%% read the data
clear 
close all
clc

HH=imread('./data/5149_LDualHH1.bmp');
s=size(HH);
% angle=randi(360);
angle=52;
range_origin=[-512 512];


tform = affine2d([cosd(angle) -sind(angle) 0; sind(angle) cosd(angle) 0; 0 0 1]);
HHro=imrotate(HH,angle,'bilinear','loose');
range_rotate=[-size(HHro,1)/2,size(HHro,1)/2];

if (angle>90 && angle<=180);
   theta=angle-90;
elseif (angle>180 && angle<=270);
   theta=angle-180;
elseif (angle>270 && angle<=360);
   theta=angle-270;
else
    theta=angle;
end

a=256*sqrt(2)*cos((45-theta)*pi/180);

x_origin=a-512+(1024-2*a)*rand(1);
y_origin=a-512+(1024-2*a)*rand(1);

[x_rotate,y_rotate]=transformPointsForward(tform,x_origin,y_origin);

figure
image(range_origin,range_origin,HH);
hold on
plot(x_origin,y_origin,'ro');
hold off;

figure
image(range_rotate,range_rotate,HHro);
hold on
plot(x_rotate,y_rotate,'ro');
hold off;

figure
HH_cut=imcrop(HHro,[x_rotate-128 y_rotate-128 256 256]);
imshow(HH_cut);

