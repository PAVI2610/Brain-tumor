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
  % imshow(tumor)
   %title('tumor alone','FontSize',20);
else
    h = msgbox('No Tumor!!','status');
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
%hold on;
%rectangle('Position',wantedBox,'EdgeColor','y');
%hold off;
%Getting Tumor Outline - image filling, eroding, subtracting
dilationAmount = 5;
rad = floor(dilationAmount);
[r,c] = size(tumor);
filledImage = imfill(tumor, 'holes');
for i=1:r
   for j=1:c
       x1=i-rad;
       x2=i+rad;
       y1=j-rad;
       y2=j+rad;
       if x1<1
           x1=1;
       end
       if x2>r
           x2=r;
       end
       if y1<1
           y1=1;
       end
       if y2>c
           y2=c;
       end
       erodedImage(i,j) = min(min(filledImage(x1:x2,y1:y2)));
   end
end
%figure
%imshow(erodedImage);
%title('eroded image','FontSize',20);
%subtracting eroded image from original BW image
tumorOutline=tumor;
tumorOutline(erodedImage)=0;
figure;  
imshow(tumorOutline);
title('Tumor Outline','FontSize',20);
