clear clc;
%define the cell array
Array_of_features={};
No_of_images=1;
for k=1:No_of_images
    image=imread('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KSYES tumor alone\KSYES tumor aloneY1.jpg');
    LBP=extractLBPFeatures(image);
    subplot(231)
imshow(image);
title('Input Image')
subplot(232)
plot(HOG);
title('LBP Features');
subplot(233)
imshow(image);
hold on;
plot(HOG)
title('Image and LBP  Features together')
    %GLCM=reshape(graycomatrix(image),1,[]);
   %stats=graycoprops(GLCM,'Contrast Correlation Energy Homogeneity');
    %Contrast=stats.Contrast;
   %Correlation=stats.Correlation;
   % Homogeneity=stats.Homogeneity;
    %Mean=mean2(image);
    %Standard_Deviation=std2(image);
   % Entropy=entropy(image);
   % RMS=mean2(rms(image));
     
   % Variance=mean2(var(double(image)));
   % a=sum(double(image(:)));
   % Smothness=1-(1/(1+a));
   % Kurtosis=(kurtosis(double(image(:))));
   % Skewness=skewness(double(image(:)));


    HOG=extractHOGFeatures(image);
   %CS=16;
   %HOG=extractHOGFeatures(image,'CellSize',[CS CS]);
    
Array_of_features=[Array_of_features;LBP; HOG];
subplot(234)
imshow(image);
title('Input Image')
subplot(235)
plot(HOG);
title('Hog Features');
subplot(236)
imshow(image);
hold on;
plot(HOG)
title('Image and Hog Features together')
 
hold on;

 

end
writetable(cell2table(Array_of_features),'ExtractedFeatures.csv','writevariablenames',false,'QuoteStrings',true);
 