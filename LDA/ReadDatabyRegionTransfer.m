function Data = ReadDatabyRegionTransfer(C_nirs, F_nirs, V_nirs, C_scores, F_scores, V_scores, regions, includescores)
    Groups = [{'Left LateralPFC'} {'Medial PFC'} {'Right Lateral PFC'} {'Left Lateral M1'} {'Left Medial M1'} {'Right Medial M1'} {'Right Lateral M1'} {'SMA'}];
    switch includescores
        case 1
            X1              = [F_nirs(:,regions) F_scores];
            X2              = [C_nirs(:,regions) C_scores];
            X3              = [V_nirs(:,regions) V_scores];
            Data.Index      = [Groups(regions) {'FLS PC Score'}];
        case 0
            X1              = F_nirs(:,regions);
            X2              = C_nirs(:,regions);
            X3              = C_nirs(:,regions);
            Data.Index      = Groups(regions);
    end
    size(X1);
    size(X2);
    X01             = X1(~any(isnan(X1),2),:);
    X02             = X2(~any(isnan(X2),2),:);
    X03             = X3(~any(isnan(X3),2),:);
    K1              = size(X01,1);
    K2              = size(X02,1);
    K3              = size(X03,1);
    K               = [K1 K2 K3];
    X               = [X01;X02;X03];
    N               = size(X,2);
    xmean           = mean(X);
    xstd            = std(X);
    X               = (X - ones(sum(K),1)*xmean)/diag(xstd);
    Data.X          = X;
    Data.K          = K;
    Data.N          = N;
    Data.xmean      = xmean;
    Data.xstd       = xstd;