function Data = ReadData
load('Classification_data.mat');
X1              = [Expert_NIRS Expert_score];
X2              = [Novice_NIRS Novice_score];
size(X1)
size(X2)
Index1          = [5 7 8 11 12 13 17 18 19 20 21 22 24 25 26 27 31];
Index2          = [1 2 3 10 11 12 17 23 24 25 26];
X01             = X1(Index1,:);
X02             = X2(Index2,:);
K1              = size(X01,1);
K2              = size(X02,1);
K               = [K1 K2];
X               = [X01;X02];
N               = size(X,2);
xmean           = mean(X);
xstd            = std(X);
X               = (X - ones(sum(K),1)*xmean)/diag(xstd);
Data.X          = X;
Data.K          = K;
Data.N          = N;
Data.xmean      = xmean;
Data.xstd       = xstd;
Data.Index      = [{'LPFC'} {'MPFC'} {'RPFC'} {'LLM1'} {'LMM1'} {'RMM1'} {'RRM1'} {'SMA'} {'Score'}];