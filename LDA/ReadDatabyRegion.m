function Data = ReadDatabyRegion(Case1, Case2, Case1Score, Case2Score, regions, includescores)
    Groups = [{'Left LateralPFC'} {'Medial PFC'} {'Right Lateral PFC'} {'Left Lateral M1'} {'Left Medial M1'} {'Right Medial M1'} {'Right Lateral M1'} {'SMA'}];
    switch includescores
        case 1
            X1              = [Case2(:,regions) Case2Score];
            X2              = [Case1(:,regions) Case1Score];
            Data.Index      = [Groups(regions) {'FLS PC Score'}];
        case 0
            X1              = Case2(:,regions);
            X2              = Case1(:,regions);
            Data.Index      = Groups(regions);
    end
    size(X1);
    size(X2);
    X01             = X1(~any(isnan(X1),2),:);
    X02             = X2(~any(isnan(X2),2),:);
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