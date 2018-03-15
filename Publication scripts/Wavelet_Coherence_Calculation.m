close all
clear

processMGHData();
%processUBData();

function processMGHData()
    load('MGH_VBLAST_Novice_Data.mat');
    load('MGH_VBLAST_Expert_Data.mat');
    load('MGH_FLS_Novice_Data.mat');
    load('MGH_FLS_Expert_Data.mat');
    E_VBLAST = fields(MGH_VBLAST_Expert_Data);
    N_VBLAST = fields(MGH_VBLAST_Novice_Data);
    E_FLS = fields(MGH_FLS_Expert_Data);
    N_FLS = fields(MGH_FLS_Novice_Data);

    h1 = waitbar(0,'Processing FLS Expert');
    set(h1, 'Position', [300 600 280 60])
    for i = 1:size(E_FLS,1)
        h1 = waitbar(i/size(E_FLS,1),h1,['Processing FLS Expert: ',num2str(i),' / ', num2str(size(E_FLS,1))]);
        SubjectData = MGH_FLS_Expert_Data.(char(E_FLS(i))).data;
        Stim = MGH_FLS_Expert_Data.(char(E_FLS(i))).Stim;
        SubjectData(:,29)=[];
        Coherence = calcCoherenceTrial(SubjectData, Stim, 25);
        MGH_FLS_Expert_Coherence(i).Name = (char(E_FLS(i)));
        MGH_FLS_Expert_Coherence(i).WCO_I = Coherence.WCO_I;
        MGH_FLS_Expert_Coherence(i).WPCO_I = Coherence.WPCO_I;
        MGH_FLS_Expert_Coherence(i).WCO_II = Coherence.WCO_II;
        MGH_FLS_Expert_Coherence(i).WPCO_II = Coherence.WPCO_II;
        MGH_FLS_Expert_Coherence(i).WCO_III = Coherence.WCO_III;
        MGH_FLS_Expert_Coherence(i).WPCO_III = Coherence.WPCO_III;
        MGH_FLS_Expert_Coherence(i).WCO_IV = Coherence.WCO_IV;
        MGH_FLS_Expert_Coherence(i).WPCO_IV = Coherence.WPCO_IV;
        MGH_FLS_Expert_Coherence(i).WCO_V = Coherence.WCO_V;
        MGH_FLS_Expert_Coherence(i).WPCO_V = Coherence.WPCO_V;
    end
    close(h1)

    h1 = waitbar(0,'Processing FLS Novice');
    set(h1, 'Position', [300 600 280 60])
    for i = 1:size(N_FLS,1)
        waitbar(i/size(N_FLS,1),h1,['Processing FLS Novice: ',num2str(i),' / ', num2str(size(N_FLS,1))]);
        SubjectData = MGH_FLS_Novice_Data.(char(N_FLS(i))).data;
        Stim = MGH_FLS_Novice_Data.(char(N_FLS(i))).Stim;
        SubjectData(:,29)=[];
        Coherence = calcCoherenceTrial(SubjectData, Stim, 25);
        MGH_FLS_Novice_Coherence(i).Name = (char(N_FLS(i)));
        MGH_FLS_Novice_Coherence(i).WCO_I = Coherence.WCO_I;
        MGH_FLS_Novice_Coherence(i).WPCO_I = Coherence.WPCO_I;
        MGH_FLS_Novice_Coherence(i).WCO_II = Coherence.WCO_II;
        MGH_FLS_Novice_Coherence(i).WPCO_II = Coherence.WPCO_II;
        MGH_FLS_Novice_Coherence(i).WCO_III = Coherence.WCO_III;
        MGH_FLS_Novice_Coherence(i).WPCO_III = Coherence.WPCO_III;
        MGH_FLS_Novice_Coherence(i).WCO_IV = Coherence.WCO_IV;
        MGH_FLS_Novice_Coherence(i).WPCO_IV = Coherence.WPCO_IV;
        MGH_FLS_Novice_Coherence(i).WCO_V = Coherence.WCO_V;
        MGH_FLS_Novice_Coherence(i).WPCO_V = Coherence.WPCO_V;
    end
    close(h1)

    h1 = waitbar(0,'Processing VBLAST Expert');
    set(h1, 'Position', [300 600 280 60])
    for i = 1:size(E_VBLAST,1)
        waitbar(i/size(E_VBLAST,1),h1,['Processing VBLAST Expert: ',num2str(i),' / ', num2str(size(E_VBLAST,1))]);
        SubjectData = MGH_VBLAST_Expert_Data.(char(E_VBLAST(i))).data;
        Stim = MGH_VBLAST_Expert_Data.(char(E_VBLAST(i))).Stim;
        SubjectData(:,29)=[];
        Coherence = calcCoherenceTrial(SubjectData, Stim, 25);
        MGH_VBLAST_Expert_Coherence(i).Name = (char(E_VBLAST(i)));
        MGH_VBLAST_Expert_Coherence(i).WCO_I = Coherence.WCO_I;
        MGH_VBLAST_Expert_Coherence(i).WPCO_I = Coherence.WPCO_I;
        MGH_VBLAST_Expert_Coherence(i).WCO_II = Coherence.WCO_II;
        MGH_VBLAST_Expert_Coherence(i).WPCO_II = Coherence.WPCO_II;
        MGH_VBLAST_Expert_Coherence(i).WCO_III = Coherence.WCO_III;
        MGH_VBLAST_Expert_Coherence(i).WPCO_III = Coherence.WPCO_III;
        MGH_VBLAST_Expert_Coherence(i).WCO_IV = Coherence.WCO_IV;
        MGH_VBLAST_Expert_Coherence(i).WPCO_IV = Coherence.WPCO_IV;
        MGH_VBLAST_Expert_Coherence(i).WCO_V = Coherence.WCO_V;
        MGH_VBLAST_Expert_Coherence(i).WPCO_V = Coherence.WPCO_V;
    end
    close(h1)

    h1 = waitbar(0,'Processing Novice');
    set(h1, 'Position', [300 600 280 60])
    for i = 1:size(N_VBLAST,1)
        waitbar(i/size(N_VBLAST,1),h1,['Processing VBLAST Novice: ',num2str(i),' / ', num2str(size(N_VBLAST,1))]);
        SubjectData = MGH_VBLAST_Novice_Data.(char(N_VBLAST(i))).data;
        Stim = MGH_VBLAST_Novice_Data.(char(N_VBLAST(i))).Stim;
        SubjectData(:,29)=[];
        Coherence = calcCoherenceTrial(SubjectData, Stim, 25);
        MGH_VBLAST_Novice_Coherence(i).Name = (char(N_VBLAST(i)));
        MGH_VBLAST_Novice_Coherence(i).WCO_I = Coherence.WCO_I;
        MGH_VBLAST_Novice_Coherence(i).WPCO_I = Coherence.WPCO_I;
        MGH_VBLAST_Novice_Coherence(i).WCO_II = Coherence.WCO_II;
        MGH_VBLAST_Novice_Coherence(i).WPCO_II = Coherence.WPCO_II;
        MGH_VBLAST_Novice_Coherence(i).WCO_III = Coherence.WCO_III;
        MGH_VBLAST_Novice_Coherence(i).WPCO_III = Coherence.WPCO_III;
        MGH_VBLAST_Novice_Coherence(i).WCO_IV = Coherence.WCO_IV;
        MGH_VBLAST_Novice_Coherence(i).WPCO_IV = Coherence.WPCO_IV;
        MGH_VBLAST_Novice_Coherence(i).WCO_V = Coherence.WCO_V;
        MGH_VBLAST_Novice_Coherence(i).WPCO_V = Coherence.WPCO_V;
    end
    close(h1)
    save('C:\Users\User\Dropbox\MATLAB\NIRS Study\NIRS Main Study\Results\FinalSet\Wavelet coherence\MGH_FLS_Expert_Coherence_Full.mat','MGH_FLS_Expert_Coherence')
    save('C:\Users\User\Dropbox\MATLAB\NIRS Study\NIRS Main Study\Results\FinalSet\Wavelet coherence\MGH_FLS_Novice_Coherence_Full.mat','MGH_FLS_Novice_Coherence')
    save('C:\Users\User\Dropbox\MATLAB\NIRS Study\NIRS Main Study\Results\FinalSet\Wavelet coherence\MGH_VBLAST_Expert_Coherence_Full.mat','MGH_VBLAST_Expert_Coherence')
    save('C:\Users\User\Dropbox\MATLAB\NIRS Study\NIRS Main Study\Results\FinalSet\Wavelet coherence\MGH_VBLAST_Novice_Coherence_Full.mat','MGH_VBLAST_Novice_Coherence')

end

function processUBData()
    load('MGH_FLS_Training_Data.mat')
    load('MGH_VBLAST_Training_Data.mat')
    load('MGH_CTRL_Training_Data.mat');
    
    FLS = fields(MGH_FLS_Training_Data);
    VBLAST = fields(MGH_VBLAST_Training_Data);
    CTRL = fields(MGH_CTRL_Training_Data);
    h1 = waitbar(0,'Processing FLS training set');
    set(h1, 'Position', [300 600 280 60])
    for i = 1:size(FLS,1)
        waitbar(i/size(FLS,1),h1,['Processing FLS Training set: ',num2str(i),' / ', num2str(size(FLS,1))]);
        SubjectData = MGH_FLS_Training_Data.(char(FLS(i))).data;
        Stim = MGH_FLS_Training_Data.(char(FLS(i))).Stim;
        Stim = [Stim;size(SubjectData,1)/20];
        Coherence = calcCoherenceTrial(SubjectData, Stim, 20);
        MGH_FLS_Training_Coherence(i).Name = (char(FLS(i)));
        MGH_FLS_Training_Coherence(i).WCO_I = Coherence.WCO_I;
        MGH_FLS_Training_Coherence(i).WPCO_I = Coherence.WPCO_I;
        MGH_FLS_Training_Coherence(i).WCO_II = Coherence.WCO_II;
        MGH_FLS_Training_Coherence(i).WPCO_II = Coherence.WPCO_II;
        MGH_FLS_Training_Coherence(i).WCO_III = Coherence.WCO_III;
        MGH_FLS_Training_Coherence(i).WPCO_III = Coherence.WPCO_III;
        MGH_FLS_Training_Coherence(i).WCO_IV = Coherence.WCO_IV;
        MGH_FLS_Training_Coherence(i).WPCO_IV = Coherence.WPCO_IV;
        MGH_FLS_Training_Coherence(i).WCO_V = Coherence.WCO_V;
        MGH_FLS_Training_Coherence(i).WPCO_V = Coherence.WPCO_V;
    end
    close(h1)

    h1 = waitbar(0,'Processing VBLAST training set');
    set(h1, 'Position', [300 600 280 60])
    for i = 1:size(VBLAST,1)
        waitbar(i/size(VBLAST,1),h1,['Processing VBLAST training set: ',num2str(i),' / ', num2str(size(VBLAST,1))]);
        SubjectData = MGH_VBLAST_Training_Data.(char(VBLAST(i))).data;
        Stim = MGH_VBLAST_Training_Data.(char(VBLAST(i))).Stim;
        Stim = [Stim;size(SubjectData,1)/20];
        Coherence = calcCoherenceTrial(SubjectData, Stim, 20);
        MGH_VBLAST_Training_Coherence(i).Name = (char(VBLAST(i)));
        MGH_VBLAST_Training_Coherence(i).WCO_I = Coherence.WCO_I;
        MGH_VBLAST_Training_Coherence(i).WPCO_I = Coherence.WPCO_I;
        MGH_VBLAST_Training_Coherence(i).WCO_II = Coherence.WCO_II;
        MGH_VBLAST_Training_Coherence(i).WPCO_II = Coherence.WPCO_II;
        MGH_VBLAST_Training_Coherence(i).WCO_III = Coherence.WCO_III;
        MGH_VBLAST_Training_Coherence(i).WPCO_III = Coherence.WPCO_III;
        MGH_VBLAST_Training_Coherence(i).WCO_IV = Coherence.WCO_IV;
        MGH_VBLAST_Training_Coherence(i).WPCO_IV = Coherence.WPCO_IV;
        MGH_VBLAST_Training_Coherence(i).WCO_V = Coherence.WCO_V;
        MGH_VBLAST_Training_Coherence(i).WPCO_V = Coherence.WPCO_V;
    end
    close(h1)

    h1 = waitbar(0,'Processing CTRL training set');
    set(h1, 'Position', [300 600 280 60])
    for i = 1:size(CTRL,1)
        waitbar(i/size(CTRL,1),h1,['Processing CTRL training set: ',num2str(i),' / ', num2str(size(CTRL,1))]);
        SubjectData = MGH_CTRL_Training_Data.(char(CTRL(i))).data;
        Stim = MGH_CTRL_Training_Data.(char(CTRL(i))).Stim;
        Stim = [Stim;size(SubjectData,1)/20];
        Coherence = calcCoherenceTrial(SubjectData, Stim, 20);
        MGH_CTRL_Training_Coherence(i).Name = (char(CTRL(i)));
        MGH_CTRL_Training_Coherence(i).WCO_I = Coherence.WCO_I;
        MGH_CTRL_Training_Coherence(i).WPCO_I = Coherence.WPCO_I;
        MGH_CTRL_Training_Coherence(i).WCO_II = Coherence.WCO_II;
        MGH_CTRL_Training_Coherence(i).WPCO_II = Coherence.WPCO_II;
        MGH_CTRL_Training_Coherence(i).WCO_III = Coherence.WCO_III;
        MGH_CTRL_Training_Coherence(i).WPCO_III = Coherence.WPCO_III;
        MGH_CTRL_Training_Coherence(i).WCO_IV = Coherence.WCO_IV;
        MGH_CTRL_Training_Coherence(i).WPCO_IV = Coherence.WPCO_IV;
        MGH_CTRL_Training_Coherence(i).WCO_V = Coherence.WCO_V;
        MGH_CTRL_Training_Coherence(i).WPCO_V = Coherence.WPCO_V;
    end
    close(h1)
    save('C:\Users\User\Dropbox\MATLAB\NIRS Study\Learning Curve Study\Results\FinalSet\Wavelet coherence\MGH_VBLAST_Training_Coherence_Full.mat','MGH_VBLAST_Training_Coherence')
    save('C:\Users\User\Dropbox\MATLAB\NIRS Study\Learning Curve Study\Results\FinalSet\Wavelet coherence\MGH_FLS_Training_Coherence_Full.mat','MGH_FLS_Training_Coherence')
    save('C:\Users\User\Dropbox\MATLAB\NIRS Study\Learning Curve Study\Results\FinalSet\Wavelet coherence\MGH_CTRL_Training_Coherence_Full.mat','MGH_CTRL_Training_Coherence')
end

function [WCO] = calcCoherenceTrial(SubjectData, Stim, samplingrate)
    % Initializations    
    LPFC = [1,2];% Left lateral PFC
    CPFC = [4,5];% Central PFC
    RPFC = [7,8];% Right lateral PFC
    LMM1 = [15,16,17,18];% Left medial M1
    SMA  = [29,30,31];% SMA
    f_I = [0.6, 2]; % Cardiac activity
    f_II = [0.15, 0.6]; % Respiration activity 
    f_III = [0.05,0.15]; % Myogenic activity
    f_IV = [0.02, 0.05]; % Neurogenic activity
    f_V = [0.005, 0.02]; % Endothelial metabolic activity

    SubjectData(:,nanmean(abs(SubjectData),1)<1E-10)=NaN;
    T = 0:(1/samplingrate):(size(SubjectData,1)/samplingrate);
    T(end) = [];
    T = T';
    
    h = waitbar(0,'Calculating Wavelet Coherence');
    set(h, 'Position', [300 500 280 60])
    for k = 1:(size(Stim,1)/2)
        [~, idxstim1] = min(abs(T - Stim((k*2)-1)));
        [~, idxstim2] = min(abs(T - Stim(k*2)));
        for i=1:10
            waitbar((((k-1)*10)+ i)/(size(Stim,1)/2*10),h,['Calculating Wavelet Coherence: ',num2str(((k-1)*10)+ i),' / ', num2str(size(Stim,1)/2*10)]);
            if(i==1)
                Channel1 = LPFC; Channel2 = CPFC;
            elseif(i==2)
                Channel1 = LPFC; Channel2 = RPFC;
            elseif(i==3)
                Channel1 = LPFC; Channel2 = SMA;
            elseif(i==4)
                Channel1 = LPFC; Channel2 = LMM1;
            elseif(i==5)
                Channel1 = CPFC; Channel2 = RPFC;
            elseif(i==6)
                Channel1 = CPFC; Channel2 = SMA;
            elseif(i==7)
                Channel1 = CPFC; Channel2 = LMM1;
            elseif(i==8)
                Channel1 = RPFC; Channel2 = SMA;
            elseif(i==9)
                Channel1 = RPFC; Channel2 = LMM1;
            else
                Channel1 = SMA; Channel2 = LMM1;
            end
            DataA = nanmean(SubjectData(idxstim1:idxstim2,Channel1),2);
            DataB = nanmean(SubjectData(idxstim1:idxstim2,Channel2),2);
            if (any(DataA) && any(DataB))
                [wcoh,wcs,f,coi] = wcoherence(DataA,DataB,samplingrate,'PhaseDisplayThreshold',0.5);
                wcoh(abs(wcoh)>1)=NaN;
                wcoh(~bsxfun(@gt,repmat(f,1,size(wcoh,2)),coi')) = NaN;
                wcs(~bsxfun(@gt,repmat(f,1,size(wcs,2)),coi')) = NaN;

                Pcos = nanmean(cos(angle(wcs)),2);
                Psin = nanmean(sin(angle(wcs)),2);
                WPCO = sqrt(Pcos.^2 + Psin.^2);

                WCO.WCO_I(i,k) = nanmean2(wcoh(f>=f_I(1) & f<=f_I(2),:));
                WCO.WPCO_I(i,k) = nanmean2(WPCO(f>=f_I(1) & f<=f_I(2)));
                WCO.WCO_II(i,k) = nanmean2(wcoh(f>=f_II(1) & f<=f_II(2),:));
                WCO.WPCO_II(i,k) = nanmean2(WPCO(f>=f_II(1) & f<=f_II(2)));
                WCO.WCO_III(i,k) = nanmean2(wcoh(f>=f_III(1) & f<=f_III(2),:));
                WCO.WPCO_III(i,k) = nanmean2(WPCO(f>=f_III(1) & f<=f_III(2)));
                WCO.WCO_IV(i,k) = nanmean2(wcoh(f>=f_IV(1) & f<=f_IV(2),:));
                WCO.WPCO_IV(i,k) = nanmean2(WPCO(f>=f_IV(1) & f<=f_IV(2)));
                WCO.WCO_V(i,k) = nanmean2(wcoh(f>=f_V(1) & f<=f_V(2),:));
                WCO.WPCO_V(i,k) = nanmean2(WPCO(f>=f_V(1) & f<=f_V(2)));

            else
                WCO.WCO_I(i,k) = NaN;
                WCO.WPCO_I(i,k) = NaN;
                WCO.WCO_II(i,k) = NaN;
                WCO.WPCO_II(i,k) = NaN;
                WCO.WCO_III(i,k) = NaN;
                WCO.WPCO_III(i,k) = NaN;
                WCO.WCO_IV(i,k) = NaN;
                WCO.WPCO_IV(i,k) = NaN;
                WCO.WCO_V(i,k) = NaN;
                WCO.WPCO_V(i,k) = NaN;            
            end
        end
    end
    close (h)
end

function [WCO] = calcCoherenceFull(SubjectData, Stim, samplingrate)
    % Initializations    
    LPFC = [1,2];% Left lateral PFC
    CPFC = [4,5];% Central PFC
    RPFC = [7,8];% Right lateral PFC
    LMM1 = [15,16,17,18];% Left medial M1
    SMA  = [29,30,31];% SMA
    f_I = [0.6, 2]; % Cardiac activity
    f_II = [0.15, 0.6]; % Respiration activity 
    f_III = [0.05,0.15]; % Myogenic activity
    f_IV = [0.02, 0.05]; % Neurogenic activity
    f_V = [0.005, 0.02]; % Endothelial metabolic activity

    SubjectData(:,nanmean(abs(SubjectData),1)<1E-10)=NaN;
    T = 0:(1/samplingrate):(size(SubjectData,1)/samplingrate);
    T(end) = [];
    T = T';
    
    h = waitbar(0,'Calculating Wavelet Coherence');
    set(h, 'Position', [300 500 280 60])
        for i=1:10
            waitbar(i/10,h,['Calculating Wavelet Coherence: ',num2str(i),' / ', num2str(10)]);
            if(i==1)
                Channel1 = LPFC; Channel2 = CPFC;
            elseif(i==2)
                Channel1 = LPFC; Channel2 = RPFC;
            elseif(i==3)
                Channel1 = LPFC; Channel2 = SMA;
            elseif(i==4)
                Channel1 = LPFC; Channel2 = LMM1;
            elseif(i==5)
                Channel1 = CPFC; Channel2 = RPFC;
            elseif(i==6)
                Channel1 = CPFC; Channel2 = SMA;
            elseif(i==7)
                Channel1 = CPFC; Channel2 = LMM1;
            elseif(i==8)
                Channel1 = RPFC; Channel2 = SMA;
            elseif(i==9)
                Channel1 = RPFC; Channel2 = LMM1;
            else
                Channel1 = SMA; Channel2 = LMM1;
            end
            DataA = nanmean(SubjectData(:,Channel1),2);
            DataB = nanmean(SubjectData(:,Channel2),2);
            if (any(DataA) && any(DataB))
                [wcoh,wcs,f,coi] = wcoherence(DataA,DataB,samplingrate,'PhaseDisplayThreshold',0.5);
                wcoh(abs(wcoh)>1)=NaN;
                wcoh(~bsxfun(@gt,repmat(f,1,size(wcoh,2)),coi')) = NaN;
                wcs(~bsxfun(@gt,repmat(f,1,size(wcs,2)),coi')) = NaN;

                Pcos = nanmean(cos(angle(wcs)),2);
                Psin = nanmean(sin(angle(wcs)),2);
                WPCO = sqrt(Pcos.^2 + Psin.^2);

                WCO.WCO_I(i,1) = nanmean2(wcoh(f>=f_I(1) & f<=f_I(2),:));
                WCO.WPCO_I(i,1) = nanmean2(WPCO(f>=f_I(1) & f<=f_I(2)));
                WCO.WCO_II(i,1) = nanmean2(wcoh(f>=f_II(1) & f<=f_II(2),:));
                WCO.WPCO_II(i,1) = nanmean2(WPCO(f>=f_II(1) & f<=f_II(2)));
                WCO.WCO_III(i,1) = nanmean2(wcoh(f>=f_III(1) & f<=f_III(2),:));
                WCO.WPCO_III(i,1) = nanmean2(WPCO(f>=f_III(1) & f<=f_III(2)));
                WCO.WCO_IV(i,1) = nanmean2(wcoh(f>=f_IV(1) & f<=f_IV(2),:));
                WCO.WPCO_IV(i,1) = nanmean2(WPCO(f>=f_IV(1) & f<=f_IV(2)));
                WCO.WCO_V(i,1) = nanmean2(wcoh(f>=f_V(1) & f<=f_V(2),:));
                WCO.WPCO_V(i,1) = nanmean2(WPCO(f>=f_V(1) & f<=f_V(2)));

            else
                WCO.WCO_I(i,1) = NaN;
                WCO.WPCO_I(i,1) = NaN;
                WCO.WCO_II(i,1) = NaN;
                WCO.WPCO_II(i,1) = NaN;
                WCO.WCO_III(i,1) = NaN;
                WCO.WPCO_III(i,1) = NaN;
                WCO.WCO_IV(i,1) = NaN;
                WCO.WPCO_IV(i,1) = NaN;
                WCO.WCO_V(i,1) = NaN;
                WCO.WPCO_V(i,1) = NaN;            
            end
        end
    close (h)
end
