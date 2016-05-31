% The function of this module is display some pairs of match patches.
%% input the data
clear all
close all
clc

A=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0000.bmp');
A1=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0001.bmp');
B=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0002.bmp');
B1=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0003.bmp');

b=GridPicture('/home/yiran/matchnet test/data/phototour/notredame/patches0002.bmp',64);
b1=GridPicture('/home/yiran/matchnet test/data/phototour/notredame/patches0003.bmp',64);


rA=gray2r(A);
rA1=gray2r(A1);
rB=gray2r(B);
rB1=gray2r(B1);

rB=rgbGridPicture('/home/yiran/matchnet test/data/phototour/notredame/patches0002.bmp',64);
rB1=rgbGridPicture('/home/yiran/matchnet test/data/phototour/notredame/patches0003.bmp',64);

data1 = load('/home/yiran/matchnet test/scores_record.txt');
data2 = load('/home/yiran/matchnet test/data/phototour/notredame/m50_4096_4096_0.txt');
data3= load('/home/yiran/PYTHONbin/MatchNet/m50.txt');

%% statement of the variables

bestMPI=[];

HH_count=0;
VV_count=0;

[m,n]=size(data1);
[k,l]=size(data2);

E=cell(1,2*m);

oo=size(B,2);

scores=reshape(data1,[],1);

scrsz = get(0,'ScreenSize');
%% find the best match small patch of each big patch

for i_big=1:16
    
    m_x=((i_big-mod(i_big,4))/4)+1;
    m_y=mod(i_big,4);
    
    t_x=data3(4*(m_x-1)+m_y,3);
    t_y=data3(4*(m_x-1)+m_y,4);
    
    for i_small=1:16
        t_tmp=[];
        
        for i_t=1:16
            scores_v=scores(256*(i_big-1)+16*(i_small-1)+i_t,1);
             t_tmp=[t_tmp;scores_v];
        end        
        
        [c,j_tmp] = find(t_tmp==max(t_tmp(:)));

        bestMPI=[bestMPI;i_big,i_small,4*(t_x-1)+t_y,c];

    end
end

%% link the center of each pair of best match patches.
% We just plot one big patch this time

% 下次索引统一用二维的，调用前临时转
% 以下两个for循环为全画的
for i_big=1:16
    i_b=i_big-1;
    
    m_x=((i_b-mod(i_b,4))/4)+1;
    m_y=mod(i_b,4)+1;
    
    t_x=data3(4*(m_x-1)+m_y,3);
    t_y=data3(4*(m_x-1)+m_y,4);
    
    
    figure('Position',[0 30 scrsz(3) scrsz(4)-95]);
    imagesc([rB,rB1]);
    hold on;

    for i_small=1:16
        i_s=i_small-1;
        
        m_a=((i_s-mod(i_s,4))/4)+1;
        m_b=mod(i_s,4)+1;
        
        t_small=bestMPI(16*(i_big-1)+i_small,4);
        
        t_s=t_small-1;
        t_a=((t_s-mod(t_s,4))/4)+1;
        t_b=mod(t_s,4)+1;
        
        x1=256*(m_y-1)+64*(m_b-1)+32;
        x2=oo+256*(t_y-1)+64*(t_b-1)+32;
        
        y1=256*(m_x-1)+64*(m_a-1)+32;
        y2=256*(t_x-1)+64*(t_a-1)+32;
        
        plot(x1,y1,'o')
        hold on;
        
        plot(x2,y2,'ro')
        hold on;
        
        plot([x1 x2],[y1 y2]);
        
    end
    
%    saveas(gcf,['./result/locate_match/',int2str(i_big)],'bmp')
    hold off;
end
        
