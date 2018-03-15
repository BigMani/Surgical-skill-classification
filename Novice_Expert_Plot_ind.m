% Must have open instance of EasyNIRS for function to work
global hmr
if exist('z')
    z=z+1;
else
    z=1;
end
time = hmr.procResult.tHRF;
index = knnsearch(time,0);
data = reshape(hmr.procResult.dcAvg(index:end,1,:),length(hmr.procResult.dcAvg(index:end,1,:)),33);
g1 = data(:,1:2);
g2 = data(:,4:5);
g3 = data(:,7:8);
g4 = data(:,10:13);
g5 = data(:,15:18);
g6 = data(:,20:23);
g7 = data(:,25:28);
g8 = data(:,30:32);

g1(:,~any(g1,1))=[];
g2(:,~any(g2,1))=[];
g3(:,~any(g3,1))=[];
g4(:,~any(g4,1))=[];
g5(:,~any(g5,1))=[];
g6(:,~any(g6,1))=[];
g7(:,~any(g7,1))=[];
g8(:,~any(g8,1))=[];

VBLAST_e_ind(z,1) = mean2(g1);
VBLAST_e_ind(z,2) = mean2(g2);
VBLAST_e_ind(z,3) = mean2(g3);
VBLAST_e_ind(z,4) = mean2(g4);
VBLAST_e_ind(z,5) = mean2(g5);
VBLAST_e_ind(z,6) = mean2(g6);
VBLAST_e_ind(z,7) = mean2(g7);
VBLAST_e_ind(z,8) = mean2(g8);