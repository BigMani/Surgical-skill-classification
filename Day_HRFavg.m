global hmr
if exist('z')
    z=z+1;
else
    z=1;
end
time = hmr.procResult.tHRF;
index = knnsearch(time,0);
data = reshape(hmr.procResult.dcAvg(index:end,1,:),length(hmr.procResult.dcAvg(index:end,1,:)),32);
g1 = data(:,1:2);
g2 = data(:,4:5);
g3 = data(:,7:8);
g4 = data(:,10:13);
g5 = data(:,15:18);
g6 = data(:,20:23);
g7 = data(:,25:28);
g8 = data(:,29:31);

g1(:,~any(g1,1))=[];
g2(:,~any(g2,1))=[];
g3(:,~any(g3,1))=[];
g4(:,~any(g4,1))=[];
g5(:,~any(g5,1))=[];
g6(:,~any(g6,1))=[];
g7(:,~any(g7,1))=[];
g8(:,~any(g8,1))=[];

CTRLLearningNIRS.postVBLAST(z,1) = 1E6*mean2(g1);
CTRLLearningNIRS.postVBLAST(z,2) = 1E6*mean2(g2);
CTRLLearningNIRS.postVBLAST(z,3) = 1E6*mean2(g3);
CTRLLearningNIRS.postVBLAST(z,4) = 1E6*mean2(g4);
CTRLLearningNIRS.postVBLAST(z,5) = 1E6*mean2(g5);
CTRLLearningNIRS.postVBLAST(z,6) = 1E6*mean2(g6);
CTRLLearningNIRS.postVBLAST(z,7) = 1E6*mean2(g7);
CTRLLearningNIRS.postVBLAST(z,8) = 1E6*mean2(g8);