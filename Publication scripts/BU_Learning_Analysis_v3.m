%function BU_Learning_Analysis_v3()
    % Perform differentiation and classification analysis on UB learning curve
    % data
    %
    % Author: Arun Nemani

    % DEBUG ZONE
    % ------------------------------------------------------------------------
    % clear
    close all
    Display = [{'1'} {'2'} {'1'} {'2'} {'1'} {'2'}];
    crossVDisplay = [{'0'} {'0'} {'0'} {'0'} {'0'} {'2'}];
    global PDFxlabel;
    global LDAcov;
    global tf;
    global Type_II_E;
    global Type_II_N;
    PDFxlabel = 'LDA projected scores (fNIRS)';
    load('UBLearningData_2.mat')
    CVMCELabel = {'FLS score','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'};
    CVboxescolor = 'gray';
    classifer = 'SVM+LDA';

    BrainRegions = [1,2,3,5,8];
    %Subjects = 'S1|S2|S3|S4|S6|S7|S8'; % All students
    %Subjects = 'S2|S3|S6'; % "Senior" S5 only has PFC data and is thus excluded
    Subjects = 'S1|S4|S7|S8'; % "Junior"
    withScore = 0;
    changeDirection = 0;
    swapClasses = 1;
    PDFxlabel = 'LDA projected scores (fNIRS)';
    PDFlegend = {'Training day N PDF', 'Training day N trials', 'Training day 1 PDF', 'Training day 1 trials'};
    titles_2 = {'Left Lateral PFC';'Central PFC';'Right Lateral PFC';'Left Lateral M1';'Left Medial M1';'Right Medial M1';'Right Lateral M1';'SMA'};
       
    % END DEBUG ZONE
    % --------------------------------------------------------------------
    %Subjects = 'S1|S4|S7|S8'; % "Junior"
    Subjects = 'S1|S2|S3|S4|S6|S7|S8'; % All students
    %Subjects = 'S2|S3|S6'; % "Senior" S5 only has PFC data and is thus excluded
    [BoxDataFLS, BoxDataNIRS, BoxGroupNIRS] = drawLearningBoxplotsbyDay(C_trials, CTRLdataAvg, CTRLscore, F_trials, FLSdataAvg, FLSscore, Subjects);
    %plotScoreCUSUM(FLSscore, F_trials)
    [BoxScore] = drawLearningbyTrial(F_trials, FLSdataAvg, FLSscore, Subjects);
    drawLearningBoxplotsFinal(C_trials, CTRLdataAvg, CTRLscore, F_trials, FLSdataAvg, FLSscore, Subjects);
   
%     Subjects = 'S2|S3|S6';
%     [BoxDataFLS2, BoxDataNIRS2, BoxGroupNIRS2] = drawLearningBoxplotsbyDay(C_trials, CTRLdataAvg, CTRLscore, F_trials, FLSdataAvg, FLSscore, Subjects);
%     %plotScoreCUSUM(FLSscore, F_trials)
%     [BoxScore2] = drawLearningbyTrial(F_trials, FLSdataAvg, FLSscore, Subjects);
%     %drawLearningBoxplotsFinal(C_trials, CTRLdataAvg, CTRLscore, F_trials, FLSdataAvg, FLSscore, Subjects);
    
    
    % Perform LDA on Control vs FLS (pre and post)
    % -------------------------------------------------------------------- 
    
%     LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day1'),:),0.05,1), deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Day 1'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'Day1'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'CTRL Day 1'),:),0.05,1), BrainRegions, withScore);
%     LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
%     PlotResults(LDAModel,LDAData,Display,changeDirection);
%     legend('Control pre-test PDF','Control pre-test trials','FLS junior pre-test PDF','FLS junior pre-test');
%     LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
%     PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
%     if (changeDirection==1)
%         CVMCE = 100*sum((1-LDACVModel.pValueTypeII)<0.05)/size(LDACVModel.pValueTypeII,2);
%     else
%         CVMCE = 100*sum(LDACVModel.pValueTypeII<0.05)/size(LDACVModel.pValueTypeII,2);
%     end
    
    %ylim([0 1]);
    LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1), BrainRegions, withScore);
    LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
    PlotResults(LDAModel,LDAData,Display,changeDirection);
    legend('Unskilled trainee post-test PDF','Unskilled trainee post-test trials','Control post-test PDF','Control post-test trials');
    LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
    PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
    if (changeDirection==1)
        CVMCE = 100*sum(((1-LDACVModel.pValueTypeII)<0.05))/size(LDACVModel.pValueTypeII,2);
    else
        CVMCE = 100*sum(LDACVModel.pValueTypeII<0.05)/size(LDACVModel.pValueTypeII,2);
    end
    
    %ylim([0 1]);

%     LDAData = ReadDatabyRegion(novicedata, deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1),deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1), Expert_score, BrainRegions, withScore);
%     LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
%     PlotResults(LDAModel,LDAData,Display,changeDirection);
%     legend('FLS junior post-test PDF','FLS junior post-test','Expert PDF','Expert trials');
%     LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
%     PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
%     ylim([0 1]);
%     createCVLDAcolormap(LDAData,LDACVModel,0.05,  [112 48 160]/256,[0 176 80]/256, CVboxescolor,swapClasses)
%     
%     LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), novicedata, deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), Novice_score, BrainRegions, withScore);
%     LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
%     changeDirection = 0;
%     PlotResults(LDAModel,LDAData,Display,changeDirection);
%     legend('VBLaST subject distribution','VBLaST trials','Expert subject distribution','Expert trials');
%     LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
%     PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
%     ylim([0 1]);
%     createCVLDAcolormap(LDAData,LDACVModel,0.05,'g',[1 .25 0],CVboxescolor,swapClasses)
%     
%     LDAData = ReadDatabyRegion(novicedata, deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1), Novice_score, deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1), BrainRegions, withScore);
%     LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
%     changeDirection = 0;
%     PlotResults(LDAModel,LDAData,Display,changeDirection);
%     legend('Novice PDF','Novice trials','FLS Junior post-test PDF','FLS Junior post-test');
%     LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
%     PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
%     ylim([0 1]);
%     createCVLDAcolormap(LDAData,LDACVModel,0.05,'c','b',CVboxescolor)
    
%     LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1), BrainRegions, withScore);
%     LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
%     changeDirection = 0;
%     PlotResults(LDAModel,LDAData,Display,changeDirection);
%     legend('Novice PDF','Novice trials','FLS Junior post-test PDF','FLS Junior post-test');
%     LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
%     PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
%     ylim([0 1]);
%     createCVLDAcolormap(LDAData,LDACVModel,0.05,'m','g',CVboxescolor)

    if(strcmpi(classifer,'SVM'))
        novicedata = deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1);
        expertdata = deleteoutliers(BoxDataNIRS2(strcmpi(BoxGroupNIRS2,'FLS Final'),:),0.05,1);
        Novice_score = deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1);
        Expert_score = deleteoutliers(BoxDataFLS2(strcmpi(BoxGroupNIRS2,'FLS Final'),:),0.05,1);
        nirs_data = [novicedata;expertdata];
        truth_label = [ones(size(novicedata,1),1);zeros(size(expertdata,1),1)];
        scores_data = [Novice_score;Expert_score];
        f1 = figure;
        f2 = figure;
        for i = [1,2,3,5,8]
            figure(f1);
            if(i==5)
                h1 = subplot(2,3,4);
            elseif(i==8)
                h1 = subplot(2,3,5);
            else
                h1 = subplot(2,3,i);
            end
            tic
            [~, Mdl_FLS, Mdl_NIRS, truelabels, orig_truelabels] = classifyDataSVM(nirs_data(:,i),scores_data,truth_label,[91 155 213]/256,[112 48 160]/256);

            set(gca,'FontSize',18);
            xlim([180 300]);
            %ylim([-3 2]);
            legend('off')

            title(titles_2(i), 'FontSize', 22,'FontWeight','bold');
            if(i==1)
                ylabel('\Delta HbO conc (\muM*mm)','FontSize',18)
                xlabel('Pattern Cutting score','FontSize',18)
                legend({'Skilled trainees','Unskilled trainees','Support Vectors','Decision Boundary'},'FontSize',18);
            else
                set(gca,'XTickLabel',{' '});
                set(gca,'YTickLabel',{' '});
            end

            % Calculate and plot ROC
             figure(f2);
            if(i==5)
                h2 = subplot(2,3,4);
            elseif(i==8)
                h2 = subplot(2,3,5);
            else
                h2 = subplot(2,3,i);
            end
             plotSVMROC(orig_truelabels,truelabels, Mdl_FLS, Mdl_NIRS,'FLS');
             title(titles_2(i), 'FontSize', 22,'FontWeight','bold');
             set(gca,'FontSize',18);
             if(i==1)
                 legend({'Quadratic SVM (FLS)','Quadratic SVM (NIRS)','Random'},'Location','SouthEast','FontSize',18)
                 xlabel('False positive rate (1 - specificity)','FontSize',18); 
                 ylabel('True positive rate (sensitivity)','FontSize',18);
             end
             toc
        end
    end
    
    if(strcmpi(classifer,'SVM+LDA'))
        novicedata = deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1);
        expertdata = deleteoutliers(BoxDataNIRS2(strcmpi(BoxGroupNIRS2,'FLS Final'),:),0.05,1);
        Novice_score = deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1);
        Expert_score = deleteoutliers(BoxDataFLS2(strcmpi(BoxGroupNIRS2,'FLS Final'),:),0.05,1);
        LDAData    = ReadDatabyRegion(novicedata,expertdata,Novice_score, Expert_score, BrainRegions,withScore);
        LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
        novicedata2 = novicedata(:,[1,2,3,5,8])*LDAModel.P;
        expertdata2 = expertdata(:,[1,2,3,5,8])*LDAModel.P;
        nirs_data = [novicedata2;expertdata2];
        truth_label = [ones(size(novicedata,1),1);zeros(size(expertdata,1),1)];
        scores_data = [Novice_score;Expert_score];

        f1 = figure;
        f2 = figure;
        figure(f1);
        tic

        [~, Mdl_FLS, Mdl_NIRS, truelabels, orig_truelabels] = classifyDataSVM(nirs_data,scores_data,truth_label,[91 155 213]/256,[112 48 160]/256);
        set(gca,'FontSize',18);
        xlim([180 300]);
        %ylim([-3 2]);
        legend('off')
        ylabel('Weighted \Delta HbO conc (\muM*mm)','FontSize',18)
        xlabel('Pattern Cutting score','FontSize',18)
        legend({'Skilled trainees','Unskilled trainees','Support Vectors','Decision Boundary'},'FontSize',18);

        % Calculate and plot ROC
         figure(f2);
         plotSVMROC(orig_truelabels,truelabels, Mdl_FLS, Mdl_NIRS,'FLS');
         title('Weighted fNIRS metrics', 'FontSize', 22,'FontWeight','bold');
         set(gca,'FontSize',18);
         legend({'Quadratic SVM (FLS)','Quadratic SVM (NIRS)','Random'},'Location','SouthEast','FontSize',18)
         xlabel('False positive rate (1 - specificity)','FontSize',18); 
         ylabel('True positive rate (sensitivity)','FontSize',18);
         toc
    end
            
    S_MCE_E_all = [];
    S_MCE_N_all = [];
    Weights = zeros(5,11);
    AvgNIRSData = zeros(5,11);
    for i = 3% [3,4,7,8,9,10,11,12]
        if i<12
            structdayname = ['Day',num2str(i)];
            %LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:),0.05,1), deleteoutliers(CTRLdataAvg(:,:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day1'),:),0.05,1), deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            AvgNIRSData(:,i-1) = nanmean(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:)));
        end
        if i==12
            structdayname = 'FLS Final';
            %LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:),0.05,1), deleteoutliers(CTRLdataAvg(:,:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day1'),:),.05,1), deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            AvgNIRSData(:,i-1) = nanmean(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:)));
        end
        LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
        LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
        PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
        if (changeDirection==1)
            CVMCE = 100*sum(((1-LDACVModel.pValueTypeII)<0.05))/size(LDACVModel.pValueTypeII,2);
        else
            CVMCE = 100*sum(LDACVModel.pValueTypeII<0.05)/size(LDACVModel.pValueTypeII,2);
        end
        Weights(:,i-1) = LDAModel.P;
%         % Filter outlier data in FDA model
%         % ----------------------------------------------------------------
%         K1 = deleteoutliers(LDAModel.t(1:LDAData.K(1)),.2,1);
%         K2 = deleteoutliers(LDAModel.t(LDAData.K(1)+1:end),.2,1);
%         LDAData.K(1) = length(K1(~isnan(K1)));
%         LDAData.K(2) = length(K2(~isnan(K2)));
%         clear LDAModel.t
%         LDAModel.t = [K1(~isnan(K1));K2(~isnan(K2))];
        
        PlotResults(LDAModel,LDAData,Display,changeDirection);
        S_MCE_E_all = [S_MCE_E_all;Type_II_E];
        S_MCE_N_all = [S_MCE_N_all;Type_II_N];
    end
     drawMCEerrors(S_MCE_E_all,S_MCE_N_all);
%     ActivationIndex(AvgNIRSData,Weights);
%     %[BrainCon,BrainConP] = BrainConnectivity(newFLSdataAvg, newF_trials, Subjects, 'pearson');

%end
function drawLearningBoxplotsFinal(C_trials, CTRLdata, CTRLscore, F_trials, FLSdata, FLSscore, Subjects)
    titles = {'Left Lateral PFC';'Central PFC';'Right Lateral PFC';'Left Lateral M1';'Left Medial M1';'Right Medial M1';'Right Lateral M1';'SMA'};
    BoxGroup = [];
    BoxData = [];
    BoxColorGroup = [];
    
    %Strucutre CTRL pre test scores
    idx = contains(C_trials,'_Pre');
    BoxData = [BoxData;CTRLscore(idx)];
    BoxGroup = [BoxGroup;repmat({'Control pre-test'},size(CTRLscore(idx),1),1)];
    BoxColorGroup = [BoxColorGroup; repmat({'C'},size(CTRLscore(idx),1),1)];
    
    %Strucutre FLS pre test scores
    day = ['_D',num2str(1),'_'];
    idx_day = contains(F_trials,day);
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    BoxData = [BoxData;FLSscore(idx,:)];
    BoxGroup = [BoxGroup;repmat({'FLS pre-test'},length(FLSscore(idx,:)),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'F'},length(FLSscore(idx,:)),1)];
        
    %Structure Break
    BoxData = [BoxData;NaN];
    BoxGroup = [BoxGroup;{' '}];
    BoxColorGroup = [BoxColorGroup;{'F'}];

    %Structure CTL final
    idx = contains(C_trials,'_Post');
    BoxData = [BoxData;CTRLscore(idx)];
    BoxGroup = [BoxGroup;repmat({'Control post-test'},size(CTRLscore(idx),1),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'C'},size(CTRLscore(idx),1),1)];

    %Structure FLS final
    idx_day = contains(F_trials,'_Final');
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    BoxData = [BoxData;FLSscore(idx)];
    BoxGroup = [BoxGroup;repmat({'FLS post-test'},size(FLSscore(idx),1),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'F'},size(FLSscore(idx),1),1)];
    
    figure
    boxplot(BoxData,BoxGroup,'colorgroup',BoxColorGroup,'colors',[[237 125 49]/256; 0 0 0],'medianstyle', 'line');
    set(gca,'FontSize',12)
    set(findobj('Tag','Box'),'LineWidth',2);
    set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
    set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
    ylim([-50 300]);
    ylabel('FLS performance score','FontName','Times New Roman','FontSize',14,'interpreter','tex')
    [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'Control pre-test')),BoxData(strcmpi(BoxGroup,'FLS pre-test')),'ttest');
    text(.20,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'Control post-test')),BoxData(strcmpi(BoxGroup,'FLS post-test')),'ttest');
    text(.80,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    set(gca, 'XTickLabelRotation', 45)
    
    % Plot NIRS by day
    %%%%%%%%%%%%%%%%%%%%%%%%%
    BoxGroupNIRS = [];
    BoxDataNIRS = [];
    BoxColorGroupNIRS = [];
    
    %Strucutre CTRL pre test fNIRS
    idx = contains(C_trials,'_Pre');
    BoxDataNIRS = [BoxDataNIRS;CTRLdata(idx,:)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({'Control pre-test'},size(CTRLdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS; repmat({'C'},size(CTRLdata(idx,1)))];
    
    %Strucutre FLS pre test fNIRS
    day = ['_D',num2str(1),'_'];
    idx_day = contains(F_trials,day);
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    BoxDataNIRS = [BoxDataNIRS;deleteoutliers(FLSdata(idx,:),.05,1)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({'FLS pre-test'},size(FLSdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'F'},size(FLSdata(idx,1)))];
    
    %Structure Break
    BoxDataNIRS = [BoxDataNIRS;NaN(1,8)];
    BoxGroupNIRS = [BoxGroupNIRS;{' '}];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;{'F'}];
    
    %Structure CTL final
    idx = contains(C_trials,'_Post');
    BoxDataNIRS = [BoxDataNIRS;CTRLdata(idx,:)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({'Control post-test'},size(CTRLdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'C'},size(CTRLdata(idx,1)))];

    %Structure FLS final
    idx_day = contains(F_trials,'_Final');
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    BoxDataNIRS = [BoxDataNIRS;deleteoutliers(FLSdata(idx,:),.05,1)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({'FLS post-test'},size(FLSdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'F'},size(FLSdata(idx,1)))];
    
    for i=[1:3,5,8]
        if(i==5)
            h1 = subplot(2,3,4);
        elseif(i==8)
            h1 = subplot(2,3,5);
        else
            h1 = subplot(2,3,i);
        end
        %h1 = subplot(3,3,i);
        
        boxplot(BoxDataNIRS(:,i),BoxGroupNIRS,'colorgroup',BoxColorGroupNIRS,'colors',[[237 125 49]/256; 0 0 0],'medianstyle', 'line');
        set(findobj('Tag','Box'),'LineWidth',2);
        set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
        set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
        set(gca,'FontSize',12,'XTickLabelRotation',45)
        title(titles(i), 'FontSize', 16);

        [~,ptext] = sigStar(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Control pre-test'),i),BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS pre-test'),i),'ttest');
        text(.20,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        [~,ptext] = sigStar(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Control post-test'),i),BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS post-test'),i),'ttest');
        text(.80,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        title(titles(i));
        set(gca,'XTickLabel',{' '});
        ppos = get(h1,'pos');
        ppos(3) = ppos(3) + 0.00;
        set(h1,'pos',ppos);
        if(i==1)
           ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',14,'interpreter','tex')
           set(gca,'XTickLabel',{'Control pre-test','Training pre-test',' ', 'Control post-test','Training post-test'});
        end
    end
end

function [BoxData, BoxDataNIRS, BoxGroupNIRS] = drawLearningBoxplotsbyDay(C_trials, CTRLdata, CTRLscore, F_trials, FLSdata, FLSscore, Subjects)
    titles = {'Left Lateral PFC';'Medial PFC';'Right Lateral PFC';'Left Lateral M1';'Left Medial M1';'Right Medial M1';'Right Lateral M1';'SMA'};
    BoxGroup = [];
    BoxData = [];
    BoxColorGroup = [];

    %Strucutre CTRL pre test scores
    idx = contains(C_trials,'_Pre');
    BoxData = [BoxData;CTRLscore(idx)];
    BoxGroup = [BoxGroup;repmat({'CTRL Day 1'},size(CTRLscore(idx),1),1)];
    BoxColorGroup = [BoxColorGroup; repmat({'C'},size(CTRLscore(idx),1),1)];

    %Strucutre FLS learning
    for i = 1:11
        day = ['_D',num2str(i),'_'];
        idx_day = contains(F_trials,day);
        idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
        idx = sum([idx_day,idx_sub],2) > 1;
        structdayname = ['Day',num2str(i)];
        BoxData = [BoxData;FLSscore(idx,:)];
        BoxGroup = [BoxGroup;repmat({structdayname},length(FLSscore(idx,:)),1)];
        BoxColorGroup = [BoxColorGroup;repmat({'F'},length(FLSscore(idx,:)),1)];
    end

    %Structure Break
    BoxData = [BoxData;NaN;NaN];
    BoxGroup = [BoxGroup;{'Break week 1';'Break week 2'}];
    BoxColorGroup = [BoxColorGroup;{'F';'F'}];

    %Structure CTL final
    idx = contains(C_trials,'_Post');
    BoxData = [BoxData;CTRLscore(idx)];
    BoxGroup = [BoxGroup;repmat({'CTRL Final'},size(CTRLscore(idx),1),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'C'},size(CTRLscore(idx),1),1)];

    %Structure FLS final
    idx_day = contains(F_trials,'_Final');
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    BoxData = [BoxData;FLSscore(idx)];
    BoxGroup = [BoxGroup;repmat({'FLS Final'},size(FLSscore(idx),1),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'F'},size(FLSscore(idx),1),1)];

    % Plot NIRS by day
    %%%%%%%%%%%%%%%%%%%%%%%%%
    BoxGroupNIRS = [];
    BoxDataNIRS = [];
    BoxColorGroupNIRS = [];

    %Strucutre CTRL pre test scores
    idx = contains(C_trials,'_Pre');
    BoxDataNIRS = [BoxDataNIRS;CTRLdata(idx,:)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({'CTRL Day 1'},size(CTRLdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS; repmat({'C'},size(CTRLdata(idx,1)))];

    %Strucutre FLS learning
    for i = 1:11
        day = ['_D',num2str(i),'_'];
        idx_day = contains(F_trials,day);
        idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
        idx = sum([idx_day,idx_sub],2) > 1;
        structdayname = ['Day',num2str(i)];
        BoxDataNIRS = [BoxDataNIRS;deleteoutliers(FLSdata(idx,:),.05,1)];
        BoxGroupNIRS = [BoxGroupNIRS;repmat({structdayname},size(FLSdata(idx,1)))];
        BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'F'},size(FLSdata(idx,1)))];
    end

    %Structure break
    BoxDataNIRS = [BoxDataNIRS;NaN(2,8)];
    BoxGroupNIRS = [BoxGroupNIRS;{'Break week 1'; 'Break week 2'}];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;{'F';'F'}];

    %Structure CTL final
    idx = contains(C_trials,'_Post');
    BoxDataNIRS = [BoxDataNIRS;CTRLdata(idx,:)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({'CTRL Final'},size(CTRLdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'C'},size(CTRLdata(idx,1)))];

    %Structure FLS final
    idx_day = contains(F_trials,'_Final');
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    BoxDataNIRS = [BoxDataNIRS;deleteoutliers(FLSdata(idx,:),.05,1)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({'FLS Final'},size(FLSdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'F'},size(FLSdata(idx,1)))];
    
    figure
    for i=[1:3,5,8]
        if(i==5)
            h1  = subplot(2,3,4);
        elseif(i==8)
            h1 = subplot(2,3,5);
        else
            h1 = subplot(2,3,i);
        end
        boxplot(BoxDataNIRS(:,i),BoxGroupNIRS,'colorgroup',BoxColorGroupNIRS,'colors',[[237 125 49]/256; 0 0 0],'medianstyle', 'line');
        %set(findobj('Tag','Box'),'LineWidth',2);
        set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
        set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
        set(gca,'FontSize',16,'XTickLabelRotation',45)
        ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',18,'interpreter','tex')

        [~,ptext] = sigStar(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Day 1'),i),BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day1'),i),'ttest');
        text(.06,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        [~,ptext] = sigStar(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Final'),i),BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS Final'),i),'ttest');
        text(.93,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        title(titles(i));
        
    end

    %subplot(2,3,6)
    figure
    % Draw FLS performance boxplots
    boxplot(BoxData,BoxGroup,'colorgroup',BoxColorGroup,'colors',[[237 125 49]/256; 0 0 0],'medianstyle', 'line');
    
    set(findobj('Tag','Box'),'LineWidth',2);
    set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
    set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
    ylim([-50 300]);

    %set(gca,'FontSize',18)
    [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'CTRL Day 1')),BoxData(strcmpi(BoxGroup,'Day1')),'ttest');
    text(.06,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'CTRL Final')),BoxData(strcmpi(BoxGroup,'FLS Final')),'ttest');
    text(.93,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    set(gca,'FontSize',12,'XTickLabelRotation',45)
    %set(gca,'XTickLabel',{' '});
    ylabel('FLS performance score','FontName','Times New Roman','FontSize',16,'interpreter','tex')
    set(gca,'XTickLabel',{'Control pretest', 'Training pretest', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7', 'Day 8', 'Day 9', 'Day 10', 'Day 11', 'Break week 1', 'Break week 2', 'Control posttest', 'Training posttest'});
    
end

function [BoxData] = drawLearningbyTrial(F_trials, FLSdata, FLSscore, Subjects)
    titles = {'Left Lateral PFC';'Medial PFC';'Right Lateral PFC';'Left Lateral M1';'Left Medial M1';'Right Medial M1';'Right Lateral M1';'SMA'};
    subs = split(Subjects,'|');
    for i = 1:length(subs)
        day = char(subs(i));
        idx = contains(F_trials,day);
        BoxData.(day) = deleteoutliers(FLSscore(idx,:),.2,1);
        BoxGroup.(day) = repmat({day},length(FLSscore(idx,:)),1);
        %BoxDataNIRS.(day) = FLSdata(idx,:);
        BoxDataNIRS.(day) = deleteoutliers(FLSdata(idx,:),.05,1);
        BoxGroupNIRS.(day) = repmat({day},size(FLSdata(idx,1)));
    end
    % Remove S7 datapoint that is outlier
    BoxData.S8(87) = NaN;
    
    figure
    cmap = colormap(hsv(length(subs)));
    for i=[1:3,5,8]
        if(i==5)
            subplot(2,3,4)
        elseif(i==8)
            subplot(2,3,5)
        else
            subplot(2,3,i)
        end
        hold on
        for k = 1:length(subs)
            
            scatter(1:length(BoxDataNIRS.(char(subs(k)))),BoxDataNIRS.(char(subs(k)))(:,i), 20, cmap(k,:), 'filled')
        end
        hold off
        set(gca,'FontSize',16,'XTickLabelRotation',45)
        ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',18,'interpreter','tex')
        xlabel('Trial','FontName','Times New Roman','FontSize',18,'interpreter','tex');
        title(titles(i));
        xlim([0 110]);
    end
    
    %subplot(2,3,6)
    figure
    % Draw FLS performance boxplots
    hold on
    for k = 1:length(subs)
        scatter(1:length(BoxDataNIRS.(char(subs(k)))),BoxData.(char(subs(k))), 20, cmap(k,:), 'filled')
    end
    
    hold off
    ylim([-50 300]);
    xlim([0 110]);
    ylabel('FLS performance score','FontName','Times New Roman','FontSize',16,'interpreter','tex')
    legend('FLS-1','FLS-2','FLS-3','FLS-4','FLS-5','FLS-6','FLS-7','FLS-8');
    xlabel('Trial','FontName','Times New Roman','FontSize',18,'interpreter','tex');
end

function plotScoreCUSUM(FLSscore, F_trials)
    p0 = 0.05;
    p1 = .1;
    alpha = 0.05;
    beta = 0.20;
    SeniorThresh = 63; %from literature (Fraser et al. 2003)
    P = log(p1/p0);
    Q = log((1-p0)/(1-p1));
    s = Q/(P+Q);
    s1 = 1-s;
    a = log((1-beta)/alpha);
    b = log((1-alpha)/beta);
    h0 = -b/(P+Q);
    h1 = a/(P+Q);

    % Plot learning curves for left, medial, and right PFC

    [t1,~,~,cs1]=CUSUM(FLSscore(contains(F_trials,'S1_D')),SeniorThresh,s,s1);
    [t2,~,~,cs2]=CUSUM(FLSscore(contains(F_trials,'S2_D')),SeniorThresh,s,s1);
    [t3,~,~,cs3]=CUSUM(FLSscore(contains(F_trials,'S3_D')),SeniorThresh,s,s1);
    [t4,~,~,cs4]=CUSUM(FLSscore(contains(F_trials,'S4_D')),SeniorThresh,s,s1);
    [t6,~,~,cs6]=CUSUM(FLSscore(contains(F_trials,'S6_D')),SeniorThresh,s,s1);
    [t7,~,~,cs7]=CUSUM(FLSscore(contains(F_trials,'S7_D')),SeniorThresh,s,s1);
    [t8,~,~,cs8]=CUSUM(FLSscore(contains(F_trials,'S8_D')),SeniorThresh,s,s1);

    figure
    %plot the learning curve 
    UL(1:101)=h1;
    LL(1:101)=h0;

    plot(t1,cs1,t2,cs2,t3,cs3,t4,cs4,t6,cs6,t7,cs7,t8,cs8,'Marker', '*');
    colormap(hsv)

    ylabel('CUSUM score','fontsize',16)
    xlabel('Trial','fontsize',16);
    hold on;
    plot(0:100,UL, 'Color',[0,0,0], 'LineWidth', 2, 'LineStyle','--');
    plot(0:100,LL, 'Color',[0,0,0], 'LineWidth', 2);
    xlim([0 100])
    hold off;
        legend({'FLS-1','FLS-2', 'FLS-3', 'FLS-4','FLS-5','FLS-6','FLS-7','H_1','H_0'});

end
function [outdata, outlabel] = normalizeData(inputdata, labels, regions)
    data = inputdata(:,regions);
    tmp = deleteoutliers(data,.05,1);
    tmplabel = labels;
    X = tmp(~any(isnan(tmp),2),:);
    outlabel = tmplabel(~any(isnan(tmp),2),:);
    outdata = (X - ones(size(X,1),1)*nanmean(X))/diag(nanstd(X));
end

function [outdata, outlabel] = normalizeDatabyDay(inputdata, labels, Subjects, regions)

    data = inputdata(:,regions);
    outdata = [];
    outlabel = [];
    subs = split(labels,'|');
    for i = 1:length(subs)
        sub = char(subs(i));
        idx = contains(labels,sub);
        tmp = deleteoutliers(data(idx,:),.05,1);
        tmplabel = labels(idx);
        X = tmp(~any(isnan(tmp),2),:);
        tmplabel = tmplabel(~any(isnan(tmp),2),:);
        X = (X - ones(size(X,1),1)*nanmean(X))/diag(nanstd(X));
    
        outdata = [outdata;X];
        outlabel = [outlabel;tmplabel];
    end
end

function Data = createLDAdata(Case2, Case1,regions)
        Groups = [{'Left LateralPFC'} {'Medial PFC'} {'Right Lateral PFC'} {'Left Lateral M1'} {'Left Medial M1'} {'Right Medial M1'} {'Right Lateral M1'} {'SMA'}];
            X1              = Case2(:,regions);
            X2              = Case1(:,regions);
            Data.Index      = Groups(regions);
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
end

function [Type_II_E, Type_II_N] = PlotLDAResults(Model,Data,changeDirection, PDFxlabel, PDFlegend)
    global PDFdist; %Euclidean distance of .50 of CDF for each class.
    global tf;
    fighandle = gcf;
    n = fighandle.Number;

    % Plot LDA weights
    %---------------------------------------------------------------------
    n = n + 1;
    figure(n)
    bar(Model.P(:,1),'w','LineWidth',5.0)
    axis tight
    set(gca,'box','off','FontName','Times New Roman','FontSize',30,'XTick',1:1:Data.N,'XTickLabel',Data.Index(1:1:Data.N));
    for i=1:Data.N
        fprintf('%d \t %6.5f \n',i,Model.P(i,1));
    end
    ylabel('Correlation with discriminant function','FontName','Times New Roman','FontSize',30)
    set(gca,'XTickLabelRotation',45);

    % Plot normalized PDFs with misclassifcation errors
    %---------------------------------------------------------------------
    n = n + 1;
    figure(n)
    n = n + 1;
    figure(n)
    tmin       = min(Model.t);
    tmax       = max(Model.t);
    tran       = tmax - tmin;
    x          = (tmin - 0.25*tran):0.01:(tmax + 0.25*tran);
    f          = zeros(length(Data.K),length(x));
    F          = zeros(length(Data.K),round(length(x)/2));
    m0         = 1;
    tScaled    = (Model.t - ones(sum(Data.K),1)*mean(Model.t))/(std(Model.t));
    for i=1:length(Data.K)    
        t      = tScaled(m0:m0+Data.K(i)-1,1);
        if i<length(Data.K)
            m0 = m0 + Data.K(i);
        end
        f(i,:)      = EstimatePDF(x,t);
        [F(i,:),tf] = EstimateCDF(f(i,:),x,0.01);
        figure(n-1), plot(x,f(i,:),'c','LineWidth',2.0), hold on
        figure(n-1), histogram(t,15,'Normalization','probability','FaceColor','c'), hold on
        %figure(n-1), plot(t,ones(1,length(t))*0.02,'bx','MarkerSize',15,'LineWidth',2.0), hold on
        figure(n), plot(tf,F(i,:),'c','LineWidth',2.0), hold on
    end
    figure(n-1)
    hold off
    axis tight
    set(gca,'box','off','FontName','Times New Roman','FontSize',14)
    
    xlabel(PDFxlabel,'FontName','Times New Roman','FontSize',26)
    ylabel('PDF value','FontName','Times New Roman','FontSize',26)
    
    figure(n)
    plot(tf,ones(1,length(tf))*0.95,'k','LineWidth',2.0)
    hold off
    axis tight
    set(gca,'box','off','FontName','Times New Roman','FontSize',14)
    xlabel('Normalized projected score','FontName','Times New Roman','FontSize',20)
    ylabel('CDF','FontName','Times New Roman','FontSize',20)
 
    % Change direction of Type II error calculation
    % --------------------------------------------------------------------
    switch (changeDirection==1)
        case 1
            [~,idx1] = min(abs(F(2,:)-0.5));
            [~,idx2] = min(abs(F(1,:)-0.5));
            PDFdist = pdist([tf(idx1); tf(idx2)]);
            Type_I = 0.05;
            Type_I = 1 - Type_I;
            for i=1:length(F(2,:))
                if F(2,i) > Type_I
                    Type_II_E = F(1,i);
                    t_crit  = tf(i);
                    break
                end
            end
            
            Type_I = 0.05;
            for i=1:length(F(1,:))
                if F(1,i) > Type_I
                    Type_II_N = 1 - F(2,i);
                    t_crit  = tf(i);
                    break
                end
            end
        otherwise
            [~,idx1] = min(abs(F(2,:)-0.5));
            [~,idx2] = min(abs(F(1,:)-0.5));
            PDFdist = pdist([tf(idx1); tf(idx2)]);
            Type_I = 0.05;
            Type_I = 1 - Type_I;
            for i=1:length(F(1,:))
                if F(1,i) > Type_I
                    Type_II_E = F(2,i);
                    t_crit  = tf(i);
                    break
                end
            end
            
            Type_I = 0.05;
            for i=1:length(F(2,:))
                if F(2,i) > Type_I
                    Type_II_N = 1 - F(1,i-1);
                    t_crit  = tf(i);
                    break
                end
            end
    end
    figure(n-1)
    if Type_II_E < 1e-2
        Type_II_E = 0;
    end
    if Type_II_N < 1e-2
        Type_II_N = 0;
    end
    
    text(.98,.95,['MCE_{(E\rightarrowN)} = ',num2str(Type_II_E,2)],'Interpreter', 'tex','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','right');
    text(.98,.85,['MCE_{(N\rightarrowE)} = ',num2str(Type_II_N,2)],'Interpreter', 'tex','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','right');
    legend(PDFlegend,'Location','northwest','FontName','Times New Roman','FontSize', 12);
end

function drawMCEerrors(MCE_E, MCE_N)
figure
hold on
plot(1:11, MCE_E,'color',[91 155 213]/256,'Marker', '*', 'LineWidth', 2, 'LineStyle', '--')
plot(1:11, MCE_N,'color',[91 155 213]/256,'Marker', '*', 'LineWidth', 2)
set(gca,'FontSize',14);
ylabel('Misclassificaiton error','fontsize',16)
set(gca,'XTickLabel',{'Day2','Day3','Day4','Day5','Day6','Day7','Day8','Day9','Day10','Final training day','Post-test'})
ylim([0 1]);
hold off
legend('Senior MCE_1','Senior MCE_2');
xtickangle(45)
end

function ActivationIndex(AvgData, Weights)
    metric = zeros(1,10);
    metric_PFC = zeros(1,10);
    metric_M1 = zeros(1,10);
    metric_SMA = zeros(1,10);
    for i = 1:11
        metric(i) = Weights(1,i)*AvgData(1,i) + Weights(2,i)*AvgData(2,i) + Weights(3,i)*AvgData(3,i) + Weights(4,i)*AvgData(4,i) + Weights(5,i)*AvgData(5,i);
        metric_PFC(i) = Weights(1,i)*AvgData(1,i) + Weights(2,i)*AvgData(2,i) + Weights(3,i)*AvgData(3,i);
        metric_M1(i) =  Weights(4,i)*AvgData(4,i);
        metric_SMA(i) = Weights(5,i)*AvgData(5,i);
       
    end
    figure
    hold on
    plot([1:11], metric,'color','k','Marker', '*', 'LineStyle','-','LineWidth', 2)
    plot([1:11], metric_PFC,'color','c','Marker', '*', 'LineStyle','-','LineWidth', 2)
    plot([1:11], metric_M1,'color','m','Marker', '*','LineStyle','-','LineWidth', 2)
    plot([1:11], metric_SMA,'color','g','Marker', '*', 'LineStyle','-','LineWidth', 2)

    ylabel('Activation index','fontsize',16)
    set(gca,'XTickLabel',{'Day2','Day3','Day4','Day5','Day6','Day7','Day8','Day9','Day10','Day11','Final'})
    %ylim([0 1]);
    hold off
    legend('AI (PFC + M1 + SMA)','AI (PFC', 'AI (M1)', 'AI (SMA)');
end
function [BrainCon, BrainConP] = BrainConnectivity(FLSdata, F_trials, Subjects, corrtype)
    BrainCon = zeros(10,12);
    BrainConP = zeros(10,12);
    for i = 1:12
        if i<12
            day = ['_D',num2str(i),'_'];
            idx_day = contains(F_trials,day);
            idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
            idx = sum([idx_day,idx_sub],2) > 1;
            T = FLSdata(idx,[1,2,3,5,8]);
            for k = 1:5
                T(:,k) = deleteoutliers(T(:,k),.05,1);
            end
            T = normalizeData(T);
        end
        if i==12
            day = 'Final';
            idx_day = contains(F_trials,day);
            idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
            idx = sum([idx_day,idx_sub],2) > 1;
            T = FLSdata(idx,[1,2,3,5,8]);
            for k = 1:5
                T(:,k) = deleteoutliers(T(:,k),.05,1);
            end
            T = normalizeData(T);
        end
        [R,P] = corr(T,'type',corrtype,'tail','both','rows','complete');
        BrainCon(:,i) = [diag(R,-1);diag(R,-2);diag(R,-3);diag(R,-4)];
        BrainConP(:,i) = [diag(P,-1);diag(P,-2);diag(P,-3);diag(P,-4)];
    
    end
    
    figure
    Connectivitylabels = {'LLPFC - MPFC','RLPFC - MPFC','RLPFC - LMM1','LMM1 - SMA','RLPFC - LLPFC','MPFC - LLM1','RLPFC - SMA','LLPFC - LMM1','MPFC - SMA','LLPFC - SMA'};
    cmap = colormap(hsv(size(BrainCon,2)));
    set(gca, 'ColorOrder', cmap);
    
    SigCoeff = [1,2,5,8];
    cmap = colormap(cool(length(SigCoeff)));
    hold on
    for k1 = 1:4
        plot(1:size(BrainCon,2),BrainCon(SigCoeff(k1),:),'Color',cmap(k1,:),'Marker', '*', 'LineWidth', 2);
    end
    legend(Connectivitylabels(SigCoeff), 'fontsize', 8, 'Location', 'southeast');
    set(gca,'fontsize',10,'FontName','Helvetica');
    ylabel('Spearman correlation coefficient','fontsize',16,'FontName'   , 'AvantGarde')
    xlabel('Training day', 'fontsize', 16,'FontName'   , 'AvantGarde')
    %title('Correlation of region specific functional activation','fontsize',16, 'FontName','AvantGarde')
    %set(gca,'XTickLabel',{'1', '2','3','4','5','6','7','8','9','10','11','Final'})
    %set(gca, 'XTickLabelRotation', 45)
    ylim([-1 1]);
    hold off
end