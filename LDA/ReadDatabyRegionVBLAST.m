function Data = ReadDatabyRegionVBLAST(N_nirs, E_nirs, N_scores, E_scores, N_pathlength, E_pathlength, regions, includescores, includepathlength)
    Groups = [{'Left LateralPFC'} {'Medial PFC'} {'Right Lateral PFC'} {'Left Lateral M1'} {'Left Medial M1'} {'Right Medial M1'} {'Right Lateral M1'} {'SMA'}];
    switch includescores
        case 1
            X1              = [E_nirs(:,regions) E_scores];
            X2              = [N_nirs(:,regions) N_scores];
            Data.Index      = [Groups(regions) {'VBLAST PC Score'}];
            switch includepathlength
                case 1
                    X1 = [X1 E_pathlength];
                    X2 = [X2 N_pathlength];
                    Data.Index = [Data.Index {'Right Tool Pathlength'}];
                case 0
            end
        case 0
            X1              = E_nirs(:,regions);
            X2              = N_nirs(:,regions);
            Data.Index      = Groups(regions);
            switch includepathlength
                case 1
                    X1 = [X1 E_pathlength];
                    X2 = [X2 N_pathlength];
                    Data.Index = [Data.Index {'Right Tool Pathlength'}];
                case 0
            end
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