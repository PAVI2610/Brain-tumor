clc
clear all

%I=imread('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KPYESfilter\Y1.jpg');
 srcFile=dir('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KPNo filter\*.jpg');
  
 for k=1:length(srcFile)
    filename=strcat('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KPNo filter\',srcFile(k).name);
I=imread(filename);
    %thresholding
sout=imresize(I,[256,256]);
t0=40;
th=t0+((max(I(:))+min(I(:)))./2);
%for i=1:1:size(I,1)
[row col]=size(I);
for i=1:row
     for j=1:col
         %if(x(i,j)>T)
    %for j=1:1:size(I,2)
        if I(i,j)>th
            sout(i,j)=1;
        else
            sout(i,j)=0;
        end
    end
end
 
%Morphological Operation
label=bwlabel(sout);
stats=regionprops(logical(sout),'Solidity','Area','BoundingBox');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.5;
max_area=max(area(high_dense_area));
%tumor_label=find(area==max_area);
tumor=ismember(label,max_area);
if max_area>100
  % figure;
  % imshow(tumor)
   %title('tumor alone','FontSize',20);
else
    h = msgbox('No Tumor!!','status');
    %disp('no tumor');
    %return;
end 
   path=strcat('C:\Users\Dell\Documents\PG PROJECT\matlab code\KSNOTUMOR',srcFile(k).name);
   imwrite(tumor,path);
        % path=strcat(' C:\Users\Dell\Documents\PG PROJECT\matlab code\KSYESTA\',srcFile(i).name);
        % imwrite(tumor,path); 
 end