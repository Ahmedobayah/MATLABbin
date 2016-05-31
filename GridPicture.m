function [ imageMatdouble ] = GridPicture( PictureName , countForEachStep )
 %This function grid the image into counts grid 
 % For instance:GridPicture('294_236_360.bmp',32)

pictureInfo = imfinfo(PictureName);     %load information about the input 

 [inputImageMat, inputImageMap] = imread(PictureName);        % Load the image     

%2. Convert image to double precision.
 imageMatdouble =im2double(inputImageMat);  

 % zero is create indicated to black 
 height = pictureInfo.Height ; 
 width = pictureInfo.Width;
  i=1;j=1;  
  
 while (i<=height ) 
     for j=1:width
         imageMatdouble(i,j)=0;% plot a row line
     end
    
    j=1;
    if (i==1)
       i=i+countForEachStep-1;
   else 
       i=i+countForEachStep;
    end
   
 end


   i=1;j=1;  
 while (i<=width ) 
      
  for j=1:height
      imageMatdouble(j,i)=0; % plot a column line
  end
   
  j=1;
  
  if (i==1)
      i=i+countForEachStep-1;
  else 
       i=i+countForEachStep;
   end

 end

 
%  imshow(imageMatdouble);
%  imwrite(imageMatdouble,'patches0003.bmp')



 end

