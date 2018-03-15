function output = VBLAST_Data_extraction_v2()
% Parses data from VBLAST directory (only for RealTimeData format)
dinfo = dir('RealTimeData*');
N = length(dinfo);

%formatTime = ['%*d %f',repmat(' %*f',1,58)];
formatLeft = ['%*d %*f',repmat('%*f',1,29),'%*f %*f %f %f %f',repmat('%*f',1,24)];
formatRight = ['%*d %*f','%*f %*f %f %f %f',repmat('%*f',1,24),repmat('%*f',1,29)];
h = waitbar(0,'Parsing VBLaST metrics');
for ii=[1:74,76:N] %skip S2 - trial 7. file is too large to parse
     tic
     waitbar(ii/N,h,['Parsing VBLaST tool pathlengths: S',dinfo(ii).name(20), ' ,Trial - ', num2str(dinfo(ii).name(28:29))]);
     fid = fopen(dinfo(ii).name);
     filename = strrep(dinfo(ii).name,'.txt','');
     disp(['Parsing: ',filename])
     Left = cell2mat(textscan(fid,formatLeft,'Delimiter', '\n', 'CollectOutput',true));
     output.(filename).Lefttoolpathlength = sum(diag(squareform(pdist(Left/1000)),-1));
     fclose(fid);
     fid = fopen(dinfo(ii).name);
     Right = cell2mat(textscan(fid,formatRight,'Delimiter', '\n', 'CollectOutput',true));
     output.(filename).Righttoolpathlength = sum(diag(squareform(pdist(Right/1000)),-1));
%      frewind(fid);
%      data.(filename).Time = cell2mat(textscan(fid,formatTime,'Delimiter', '\n', 'CollectOutput',true));
     fclose(fid);
     clear Left
     clear Right
     toc
end
close(h)