function [Mdl, Mdl_FLS, Mdl_NIRS, truelabels, orig_truelabels] = classifyDataSVM(nirs_data, pc_data, truelabels, class1color, class2color)
%
% Author: Arun Nemani

classcolors = [class1color;class2color];
%Retain original data for FLS classification
orig_truelabels = truelabels;
orig_truelabels = logical(orig_truelabels);
orig_pc_data = pc_data;

%Remove NaN data points
pc_data(isnan(nirs_data)) = [];
truelabels(isnan(nirs_data)) = [];
nirs_data(isnan(nirs_data)) = [];
data = [pc_data,nirs_data];
truelabels = logical(truelabels);

disp('Classifier: Support Vector Machines')
Mdl = fitcsvm(data,truelabels,'Standardize',true,'KernelFunction','polynomial','PolynomialOrder',2,'Solver','SMO','CacheSize',1000);
Mdl_FLS = fitcsvm(orig_pc_data,orig_truelabels,'Standardize',true,'KernelFunction','polynomial','PolynomialOrder',2,'Solver','SMO','CacheSize',1000);
Mdl_NIRS = fitcsvm(data(:,2),truelabels,'Standardize',true,'KernelFunction','polynomial','PolynomialOrder',2,'Solver','SMO','CacheSize',1000);

% Predict scores over grid
d =  0.02;
[x1Grid,x2Grid] = meshgrid(min(data(:,1)):d:max(data(:,1)),min(data(:,2)):d:max(data(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
[~,score_svm] = predict(Mdl,xGrid);

%Plot data and decision boundaries from SVM
h(1:2) = gscatter(data(:,1),data(:,2),truelabels,classcolors,'.');
hold on
h(3) = plot(data(Mdl.IsSupportVector,1),data(Mdl.IsSupportVector,2),'ko');
contour(x1Grid,x2Grid,reshape(score_svm(:,2),size(x1Grid)),[0 0],'k');
%g = legend(h,{'Novice','Expert','Support Vectors'});
%set(g,'FontSize',8);
hold off