global hmr;

name = hmr.filename;
name = strrep(name,'-','_');
name = name(1:end-5);
%name = 'VBLAST1_10';
% if exist('trial','var')
%     trial=trial+1;
% else
%     trial=1;
% end

%name = ['S6','_D',num2str(day),'_',num2str(trial)];
%name = ['S2','_',num2str(trial)];
%name = ['Resident_9_FLS','_',num2str(trial)];
%name = 'Resident_6_VBLAST';

%time = hmr.procResult.tHRF;
%index = knnsearch(time,0);
%data = reshape(hmr.procResult.dcAvg(index:end,1,:),length(hmr.procResult.dcAvg(index:end,1,:)),33);
%data = reshape(hmr.procResult.dc(:,1,:),length(hmr.procResult.dc(:,1,:)),32);
%MGH_FLS_Training_Coherence.(name).data = 1E6*data;
MGH_FLS_Training_Coherence.(name).Stim = cell2mat(hmr.userdata.data(:,1));
%save('MGH_CTRL_Training_Coherence.mat','MGH_CTRL_Training_Coherence')