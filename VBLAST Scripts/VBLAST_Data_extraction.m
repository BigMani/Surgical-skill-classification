function output = VBLAST_Data_extraction()
% Parses data from VBLAST directory (only for RealTimeData format)
dinfo = dir('RealTimeData*');
N = length(dinfo);
formatTime = ['%*d %f',repmat(' %*f',1,58)];
formatLeft = ['%*d',repmat('%*f',1,30),repmat('%f',1,29)];
formatRight = ['%*d %*f',repmat('%f',1,29),repmat('%*f',1,29)];
h = waitbar(0,'Parsing VBLaST metrics');
for ii=1:N
     tic
     fid = fopen(dinfo(ii).name);
     filename = strrep(dinfo(ii).name,'.txt','');
     disp(['Parsing: ',filename])
     data.(filename).Left = cell2mat(textscan(fid,formatLeft,'Delimiter', '\n', 'CollectOutput',true));
     frewind(fid);
     data.(filename).Right= cell2mat(textscan(fid,formatRight,'Delimiter', '\n', 'CollectOutput',true));
     frewind(fid);
     data.(filename).Time = cell2mat(textscan(fid,formatTime,'Delimiter', '\n', 'CollectOutput',true));
     fclose(fid);
     toc
end
output = data;