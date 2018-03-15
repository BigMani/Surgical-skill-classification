%function BU_Learning_Analysis_v3()
    % Perform differentiation and classification analysis on UB learning curve
    % data
    %
    % Author: Arun Nemani

    % DEBUG ZONE
    % ------------------------------------------------------------------------
    % clear
    close all
    Display = [{'0'} {'2'} {'0'} {'2'} {'1'} {'2'}];
    crossVDisplay = [{'0'} {'0'} {'0'} {'0'} {'0'} {'1'}];
    global PDFxlabel;
    global LDAcov;
    global tf;
    global Type_II_E;
    global Type_II_N;
    PDFxlabel = 'LDA projected scores (fNIRS)';
    load('UBLearningDataVBLAST_2.mat')
    CVMCELabel = {'FLS score','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'};
    CVboxescolor = 'gray';

    BrainRegions = [1,2,3,5,8];
    Subjects = 'S1|S2|S4|S5|S6'; % All students
    %Subjects = 'S2|S3|S6'; % "Senior" S5 only has PFC data and is thus excluded
    %Subjects = 'S1|S4|S7|S8'; % "Junior"
    withScore = 0;
    changeDirection = 0;
    swapClasses = 0;
    PDFxlabel = 'LDA projected scores (fNIRS)';
    PDFlegend = {'Training day N PDF', 'Training day N trials', 'Training day 1 PDF', 'Training day 1 trials'};
       
    % END DEBUG ZONE
    % --------------------------------------------------------------------
    [BoxDataFLS, BoxDataNIRS, BoxGroupNIRS] = drawLearningBoxplotsbyDay(C_trials, CTRLdata, CTRLscore, V_trials, VBLASTdata, VBLASTscore, Subjects);
    plotScoreCUSUM(VBLASTscore, V_trials)
    [BoxScore] = drawLearningbyTrial(V_trials, VBLASTdata, VBLASTscore, Subjects);
    drawLearningBoxplotsFinal(C_trials, CTRLdata, CTRLscore, V_trials, VBLASTdata, VBLASTscore, Subjects);
    
    % Perform LDA on Control vs FLS (pre and post)
    % -------------------------------------------------------------------- 
    
    LDAData    = ReadDatabyRegionVBLAST(novicedata,expertdata,Novice_score, Expert_score, ToolPathlength.Novice_Right_Trial, ToolPathlength.Expert_Right_Trial, BrainRegions, withScore, withPathLength);
    LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
    PlotResults(LDAModel,LDAData,Display,changeDirection);
    hold on
    CTRLweighted = compareLearning(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.1,1), LDAData, LDAModel, BrainRegions);
    VBLASTweighted = compareLearning(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'VBLaST Final'),:),0.1,1), LDAData, LDAModel, BrainRegions);
    FLSweighted = compareLearning(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.1,1), LDAData, LDAModel, BrainRegions);
    FLSweighted = deleteoutliers(FLSweighted,0.2,1);
    ylim([ -0.25 0.9])
    Y1 = repmat(-.03,size(CTRLweighted));
    Y2 = repmat(-.07,size(VBLASTweighted));
    Y3 = repmat(-.15,size(FLSweighted));
    
    plot(CTRLweighted,Y1,'xk','MarkerSize',12,'LineWidth',2.0)
    plot(VBLASTweighted,Y2,'or','MarkerSize',12,'LineWidth',2.0)
    plot(FLSweighted,Y3,'^g','MarkerSize',12,'LineWidth',2.0)
    hold off
    legend
    
    LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'VBLaST Final'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'Day1'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'Day9'),:),0.05,1), BrainRegions, withScore);
    LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
    PlotResults(LDAModel,LDAData,Display,changeDirection);
    ylim([-0.25 1.8])
    hold on
    Noviceweighted = compareLearning(novicedata, LDAData, LDAModel, BrainRegions);
    Noviceweighted = deleteoutliers(Noviceweighted,0.2,1);
    Expertweighted = compareLearning(expertdata, LDAData, LDAModel, BrainRegions);
    Expertweighted = deleteoutliers(Expertweighted,0.2,1);
    FLSweighted = compareLearning(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.1,1), LDAData, LDAModel, BrainRegions);
    Y1 = repmat(-.05,size(Noviceweighted));
    Y2 = repmat(-.1,size(Expertweighted));
    Y3 = repmat(-.2,size(FLSweighted));
    
    plot(Noviceweighted,Y1,'xb','MarkerSize',12,'LineWidth',2.0)
    plot(Expertweighted,Y2,'og','MarkerSize',12,'LineWidth',2.0)
    plot(FLSweighted,Y3,'^k','MarkerSize',12,'LineWidth',2.0)
    hold off
    legend
    
    
    LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
    PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
    if (changeDirection==1)
        CVMCE = 100*sum((1-LDACVModel.pValueTypeII)<0.05)/size(LDACVModel.pValueTypeII,2);
    else
        CVMCE = 100*sum(LDACVModel.pValueTypeII<0.05)/size(LDACVModel.pValueTypeII,2);
    end
    ylim([0 1]);
    
    
    
    
%     LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day1'),:),0.05,1), deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day9'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'Day1'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'Day9'),:),0.05,1), BrainRegions, withScore);
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
%     LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day10'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'Day10'),:),0.05,1), BrainRegions, withScore);
%     LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
%     PlotResults(LDAModel,LDAData,Display,changeDirection);
%     legend('Control post-test PDF','Control post-test trials','VBLaST post-test PDF','VBLaST post-test');
%     LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
%     PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
%     if (changeDirection==1)
%         CVMCE = 100*sum(((1-LDACVModel.pValueTypeII)<0.05))/size(LDACVModel.pValueTypeII,2);
%     else
%         CVMCE = 100*sum(LDACVModel.pValueTypeII<0.05)/size(LDACVModel.pValueTypeII,2);
%     end
%     
%     ylim([0 1]);

%     LDAData = ReadDatabyRegion(novicedata, deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), Novice_score, deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'CTRL Final'),:),0.05,1), BrainRegions, withScore);
%     LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
%     PlotResults(LDAModel,LDAData,Display,changeDirection);
%     legend('Expert distribution','Expert trials', 'Control distribution','Control trials');
%     LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
%     PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
%     ylim([0 1]);
%     createCVLDAcolormap(LDAData,LDACVModel,0.05,  [112 48 160]/256,[0 176 80]/256, CVboxescolor,swapClasses)
    
%     LDAData = ReadDatabyRegion(expertdata, deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1), Expert_score, deleteoutliers(BoxDataFLS(strcmpi(BoxGroupNIRS,'FLS Final'),:),0.05,1), BrainRegions, withScore);
%     LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
%     changeDirection = 1;
%     PlotResults(LDAModel,LDAData,Display,changeDirection);
%     legend('Expert PDF','Expert trials','FLS Senior post-test PDF','FLS Senior post-test');
%     LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
%     PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
%     ylim([0 1]);
%     createCVLDAcolormap(LDAData,LDACVModel,0.05,'g',[1 .25 0],CVboxescolor)
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load Learning data and compare with novice and Expert
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    S_MCE_E_all = [];
    S_MCE_N_all = [];
    CVMCEpercent = [];
    Weights = zeros(5,11);
    AvgNIRSData = zeros(5,11);
    for i = 2:10% [3,4,7,8,9,10,11,12]
        if i<10
            structdayname = ['Day',num2str(i)];
            %LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:),0.05,1), deleteoutliers(CTRLdataAvg(:,:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day1'),:),0.05,1), deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:),0.05,1), VBLASTscore, VBLASTscore, BrainRegions, withScore);
            AvgNIRSData(:,i-1) = nanmean(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:)));
        end
        if i==10
            structdayname = 'VBLaST Final';
            %LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:),0.05,1), deleteoutliers(CTRLdataAvg(:,:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day1'),:),.05,1), deleteoutliers(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:),0.05,1), VBLASTscore, VBLASTscore, BrainRegions, withScore);
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
        CVMCEpercent = [CVMCEpercent; CVMCE];
        
    end
    close all
    drawMCEerrors(S_MCE_E_all,S_MCE_N_all);
    drawCVMCE(CVMCEpercent,[91 155 213]/256);

%end
    
function drawLearningBoxplotsFinal(C_trials, CTRLdata, CTRLscore, F_trials, FLSdata, FLSscore, Subjects)
    titles = {'Left Lateral PFC';'Medial PFC';'Right Lateral PFC';'Left Lateral M1';'Left Medial M1';'Right Medial M1';'Right Lateral M1';'SMA'};
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
    [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'Control pre-test')),BoxData(strcmpi(BoxGroup,'FLS pre-test')),'ranksum');
    text(.20,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'Control post-test')),BoxData(strcmpi(BoxGroup,'FLS post-test')),'ranksum');
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

        [~,ptext] = sigStar(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Control pre-test'),i),BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS pre-test'),i),'ranksum');
        text(.20,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        [~,ptext] = sigStar(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Control post-test'),i),BoxDataNIRS(strcmpi(BoxGroupNIRS,'FLS post-test'),i),'ranksum');
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
    for i = 1:9
        day = ['_D',num2str(i),'_'];
        idx_day = contains(F_trials,day);
        idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
        idx = sum([idx_day,idx_sub],2) > 1;
        structdayname = ['Day',num2str(i)];
        BoxData = [BoxData;FLSscore(idx,:)];
        BoxGroup = [BoxGroup;repmat({structdayname},length(FLSscore(idx,:)),1)];
        BoxColorGroup = [BoxColorGroup;repmat({'V'},length(FLSscore(idx,:)),1)];
    end

    %Structure Break
    BoxData = [BoxData;NaN;NaN];
    BoxGroup = [BoxGroup;{'Break week 1';'Break week 2'}];
    BoxColorGroup = [BoxColorGroup;{'V';'V'}];

    %Structure CTL final
    idx = contains(C_trials,'_Post');
    BoxData = [BoxData;CTRLscore(idx)];
    BoxGroup = [BoxGroup;repmat({'CTRL Final'},size(CTRLscore(idx),1),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'C'},size(CTRLscore(idx),1),1)];

    %Structure FLS final
    idx_day = contains(F_trials,'_Final_');
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    BoxData = [BoxData;FLSscore(idx)];
    BoxGroup = [BoxGroup;repmat({'VBLaST Final'},size(FLSscore(idx),1),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'V'},size(FLSscore(idx),1),1)];

    %Structure FLS final
    idx_day = contains(F_trials,'_FinalFLS_');
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    BoxData = [BoxData;FLSscore(idx)];
    BoxGroup = [BoxGroup;repmat({'FLS Final'},size(FLSscore(idx),1),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'V'},size(FLSscore(idx),1),1)];
    
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
    for i = 1:9
        day = ['_D',num2str(i),'_'];
        idx_day = contains(F_trials,day);
        idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
        idx = sum([idx_day,idx_sub],2) > 1;
        structdayname = ['Day',num2str(i)];
        BoxDataNIRS = [BoxDataNIRS;deleteoutliers(FLSdata(idx,:),.05,1)];
        BoxGroupNIRS = [BoxGroupNIRS;repmat({structdayname},size(FLSdata(idx,1)))];
        BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'V'},size(FLSdata(idx,1)))];
    end

    %Structure break
    BoxDataNIRS = [BoxDataNIRS;NaN(2,8)];
    BoxGroupNIRS = [BoxGroupNIRS;{'Break week 1'; 'Break week 2'}];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;{'V';'V'}];

    %Structure CTL final
    idx = contains(C_trials,'_Post');
    BoxDataNIRS = [BoxDataNIRS;CTRLdata(idx,:)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({'CTRL Final'},size(CTRLdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'C'},size(CTRLdata(idx,1)))];

    %Structure FLS final
    idx_day = contains(F_trials,'_Final_');
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    BoxDataNIRS = [BoxDataNIRS;deleteoutliers(FLSdata(idx,:),.05,1)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({'VBLaST Final'},size(FLSdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'V'},size(FLSdata(idx,1)))];
    
    %Structure FLS final
    idx_day = contains(F_trials,'_FinalFLS_');
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    BoxDataNIRS = [BoxDataNIRS;deleteoutliers(FLSdata(idx,:),.05,1)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({'FLS Final'},size(FLSdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'V'},size(FLSdata(idx,1)))];
    
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

        [~,ptext] = sigStar(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Day 1'),i),BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day1'),i),'ranksum');
        text(.06,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        [~,ptext] = sigStar(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Final'),i),BoxDataNIRS(strcmpi(BoxGroupNIRS,'VBLaST Final'),i),'ranksum');
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
    [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'CTRL Day 1')),BoxData(strcmpi(BoxGroup,'Day1')),'ranksum');
    text(.06,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'CTRL Final')),BoxData(strcmpi(BoxGroup,'VBLaST Final')),'ranksum');
    text(.93,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    set(gca,'FontSize',12,'XTickLabelRotation',45)
    %set(gca,'XTickLabel',{' '});
    ylabel('VBLaST performance score','FontName','Times New Roman','FontSize',16,'interpreter','tex')
    set(gca,'XTickLabel',{'Control pretest', 'Training pretest', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7', 'Day 8', 'Day 9', 'Break week 1', 'Break week 2', 'Control post-test', 'Training post-test', 'FLS post-test'});
    
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
    [t4,~,~,cs4]=CUSUM(FLSscore(contains(F_trials,'S4_D')),SeniorThresh,s,s1);
    [t5,~,~,cs5]=CUSUM(FLSscore(contains(F_trials,'S5_D')),SeniorThresh,s,s1);
    [t6,~,~,cs6]=CUSUM(FLSscore(contains(F_trials,'S6_D')),SeniorThresh,s,s1);

    figure
    %plot the learning curve 
    UL(1:101)=h1;
    LL(1:101)=h0;

    plot(t1,cs1,t2,cs2,t4,cs4,t5,cs5,t6,cs6,'Marker', '*');
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

function drawMCEerrors(MCE_E, MCE_N)
figure
hold on
plot(1:9, MCE_E,'color',[91 155 213]/256,'Marker', '*', 'LineWidth', 2, 'LineStyle', '--')
plot(1:9, MCE_N,'color',[91 155 213]/256,'Marker', '*', 'LineWidth', 2)
set(gca,'FontSize',14);
ylabel('Misclassificaiton error','fontsize',16)
set(gca,'XTickLabel',{'Day2','Day3','Day4','Day5','Day6','Day7','Day8','Final training day','Post-test'})
ylim([0 1]);
hold off
legend('VBLaST MCE_1','VBLaST MCE_2');
xtickangle(45)
end

function drawCVMCE(CVMCEpercent,color)
figure
t = 1:9;
hold on
plot(1:9, CVMCEpercent,'color',color,'Marker', '*', 'LineWidth', 2)
set(gca,'FontSize',20);
ylabel('% samples with MCE < 0.05','fontsize',20)
set(gca,'XTickLabel',{'Day2','Day3','Day4','Day5','Day6','Day7','Day8','Final training day','Post-test'})
xtickangle(45)
ylim([0 100]);
hold off
end

function Xweightedout = compareLearning(data, LDAData, LDAModel, regions)
    X               = data(:,regions);
    X01             = X(~any(isnan(X),2),:);
    K1              = size(X01,1);
    xmean           = LDAData.xmean;
    xstd            = LDAData.xstd;
    Xout            = (X01 - ones(sum(K1),1)*xmean)/diag(xstd);
    Xweightedout    = Xout*LDAModel.P;
end
