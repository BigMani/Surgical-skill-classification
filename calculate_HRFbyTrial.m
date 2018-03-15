%function calculate_HRFbyTrial

global hmr;
dinfo = dir('*.nirs');


if exist('h','var')
    h=h+1;
else
    h=1;
end
%name = [strrep(dinfo(z).name(1:end-5),'-','_'),'_',num2str(h)];
%name = [strrep(dinfo(z).name(1:end-5),'-','_')];
name = ['Trial',num2str(z),'_',num2str(h)];
time = hmr.procResult.tHRF;
index = knnsearch(time,0);
data = reshape(hmr.procResult.dcAvg(index:end,1,:),length(hmr.procResult.dcAvg(index:end,1,:)),32);
BU_FLS_Trial.Subject1.(name).time = time;
BU_FLS_Trial.Subject1.(name).data = 1E6*data;
save('matlab.mat','BU_FLS_Trial','h','z')