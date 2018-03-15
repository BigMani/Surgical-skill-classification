function [Mdl, truelabels, orig_truelabels] = classifyDataLDA(nirs_data, pc_data, truelabels)
% Author: Arun Nemani


%Retain original data for FLS classification
orig_truelabels = truelabels;
orig_truelabels = logical(orig_truelabels);

%Remove NaN data points
pc_data(isnan(nirs_data)) = [];
truelabels(isnan(nirs_data)) = [];
nirs_data(isnan(nirs_data)) = [];
data = [pc_data,nirs_data];
truelabels = logical(truelabels);

disp('Classifier: Linear Discriminant Analysis')
Mdl = fitcdiscr(data,truelabels);
h(1:2) = gscatter(data(:,1),data(:,2),truelabels,'rb','.');
hold on

Mdl.ClassNames([1 2]);
K = Mdl.Coeffs(1,2).Const;
L = Mdl.Coeffs(1,2).Linear;
f = @(x1,x2) K + L(1)*x1 + L(2)*x2;
h3 = ezplot(f,[xlim ylim]);
h3.Color = 'k';
h3.LineWidth = 2;
hold off