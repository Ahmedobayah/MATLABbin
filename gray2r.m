function RBG=gray2r(image)

[m n]=size(image);
rgb=zeros(m,n,3);
rgb(:,:,1)=image;
rgb(:,:,2)=rgb(:,:,1);
rgb(:,:,3)=rgb(:,:,1);
image=rgb/255;
RBG=image;


