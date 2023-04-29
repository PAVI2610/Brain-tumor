clc
clear all
close all
%Input
% [I,path]=uigetfile('*.jpg','select a input image');
% str=strcat(path,I);
clc
clear all
close all
I=imread('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KPYESfilter\Y1.jpg');
%srcFile=dir('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KPYESfilter\*.jpg');
  
 %for k=1:length(srcFile)
   % filename=strcat('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KPYESfilter\',srcFile(k).name);
%I=imread(filename);
 
    %thresholding
sout=imresize(I,[256,256]);
t0=40;
th=t0+((max(I(:))+min(I(:)))./2);
for i=1:1:size(I,1)
    for j=1:1:size(I,2)
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
tumor_label=find(area==max_area);
tumor=ismember(label,tumor_label);
if max_area>100
   %figure;
   imshow(tumor)
   %title('tumor alone','FontSize',20);
else
   % h = msgbox('No Tumor!!','status');
    %disp('no tumor');
    %return;
end
         %path=strcat('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KSYES tumor alone\',srcFile(i).name);
        % imwrite(tumor,path); 
 %Bounding box
box = stats(tumor_label);
wantedBox = box.BoundingBox;
%figure
%imshow(tumor);
%title('Bounding Box','FontSize',20);
hold on;
rectangle('Position',wantedBox,'EdgeColor','y');
hold off;
 %path=strcat(' C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KSYESbounding box',srcFile(k).name);
  % imwrite(wantedbox,path);
 %end