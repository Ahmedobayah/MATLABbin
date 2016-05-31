function write_txt(a,fname)
% This function can write matrix a into the txt file fname.

fid=fopen(fname,'wt');%写入文件路径
[m,n]=size(a);
 for i=1:1:m
    for j=1:1:n
       if j==n
         fprintf(fid,'%g\n',a(i,j));
      else
        fprintf(fid,'%g\t',a(i,j));
       end
    end
end
fclose(fid);

return


