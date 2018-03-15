N = char(fieldnames(UBLearningDataVBLAST));

for i = 1:size(N,1)
    tic
    disp(['Computing total path length for trial: ',num2str(i)])
    EOM.VBLAST_Learning.RightPathlength(i,1) = sum(diag(squareform(pdist(UBLearningDataVBLAST.(N(i,:)).Right(:,3:5)/1000)),-1));
    EOM.VBLAST_Learning.LeftPathlength(i,1) = sum(diag(squareform(pdist(UBLearningDataVBLAST.(N(i,:)).Left(:,3:5)/1000)),-1));
    toc
end