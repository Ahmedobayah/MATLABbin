% The functuion of this module is cut a patch from a given picture with a
% random angle and location.
%% read the data
clear all
close all
clc

HH=imread('/media/yiran/8C0C246D0C24550C/Program Files/MATLAB/R2014b/bin/MATLABbin/result/beautyTest/patches0000.bmp');
s=size(HH);

%% rotate and calculation
angle=randi(360);
HHro=imrotate(HH,angle,'bicubic','loose');

for i_my=1:16
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

    pause(3);
    
    figure,
    imshow(HH);
    hold on;
    plot(x_origin,y_origin,'ro');
    hold off;

    pause(3);
    
    figure,
    imshow(HHro);
    hold on;
    plot(x_rotate,y_rotate,'ro');
    hold off;

    figure,
    HH_cut=imcrop(HHro,[x_rotate-128 y_rotate-128 255 255]);
    imshow(HH_cut);

    imwrite(HH_cut, ['./result/beauty_cut/',num2str(angle),'_',num2str(x_origin),'_',num2str(y_origin),'.bmp'],'bmp');
end
