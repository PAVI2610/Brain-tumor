srcFile=dir('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\brain MRI images kaggle\no\*.jpg');

 for i=1:length(srcFile)
    filename=strcat('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\brain MRI images kaggle\no\',srcFile(i).name);
    I=imread(filename);
  %PREPROCESSING

a1=imresize(I,[256 256]);
 %subplot(2,2,2), imshow(a1), title('resize')

d=imnlmfilt(a1);
    subplot(2,2,3), imshow(d), title('filter')
    if size(d,3)>1
    d=rgb2gray(d);
    end

     
    
        path=strcat('C:\Users\Dell\Documents\PG PROJECT\PAPER AND DATASET\KPNo filter\',srcFile(i).name);
    imwrite(d,path);
end
