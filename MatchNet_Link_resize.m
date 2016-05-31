% The function of this module is display some pairs of match patches.
%% input the data
clear all
close all
clc

A=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0000.bmp');
A1=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0001.bmp');
B=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0002.bmp');
B1=imread('/home/yiran/matchnet test/data/phototour/notredame/patches0003.bmp');

rA=gray2r(A);
rA1=gray2r(A1);
rB=gray2r(B);
rB1=gray2r(B1);

data1 = load('/home/yiran/matchnet test/matchPatchRecord.txt');
data2 = load('/home/yiran/matchnet test/data/phototour/notredame/m50_512_512_0.txt');

%% find match patch

matchP=[];
matchP2=[];
HH_count=0;
VV_count=0;

[m,n]=size(data1);
[k,l]=size(data2);

E=cell(1,2*m);

oo=size(A,2);

%% plot HH match status
figure
imagesc([rA,rA1]);
hold on;
        
for i=1:m
    t_idx=data2(data1(i,1),1);
    m_idx=data2(data1(i,1),4);
    
    if t_idx>=0 && t_idx<256
        
        HH_count=HH_count+1;
        
        m_idx=mod(m_idx,256);
        
        t_column=mod(t_idx,16)+1;
        t_row=((t_idx-mod(t_idx,16))/16)+1;
        
        m_column=mod(m_idx,16)+1;
        m_row=((m_idx-mod(m_idx,16))/16)+1;        
        
        t_patch=A(64*(t_row-1)+1:64*t_row,64*(t_column-1)+1:64*t_column);
        m_patch=A1(64*(m_row-1)+1:64*m_row,64*(m_column-1)+1:64*m_column);
        
        plot(64*t_row-32,64*t_column-32,'o')
        plot(64*m_row-32+oo,64*m_column-32,'ro')
        plot([64*t_row-32 64*m_row-32+oo],[64*t_column-32 64*m_column-32]);
        
        matchP=[matchP;t_patch,m_patch];
        
    end
end

hold off;

%% plot VV match status
figure
imagesc([rB,rB1]);
hold on;
        
for i=1:m
    t_idx=data2(data1(i,1),1);
    m_idx=data2(data1(i,1),4);
    
    if t_idx>=512 && t_idx<768
        
        VV_count=VV_count+1;
        
        t_idx=mod(t_idx,256);
        m_idx=mod(m_idx,256);
        
        t_column=mod(t_idx,16)+1;
        t_row=((t_idx-mod(t_idx,16))/16)+1;
        
        m_column=mod(m_idx,16)+1;
        m_row=((m_idx-mod(m_idx,16))/16)+1;        
        
        t_patch=B(64*(t_row-1)+1:64*t_row,64*(t_column-1)+1:64*t_column);
        m_patch=B1(64*(m_row-1)+1:64*m_row,64*(m_column-1)+1:64*m_column);
        
        plot(64*t_row-32,64*t_column-32,'o')
        plot(64*m_row-32+oo,64*m_column-32,'ro')
        plot([64*t_row-32 64*m_row-32+oo],[64*t_column-32 64*m_column-32]);
        
        matchP2=[matchP2;t_patch,m_patch];
        
    end
end

hold off;

%% display some pairs of match patches
for i=1:HH_count
   figure, imshow(matchP(64*(i-1)+1:64*(i),:))
end

for i=1:VV_count
   figure, imshow(matchP2(64*(i-1)+1:64*(i),:))
end