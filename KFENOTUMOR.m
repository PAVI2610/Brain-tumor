clc
clear all

%I=imread('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KPYESfilter\Y1.jpg');
 srcFile=dir('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KSNOTUMOR\*.jpg');
  
 for k=1:length(srcFile)
    filename=strcat('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KSNOTUMOR\',srcFile(k).name);
image=imread(filename);
LBP=extractLBPFeatures(image);
 HOG=extractHOGFeatures(image);
    GLCM=reshape(graycomatrix(image),1,[]);
   stats=graycoprops(GLCM,'Contrast Correlation Energy Homogeneity');
    Contrast(k)=stats.Contrast;
   Correlation(k)=stats.Correlation;
   Homogeneity(k) =stats.Homogeneity;
   Mean(k) =mean2(image);
    Standard_Deviation(k) =std2(image);
   Entropy(k) =entropy(image);
   RMS(k) =mean2(rms(image));
     
    Variance(k) =mean2(var(double(image)));
    a=sum(double(image(:)));
    Smothness(k) =1-(1/(1+a));
   Kurtosis(k) =(kurtosis(double(image(:))));
    Skewness(k) =skewness(double(image(:)));
% Extract properties of each object
stats = regionprops(image, 'Area', 'Perimeter', 'Circularity');

% Calculate the field of each object
pixel_size = 0.1; % Example pixel size
for i = 1:length(stats)
    field(i) = stats(i).Area * pixel_size^2;
end

% Calculate the circularity of each object
for i = 1:length(stats)
    circularity(i) = 4*pi*(stats(i).Area/stats(i).Perimeter^2);
end

% Output the results
disp('Object | Area | Perimeter | Circularity | Field')
for i = 1:length(stats)
    disp([num2str(i) ' | ' num2str(stats(i).Area) ' | ' num2str(stats(i).Perimeter) ' | ' num2str(circularity(i)) ' | ' num2str(field(i))])
end
 
 end