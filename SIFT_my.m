%% preconduct
clear all
close all
clc

PWF=imread('./data/patches0000.bmp');
VV=imread('./data/patches0001.bmp');

rPWF=gray2r(PWF);
rVV = gray2r(VV);

% PWF=rgb2gray(imread('../MATLABbin/data/1509292059f1270b98bdc2d73e.jpg'));
% VV=rgb2gray(imread('../MATLABbin/data/1509292100b22e60f6eb91963a.jpg'));
% 
% rPWF=imread('../MATLABbin/data/1509292059f1270b98bdc2d73e.jpg');
% rVV=imread('../MATLABbin/data/1509292100b22e60f6eb91963a.jpg');

PWF=single(PWF);
VV=single(VV) ;
%% SIFT detecting 

[fm,dm]=vl_sift(PWF);
[ft,dt] = vl_sift(VV);

figure
image(rPWF);

sel =  randperm(size(fm,2)) ;
h1 = vl_plotframe(fm(:,sel)) ;
h2 = vl_plotframe(fm(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;

figure
image(rVV);

sel = randperm(size(ft,2)) ;
h1 = vl_plotframe(ft(:,sel)) ;
h2 = vl_plotframe(ft(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;

%% matching

[matches, scores] = vl_ubcmatch(dm, dt,1.1) ;

oo=size(PWF,2);

matches_num=size(matches,2);
combine=[PWF,VV];

figure
imagesc([rPWF,rVV]);
hold on;

for i=1:matches_num
    plot([fm(1,matches(1,i)) ft(1,matches(2,i))+oo],[fm(2,matches(1,i)) ft(2,matches(2,i))]);
    
    plot(fm(1,matches(1,i)),fm(2,matches(1,i)),'o')
    plot(ft(1,matches(2,i))+oo,ft(2,matches(2,i)),'ro')
    
    [score_max,score_idx]=max(scores);
    m_idx=matches(1,score_idx);
    t_idx=matches(2,score_idx);
    h=plot([fm(1,m_idx) ft(1,t_idx)+oo],[fm(2,m_idx) ft(2,t_idx)]);
    set(h,'LineWidth',3);
    
    
    hold on;
end
