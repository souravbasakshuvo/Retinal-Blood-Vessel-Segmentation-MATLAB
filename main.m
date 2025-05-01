clc;clear;close all;

inputImage = imread('Data_Set/21_training.tif');
groundTruth = imread('Data_Set/21_manual1.gif');

% Plotting the original input image
subplot 421
imshow(inputImage);
title("Raw input image");

% Plotting the ground truth image
subplot 422
imshow(groundTruth);
title("Ground Truth Image");

%Generation of image mask
mask = im2bw(inputImage,20/255);
%str. element of dimond type of size 20 (errosion)
se = strel('diamond',20);
erodedmask = im2uint8(imerode(mask,se)); %erroded image
subplot 423
imshow(erodedmask);
title("Generation of image mask");

%Apply gaussian filter to the image where s=1.45
img3= imgaussfilt(inputImage(:,:,2) ,1.45);
subplot 424
imshow(img3);
title("After using Gaussian Filter");

%Finding lamda - principal curvature
[gx, gy] = gradient(double(img3));
[gxx, ~] = gradient(gx);
[gxy, gyy] = gradient(gy);
[row,col]=size(img3);
lamdaplus = zeros(row,col);
lamdaminus = zeros(row,col);
%finding eigen values of hessian matrix [gxx gxy;gxy gyy]
for r = 1:row
    for c = 1:col
            [lamdaplus(r,c),lamdaminus(r,c)]=lamdafind(gxx(r,c),gyy(r,c),gxy(r,c));
    end
end
lamda2 = lamdaplus;
maxprincv = im2uint8(lamda2/max(lamda2(:)));
maxprincvmsk = maxprincv.*(erodedmask/255);
subplot 425
imshow(maxprincvmsk);
title("Image after using principal curvature method");

%Contrast enhancement using Contrast-limited adaptive histogram equalization (CLAHE)
newprI = adapthisteq(maxprincvmsk,'numTiles',[8 8],'nBins',128);
thresh = isodata(newprI);
vessels = imbinarize(newprI,thresh);
subplot 426
imshow(vessels);
title("Contrast enhanced Image After Using CLAHE");

%Filtering out small segments using Morphological Area Opening
vessels = bwareaopen(vessels, 200);
segImage = vessels;
subplot 427
imshow(segImage);
title("Filtering out small segments using Morphological Area Opening");

subplot 428
imshow(segImage);
title("Processed Final Image Output");

%This function perform validation of vessel segmentation
image=im2uint8(segImage);

%TP - True Positives 
%True positive - Anypixel marked as vessel in both ground truth and segemented image

%FP - False positive : Any pixel Marked as a vessel pixel in segmented image
%which is marked as background pixel in ground truth

%TN - True Negative : Any pixel marked as backgrounf in both ground truth
%and segmented image

TP = 0;
TN = 0;
FP = 0;
FN = 0;
vGT = 0;      
bGT = 0;

[row,col]= size(groundTruth);

for r=1:row
    for c = 1:col
        if groundTruth(r,c)==255
            vGT=vGT+1;
            if image(r,c)==255
                TP=TP+1;
            end

        else
            bGT=bGT+1;
            if image(r,c)==0
                TN=TN+1;
            else
                FP=FP+1;
            end

        end
    end
end

TPR = TP/vGT; %vGT : Number of vessel pixels - Ground truth
FPR = FP/bGT; %vGT : Number of non-vessel pixels - Ground truth
FN = (row*col)- (TP + TN + FP);
%Accuracy = (True negative+ True Positive)/all pixels
Accuracy= (TP+TN)/(TP+TN+FP+FN);
True_Positive = TP/(row*col);
True_Negative = TN/(row*col);
False_Positive = FP/(row*col);
False_Negative = FN/(row*col);
Sensitivity = TP/(TP+FN);
Specificity = TN/(TN+FP);
model = {'Principal curvature'};
A = table(model, TPR, FPR, Accuracy, Sensitivity, Specificity);
disp(A)
