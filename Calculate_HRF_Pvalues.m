% This function requires an open EasyNIRS instance to get results

% Initializations
global hmr;
dcAvg = hmr.group.procResult.dcAvg;
tHRF = hmr.group.procResult.tHRF;
index = knnsearch(tHRF,0);
MeasList = hmr.SD.MeasList;
channels = size(dcAvg,3);
charString = char(MeasList(1:channels,1)-1+'A');
a = repmat('_',channels,1);
Channels = [charString,a,num2str(MeasList(1:channels,2),'%02d')];
p = ones(35,3);
% Data processing (units are mM*cm)
% Structure for p value:
%   colums: 1 - HbO Rest vs Stim
%           2 - HbR Rest vs Stim
%           3 - HbO Stim vs HbR Stim
%   rows: # of channels
dcAvg_HbO = reshape(dcAvg(:,1,:),7501,35)*1E6;
dcAvg_HbR = reshape(dcAvg(:,2,:),7501,35)*1E6;

for i=1:35
    if isnan(dcAvg_HbO(1,i))
        p(i,:)=1;
    else
        p(i,1) = ranksum(dcAvg_HbO(1:1501,i),dcAvg_HbO(1502:end,i));
        p(i,2) = ranksum(dcAvg_HbR(1:1501,i),dcAvg_HbR(1502:end,i));
        p(i,3) = ranksum(dcAvg_HbO(1502:end,i),dcAvg_HbR(1502:end,i));
    end
end
pvalues = p;