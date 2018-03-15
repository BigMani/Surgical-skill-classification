function void = Calculate_DConc()
% This function requires an open EasyNIRS instance to get results
global hmr;
dcAvg = hmr.group.procResult.dcAvg;
tHRF = hmr.group.procResult.tHRF;
index = knnsearch(tHRF,0);
MeasList = hmr.SD.MeasList;
filename = hmr.filename(1:end-5);
channels = size(dcAvg,3);
HbOAvg_rest = mean(dcAvg(1:index,1,:));
HbRAvg_rest = mean(dcAvg(1:index,2,:));
HbOAvg_stim = mean(dcAvg(index:end,1,:));
HbRAvg_stim = mean(dcAvg(index:end,2,:));
data = zeros(channels,4);
data(:,1) = reshape(HbOAvg_rest,channels,1);
data(:,2) = reshape(HbOAvg_stim,channels,1);
data(:,3) = reshape(HbRAvg_rest,channels,1);
data(:,4) = reshape(HbRAvg_stim,channels,1);

charString = char(MeasList(1:channels,1)-1+'A');
a = repmat('_',channels,1);
Channels = [charString,a,num2str(MeasList(1:channels,2),'%02d')];
save([filename '.mat'],'data','Channels');