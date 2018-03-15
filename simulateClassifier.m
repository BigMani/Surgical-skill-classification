close all
clear
Display = [{'1'} {'2'} {'1'} {'2'} {'1'} {'2'}];
crossVDisplay = [{'1'} {'1'} {'0'} {'0'} {'0'} {'1'}];
global PDFxlabel
global CVplottitle

PDFDist = [];
%PDFxlabel = 'Normalized task performance scores';
PDFxlabel = 'LDA projected scores (fNIRS)';
CVplottitle = 'Cross-validated LDA model (FLS score)';

BrainRegions = [1,2];
withScore = 0;
changeDirection = 1;

% Define Parameters
centroid1x = -2;
centroid1y = 1;
centroid2x = -.5;
centroid2y = -.25;
n = 500;

% Simulate data points
a=2*pi.*rand(n,1);
r=sqrt(rand(n,1));
Nx=(1*r).*cos(a)+centroid1x;
Ny=(1*r).*sin(a)+centroid1y;
a=2*pi*rand(n,1);
r=sqrt(rand(n,1));
Ex=(2*r).*cos(a)+centroid2x;
Ey=(1*r).*sin(a)+centroid2y;

% Plot ground truth
figure;
scatter(Nx,Ny,'r.')
hold on
scatter(Ex,Ey,'b.')
hold off


% Classify data
figure;
novicedata = [Nx,Ny];
expertdata = [Ex,Ey];
LDAData    = ReadDatabyRegion(novicedata,expertdata,novicedata, expertdata, BrainRegions,withScore);
LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
PlotResults(LDAModel,LDAData,Display,changeDirection);
LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
if (changeDirection==1)
    CVMCE = 100*sum((1-LDACVModel.pValueTypeII)<0.05)/size(LDACVModel.pValueTypeII,2);
else
    CVMCE = 100*sum(LDACVModel.pValueTypeII<0.05)/size(LDACVModel.pValueTypeII,2);
end