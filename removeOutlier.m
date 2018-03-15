function finaldata = removeOutlier(data)
% Input: data in vector format
% Output: data with objectively removed outliers in vector format
%
% Author: Arun Nemani
% Source formulation: Matlab Boxplot whisker

%range = 2*nanstd(data);
%range = 1.5; % MGH_FLS_Analysis.m
range = 1; %BU_Learning_Analysis.m
top = prctile(data,75) + range*(prctile(data,75) - prctile(data,25));
bot = prctile(data,25) - range*(prctile(data,75) - prctile(data,25));
data(data < bot) = NaN;
data(data > top) = NaN;
finaldata = data;