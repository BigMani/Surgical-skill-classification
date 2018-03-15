function MuscleArea = TransferImgAnalysis(file)
img = imread(file);
h_im = imshow(img);
disp('Draw calibration line spanning 10cm...');
h = imline;
Lpos = wait(h);

Llength = sqrt((Lpos(2,1)-Lpos(1,1))^2 + (Lpos(2,2) - Lpos(1,2))^2);
calibration = Llength / 10; % pixel / 1cm
disp('Draw ellipse covering ROI...');
e = imellipse;
position = wait(e);
BW = createMask(e,h_im);
%GauzeArea = bwarea(BW)/(calibration^2);
GauzeArea = bwarea(BW);
figure
ROI = rgb2gray(img);
ROI(BW ==0) = 0;
threshIMG = (im2bw(ROI,.35));
fatArea = bwarea(threshIMG);
MuscleArea = (1-(fatArea/GauzeArea))*100; 
imshow(threshIMG);