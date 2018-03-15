function [Data, label] = ReadDatabyRegionFull(Case1, Case1Score, label,regions, includescores)
Groups = [{'Left LateralPFC'} {'Medial PFC'} {'Right Lateral PFC'} {'Left Lateral M1'} {'Left Medial M1'} {'Right Medial M1'} {'Right Lateral M1'} {'SMA'}];
switch includescores
    case 1
        X2              = [Case1(:,regions) Case1Score];
        Data.Index      = [Groups(regions) {'FLS PC Score'}];
    case 0
        X2              = Case1(:,regions);
        Data.Index      = Groups(regions);
end
X02 = X2(~any(isnan(X2),2),:);
label = label(~any(isnan(X2),2),:);
X = X02;
N = size(X,2);
xmean = mean(X);
xstd = std(X);
X = (X - ones(size(X,1),1)*xmean)/diag(xstd);
Data.X = X;
Data.N = N;
Data.xmean = xmean;
Data.xstd = xstd;