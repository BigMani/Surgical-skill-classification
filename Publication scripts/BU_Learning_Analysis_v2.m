% Perform differentiation and classification analysis on UB learning curve
% data
% Author: Arun Nemani

% ------------------------------------------------------------------------
% DEBUG ZONE

close all
clear
global PDFxlabel;
global LDAcov;
global tf;
global Type_II_E;
global Type_II_N;
PDFxlabel = 'LDA projected scores (fNIRS)';
BrainRegions = [1,2,3,5,8];
Subjects = 'S1|S2|S3|S4|S6|S7|S8'; % All students
%Subjects = 'S2|S3|S6'; %"Senior" S5 only has PFC data and is thus excluded
%Subjects = 'S1|S4|S7|S8'; % "Junior"
withScore = 0;
changeDirection = 0;
drawBoxplots = 1;
plotCUSUM = 0;
createGIF = 1;
method = 3; %1 - report maximum peak value of HRFs, 2 - report integral of HRFs, 3 - report average value across entire HRF
SeniorThresh = 63;
PFC_THRESH = .5;
M_THRESH = -.2;
SMA_THRESH = -.5;

% ------------------------------------------------------------------------
% Initializations
global PDFdist;
PDFDist = [];
[C_trials, CTRLdata, CTRLscore, F_trials, FLSdata, FLSscore] = ReadData_LearningCurve('Learning_FLS_2.mat', 'Learning_CTRL.mat',method);

Display = [{'1'} {'2'} {'1'} {'2'} {'1'} {'2'}];
crossVDisplay = [{'0'} {'0'} {'0'} {'0'} {'0'} {'1'}];
titles = {'Left Lateral PFC';'Medial PFC';'Right Lateral PFC';'Left Lateral M1';'Left Medial M1';'Right Medial M1';'Right Lateral M1';'SMA'};

% ------------------------------------------------------------------------
% Plot FLS scores by day
if(drawBoxplots)
    
BoxGroup = [];
BoxData = [];
BoxColorGroup = [];

%Strucutre CTRL pre test scores
idx = ~cellfun(@isempty,strfind(C_trials,'_Pre'));
BoxData = [BoxData;CTRLscore(idx)];
BoxGroup = [BoxGroup;repmat({'CTRL Day 1'},size(CTRLscore(idx),1),1)];
BoxColorGroup = [BoxColorGroup; repmat({'C'},size(CTRLscore(idx),1),1)];

FLSscorebyDay = [];
FLSscorebyDayGroup = [];
%Strucutre FLS learning
for i = 1:11
    day = ['_D',num2str(i),'_'];
    idx_day = ~cellfun(@isempty,strfind(F_trials,day));
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    structdayname = ['Day',num2str(i)];
    BoxData = [BoxData;FLSscore(idx,:)];
    FLSscorebyDay = [FLSscorebyDay;FLSscore(idx,:)];
    BoxGroup = [BoxGroup;repmat({structdayname},length(FLSscore(idx,:)),1)];
    FLSscorebyDayGroup = [FLSscorebyDayGroup;repmat({structdayname},length(FLSscore(idx,:)),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'F'},length(FLSscore(idx,:)),1)];
end

%Structure break
BoxData = [BoxData;NaN;NaN];
BoxGroup = [BoxGroup;{'Break week 1';'Break week 2'}];
BoxColorGroup = [BoxColorGroup;{'F';'F'}];

%Structure CTL final
idx = ~cellfun(@isempty,strfind(C_trials,'_Post'));
BoxData = [BoxData;CTRLscore(idx)];
BoxGroup = [BoxGroup;repmat({'CTRL Final'},size(CTRLscore(idx),1),1)];
BoxColorGroup = [BoxColorGroup;repmat({'C'},size(CTRLscore(idx),1),1)];

%Structure FLS final
idx_day = ~cellfun(@isempty,strfind(F_trials,'_Final'));
idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
idx = sum([idx_day,idx_sub],2) > 1;
BoxData = [BoxData;FLSscore(idx)];
FLSscorebyDay = [FLSscorebyDay;FLSscore(idx,:)];
BoxGroup = [BoxGroup;repmat({'FLS Final'},size(FLSscore(idx),1),1)];
FLSscorebyDayGroup = [FLSscorebyDayGroup;repmat({'FLS Final'},size(FLSscore(idx),1),1)];
BoxColorGroup = [BoxColorGroup;repmat({'F'},size(FLSscore(idx),1),1)];

% ------------------------------------------------------------------------
% Plot NIRS by day

BoxGroupNIRS = [];
BoxDataNIRS = [];
BoxColorGroupNIRS = [];

%Strucutre CTRL pre test scores
idx = ~cellfun(@isempty,strfind(C_trials,'_Pre'));
BoxDataNIRS = [BoxDataNIRS;CTRLdata(idx,:)];
BoxGroupNIRS = [BoxGroupNIRS;repmat({'CTRL Day 1'},size(CTRLdata(idx,1)))];
BoxColorGroupNIRS = [BoxColorGroupNIRS; repmat({'C'},size(CTRLdata(idx,1)))];

%Strucutre FLS learning
FLSdatabyDay = [];
FLSdatabyDayGroup = [];
for i = 1:11
    day = ['_D',num2str(i),'_'];
    idx_day = ~cellfun(@isempty,strfind(F_trials,day));
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    structdayname = ['Day',num2str(i)];
    BoxDataNIRS = [BoxDataNIRS;FLSdata(idx,:)];
    FLSdatabyDay = [FLSdatabyDay;FLSdata(idx,:)];
    BoxGroupNIRS = [BoxGroupNIRS;repmat({structdayname},size(FLSdata(idx,1)))];
    FLSdatabyDayGroup = [FLSdatabyDayGroup;repmat({structdayname},size(FLSdata(idx,1)))];
    BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'F'},size(FLSdata(idx,1)))];
end

%Structure break
BoxDataNIRS = [BoxDataNIRS;NaN(2,8)];
BoxGroupNIRS = [BoxGroupNIRS;{'Break week 1'; 'Break week 2'}];
BoxColorGroupNIRS = [BoxColorGroupNIRS;{'F';'F'}];

%Structure CTL final
idx = ~cellfun(@isempty,strfind(C_trials,'_Post'));
BoxDataNIRS = [BoxDataNIRS;CTRLdata(idx,:)];
BoxGroupNIRS = [BoxGroupNIRS;repmat({'CTRL Final'},size(CTRLdata(idx,1)))];
BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'C'},size(CTRLdata(idx,1)))];

%Structure FLS final
idx_day = ~cellfun(@isempty,strfind(F_trials,'_Final'));
idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
idx = sum([idx_day,idx_sub],2) > 1;
BoxDataNIRS = [BoxDataNIRS;FLSdata(idx,:)];
FLSdatabyDay = [FLSdatabyDay;FLSdata(idx,:)];
BoxGroupNIRS = [BoxGroupNIRS;repmat({'FLS Final'},size(FLSdata(idx,1)))];
FLSdatabyDayGroup = [FLSdatabyDayGroup;repmat({'FLS Final'},size(FLSdata(idx,1)))];
BoxColorGroupNIRS = [BoxColorGroupNIRS;repmat({'F'},size(FLSdata(idx,1)))];

% ------------------------------------------------------------------------
% % Remove large outliers

% Fields = unique(FLSdatabyDayGroup);
% for i = 1:length(Fields)
%     for j = 1:8
%         FLSdatabyDay(strcmpi(FLSdatabyDayGroup,Fields(i)),j) = deleteoutliers(FLSdatabyDay(strcmpi(FLSdatabyDayGroup,Fields(i)),j),.05,1);
%     end
% end

% ------------------------------------------------------------------------
% Draw FLS performance boxplots

figure
for i=[1:3,5,8]
    if(i==5)
        subplot(2,3,4)
    elseif(i==8)
        subplot(2,3,5)
    else
        subplot(2,3,i)
    end
    boxplot(BoxDataNIRS(:,i),BoxGroupNIRS,'PlotStyle','compact','colorgroup',BoxColorGroupNIRS,'colors',[0 1 1; 1 0 1],'medianstyle', 'line');
    %set(findobj('Tag','Box'),'LineWidth',2);
    set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
    set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
    set(gca,'FontSize',16,'XTickLabelRotation',45)
    ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',18,'interpreter','tex')
    title('FLS pattern cutting learning curve', 'FontSize', 16);

    [~,ptext] = sigStar(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Day 1'),i),BoxDataNIRS(strcmpi(BoxGroup,'Day1'),i),'ttest');
    text(.06,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    [~,ptext] = sigStar(BoxDataNIRS(strcmpi(BoxGroup,'CTRL Final'),i),BoxDataNIRS(strcmpi(BoxGroup,'FLS Final'),i),'ttest');
    text(.93,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    title(titles(i));
end

subplot(2,3,6)
% Draw FLS performance boxplots
boxplot(BoxData,BoxGroup,'PlotStyle','compact','colorgroup',BoxColorGroup,'colors',[0 1 1; 1 0 1],'medianstyle', 'line');
set(gca,'FontSize',14)
set(findobj('Tag','Box'),'LineWidth',2);
set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
ylim([-50 300]);
ylabel('FLS pattern cutting score','FontName','Times New Roman','FontSize',22,'interpreter','tex')
title('FLS pattern cutting learning curve', 'FontSize', 16);
[~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'CTRL Day 1')),BoxData(strcmpi(BoxGroup,'Day1')),'ttest');
text(.06,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
[~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'CTRL Final')),BoxData(strcmpi(BoxGroup,'FLS Final')),'ttest');
text(.93,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
end

% ------------------------------------------------------------------------
% CUSUM scores

if (plotCUSUM)
    p0 = 0.05;
    p1 = .1;
    alpha = 0.05;
    beta = 0.20;

    P = log(p1/p0);
    Q = log((1-p0)/(1-p1));
    s = Q/(P+Q);
    s1 = 1-s;
    a = log((1-beta)/alpha);
    b = log((1-alpha)/beta);
    h0 = -b/(P+Q);
    h1 = a/(P+Q);

    % Plot learning curves for left, medial, and right PFC
    for k = 1:3
    idx = ~cellfun(@isempty,strfind(F_trials,'S1'));
    [t1,~,~,cs1]=CUSUM_PFC(FLSdata(idx,k),PFC_THRESH,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S2'));
    [t2,~,~,cs2]=CUSUM_PFC(FLSdata(idx,k),PFC_THRESH,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S3'));
    [t3,~,~,cs3]=CUSUM_PFC(FLSdata(idx,k),PFC_THRESH,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S4'));
    [t4,~,~,cs4]=CUSUM_PFC(FLSdata(idx,k),PFC_THRESH,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S6'));
    [t6,~,~,cs6]=CUSUM_PFC(FLSdata(idx,k),PFC_THRESH,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S7'));
    [t7,~,~,cs7]=CUSUM_PFC(FLSdata(idx,k),PFC_THRESH,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S8'));
    [t8,~,~,cs8]=CUSUM_PFC(FLSdata(idx,k),PFC_THRESH,s,s1);

    figure
    %plot the learning curve 
    UL(1:100)=h1;
    LL(1:100)=h0;

    plot(t1,cs1,t2,cs2,t3,cs3,t4,cs4,t6,cs6,t7,cs7,t8,cs8,'Marker', '*');
    ylabel('NIRS CUSUM SCORE','fontsize',16)
    xlabel('Trial','fontsize',16);
    title(titles(k), 'FontSize', 16);
    legend('FLS-1','FLS-2', 'FLS-3', 'FLS-4','FLS-6','FLS-7','FLS-8');
    hold on;
    plot(1:100,UL, 'Color',[0,0,0], 'LineWidth', 2);
    plot(1:100,LL, 'Color',[0,0,0], 'LineWidth', 2);
    hold off;
    clear UL;
    clear LL;
    end

    % Plot learning curves for left, medial, and right PFC
    for k = 1:1
    idx = ~cellfun(@isempty,strfind(F_trials,'S1'));
    [t1,~,~,cs1]=CUSUM(FLSscore(idx,k),SeniorThresh,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S2'));
    [t2,~,~,cs2]=CUSUM(FLSscore(idx,k),SeniorThresh,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S3'));
    [t3,~,~,cs3]=CUSUM(FLSscore(idx,k),SeniorThresh,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S4'));
    [t4,~,~,cs4]=CUSUM(FLSscore(idx,k),SeniorThresh,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S6'));
    [t6,~,~,cs6]=CUSUM(FLSscore(idx,k),SeniorThresh,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S7'));
    [t7,~,~,cs7]=CUSUM(FLSscore(idx,k),SeniorThresh,s,s1);
    idx = ~cellfun(@isempty,strfind(F_trials,'S8'));
    [t8,~,~,cs8]=CUSUM(FLSscore(idx,k),SeniorThresh,s,s1);

    figure
    %plot the learning curve 
    UL(1:100)=h1;
    LL(1:100)=h0;

    plot(t1,cs1,t2,cs2,t4,cs4,t6,cs6,t7,cs7,t8,cs8,t3,cs3,'Marker', '*');

    ylabel('CUSUM SCORE','fontsize',16)
    xlabel('Trial','fontsize',16);
    title('FLS PC score learning curve', 'FontSize', 16);
    legend('FLS-1','FLS-2', 'FLS-3', 'FLS-4','FLS-6','FLS-7','FLS-8');
    hold on;
    plot(1:100,UL, 'Color',[0,0,0], 'LineWidth', 2);
    plot(1:100,LL, 'Color',[0,0,0], 'LineWidth', 2);
    hold off;
    clear UL;
    clear LL;
    end

    for k = 5:8
        if(k==5)
            idx = ~cellfun(@isempty,strfind(F_trials,'S1'));
            [t1,~,~,cs1]=CUSUM(FLSdata(idx,k),M_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S2'));
            [t2,~,~,cs2]=CUSUM(FLSdata(idx,k),M_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S3'));
            [t3,~,~,cs3]=CUSUM(FLSdata(idx,k),M_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S4'));
            [t4,~,~,cs4]=CUSUM(FLSdata(idx,k),M_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S6'));
            [t6,~,~,cs6]=CUSUM(FLSdata(idx,k),M_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S7'));
            [t7,~,~,cs7]=CUSUM(FLSdata(idx,k),M_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S8'));
            [t8,~,~,cs8]=CUSUM(FLSdata(idx,k),M_THRESH,s,s1);
        else
            idx = ~cellfun(@isempty,strfind(F_trials,'S1'));
            [t1,~,~,cs1]=CUSUM(FLSdata(idx,k),SMA_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S2'));
            [t2,~,~,cs2]=CUSUM(FLSdata(idx,k),SMA_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S3'));
            [t3,~,~,cs3]=CUSUM(FLSdata(idx,k),SMA_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S4'));
            [t4,~,~,cs4]=CUSUM(FLSdata(idx,k),SMA_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S6'));
            [t6,~,~,cs6]=CUSUM(FLSdata(idx,k),SMA_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S7'));
            [t7,~,~,cs7]=CUSUM(FLSdata(idx,k),SMA_THRESH,s,s1);
            idx = ~cellfun(@isempty,strfind(F_trials,'S8'));
            [t8,~,~,cs8]=CUSUM(FLSdata(idx,k),SMA_THRESH,s,s1);
        end
        figure
        %plot the learning curve 
        UL(1:100)=h1;
        LL(1:100)=h0;

        plot(t1,cs1,t2,cs2,t3,cs3,t4,cs4,t6,cs6,t7,cs7,t8,cs8,'Marker', '*');
        ylabel('NIRS CUSUM SCORE','fontsize',16)
        xlabel('Trial','fontsize',16);
        title(titles(k), 'FontSize', 16);
        legend('FLS-1','FLS-2', 'FLS-3', 'FLS-4','FLS-6','FLS-7','FLS-8');
        hold on;
        plot(1:100,UL, 'Color',[0,0,0], 'LineWidth', 2);
        plot(1:100,LL, 'Color',[0,0,0], 'LineWidth', 2);
        hold off;
        clear UL;
        clear LL;
    end
end

[LDAData2, LDAdataLabel] = ReadDatabyRegionFull(FLSdatabyDay,FLSscorebyDay,FLSdatabyDayGroup,BrainRegions,withScore);
%LDAData2 = ReadDatabyRegion(BoxDataNIRS,[],BoxData,[],BrainRegions,withScore);

% ------------------------------------------------------------------------
% LDA classification

% CTRL pretest  vs FLS Day1

% LDAData    = ReadDatabyRegion(BoxDataNIRS(strcmpi(BoxGroupNIRS,'CTRL Day 1'),:),BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day1'),:),BoxData(strcmpi(BoxGroup,'CTRL Day 1'),:),BoxData(strcmpi(BoxGroup,'Day1'),:),BrainRegions,withScore);
% LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
% PlotResults(LDAModel,LDAData,Display,changeDirection);
% LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
% PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);

% % CTRL posttest  vs FLS final
% 
% LDAData    = ReadDatabyRegion(BoxDataNIRSnormalized(strcmpi(BoxGroupNIRSnormalized,'CTRL Final'),:),BoxDataNIRSnormalized(strcmpi(BoxGroupNIRSnormalized,'FLS Final'),:),BoxData(strcmpi(BoxGroup,'CTRL Final'),:),BoxData(strcmpi(BoxGroup,'FLS Final'),:),BrainRegions,withScore);
% LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
% PlotResults(LDAModel,LDAData,Display,changeDirection);
% LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
% PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
% 
% % FLS day1  vs FLS day 12
% 
% LDAData    = ReadDatabyRegion(BoxDataNIRSnormalized(strcmpi(BoxGroupNIRSnormalized,'Day1'),:),BoxDataNIRSnormalized(strcmpi(BoxGroupNIRSnormalized,'Day11'),:),BoxData(strcmpi(BoxGroup,'Day1'),:),BoxData(strcmpi(BoxGroup,'Day12'),:),BrainRegions,withScore);
% LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
% PlotResults(LDAModel,LDAData,Display,changeDirection);
% LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
% PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
% 
% % FLS day12  vs FLS Final
% 
% LDAData    = ReadDatabyRegion(BoxDataNIRSnormalized(strcmpi(BoxGroupNIRSnormalized,'FLS Final'),:),BoxDataNIRSnormalized(strcmpi(BoxGroupNIRSnormalized,'Day11'),:),BoxData(strcmpi(BoxGroup,'Final FLS'),:),BoxData(strcmpi(BoxGroup,'Day12'),:),BrainRegions,withScore);
% LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
% PlotResults(LDAModel,LDAData,Display,changeDirection);
% LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
% PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
% 
% %FLS Final vs novices
% 
% LDAData    = ReadDatabyRegion(novicedata,BoxDataNIRSnormalized(strcmpi(BoxGroupNIRSnormalized,'FLS Final'),:),Novice_score,BoxData(strcmpi(BoxGroup,'Final FLS'),:),BrainRegions,withScore);
% LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
% PlotResults(LDAModel,LDAData,Display,changeDirection);
% LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
% PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
% %FLS Final vs experts
% 
% LDAData    = ReadDatabyRegion(expertdata,BoxDataNIRSnormalized(strcmpi(BoxGroupNIRSnormalized,'FLS Final'),:),Expert_score,BoxData(strcmpi(BoxGroup,'Final FLS'),:),BrainRegions,withScore);
% LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
% PlotResults(LDAModel,LDAData,Display,1);
% LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
% PlotResults(LDACVModel,LDAData, crossVDisplay,1);

%LDAData = ReadDatabyRegion(BoxDataNIRS(strcmpi(BoxGroupNIRS,'Day1'),:),BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:),BoxData(strcmpi(BoxGroup,'Day1'),:),BoxData(strcmpi(BoxGroup,structdayname),:),BrainRegions,withScore);

% ------------------------------------------------------------------------
% Create a gif for from analysis of each day
BrainConnectivity = zeros(10,11);
BrainConnectivityP= zeros(10,11);
ActivationIndex = zeros(4,11);
AvgNIRSData = zeros(11,8);
MedianNIRSData = zeros(11,8);
MCE_N = [];
MCE_E = [];
if (createGIF)
    for i = 2:12% [3,4,6,7,8,9,10]
        if i<12
            structdayname = ['Day',num2str(i)];
            LDAData = LDAData2;
            LDAData.X = [LDAData2.X(strcmpi(LDAdataLabel,structdayname),:);LDAData2.X(strcmpi(LDAdataLabel,'Day1'),:)];
            LDAData.K = [size(LDAData2.X(strcmpi(LDAdataLabel,structdayname),:),1),size(LDAData2.X(strcmpi(LDAdataLabel,'Day1'),:),1)];
            AvgNIRSData(i-1,:) = nanmean(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:));
            MedianNIRSData(i-1,:) = nanmedian(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:));
        end
        if i==12
            structdayname = 'FLS Final';
            LDAData = LDAData2;
            LDAData.X = [LDAData2.X(strcmpi(LDAdataLabel,structdayname),:);LDAData2.X(strcmpi(LDAdataLabel,'Day1'),:)];
            LDAData.K = [size(LDAData2.X(strcmpi(LDAdataLabel,structdayname),:),1),size(LDAData2.X(strcmpi(LDAdataLabel,'Day1'),:),1)];
            AvgNIRSData(i-1,:) = nanmean(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:));
            MedianNIRSData(i-1,:) = nanmedian(BoxDataNIRS(strcmpi(BoxGroupNIRS,structdayname),:));
        end
        
        LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
        % Objectively remove outliers from LDAModel
        K1 = deleteoutliers(LDAModel.t(1:LDAData.K(1)),.05,1);
        K2 = deleteoutliers(LDAModel.t(LDAData.K(1)+1:end),.05,1);
        LDAData.K(1) = length(K1(~isnan(K1)));
        LDAData.K(2) = length(K2(~isnan(K2)));
        clear LDAModel.t
        LDAModel.t = [K1(~isnan(K1));K2(~isnan(K2))];
        T = table(LDAData.X(:,1),LDAData.X(:,2),LDAData.X(:,3),LDAData.X(:,4),LDAData.X(:,5),'VariableNames',{'LLPFC','MPFC','RLPFC','LMM1','SMA'});
        [R,P] = corrplot(T,'type','spearman','tail','both','testR','on');
        BrainConnectivity(:,i-1) = [diag(R,-1);diag(R,-2);diag(R,-3);diag(R,-4)];
        BrainConnectivityP(:,i-1) = [diag(P,-1);diag(P,-2);diag(P,-3);diag(P,-4)];
        
        ActivationIndex(1,i-1) = (BrainConnectivity(1,i-1)*nanmean(T.LLPFC)) + (BrainConnectivity(1,i-1)*nanmean(T.MPFC));
        ActivationIndex(2,i-1) = (BrainConnectivity(2,i-1)*nanmean(T.RLPFC)) + (BrainConnectivity(2,i-1)*nanmean(T.MPFC));
        ActivationIndex(3,i-1) = (BrainConnectivity(5,i-1)*nanmean(T.RLPFC)) + (BrainConnectivity(5,i-1)*nanmean(T.LLPFC));
        ActivationIndex(4,i-1) = (BrainConnectivity(8,i-1)*nanmean(T.LLPFC)) - (BrainConnectivity(8,i-1)*nanmean(T.LMM1));
        
%         ActivationIndex(1,i-1) = (BrainConnectivity(1,i-1)*AvgNIRSData(i-1,1)) + (BrainConnectivity(1,i-1)*AvgNIRSData(i-1,2));
%         ActivationIndex(2,i-1) = (BrainConnectivity(1,i-1)*AvgNIRSData(i-1,3)) + (BrainConnectivity(1,i-1)*AvgNIRSData(i-1,2));
%         ActivationIndex(3,i-1) = (BrainConnectivity(1,i-1)*AvgNIRSData(i-1,3)) + (BrainConnectivity(1,i-1)*AvgNIRSData(i-1,1));
%         ActivationIndex(4,i-1) = (BrainConnectivity(1,i-1)*AvgNIRSData(i-1,1)) - (BrainConnectivity(1,i-1)*AvgNIRSData(i-1,5));
%         ActivationIndex(5,i-1) =  -(BrainConnectivity(1,i-1)*AvgNIRSData(i-1,5));
        
        set(gcf,'color','w');
        f = getframe(gcf);
        [im,map] = rgb2ind(f.cdata,256,'nodither');
        if i==2
            imwrite(im,map,'Correlation.gif','gif','Loopcount',inf,'DelayTime',2);
        else
            imwrite(im,map,'Correlation.gif','gif','DelayTime',2,'WriteMode','append');
        end
        
        Weights(:,i-1) = LDAModel.P;
        PlotResults(LDAModel,LDAData,Display,changeDirection);
        title(['Day1 vs ',structdayname]);
        set(gcf,'color','w');
        f = getframe(gcf);
        [im,map] = rgb2ind(f.cdata,512,'nodither');
        if i==2
            imwrite(im,map,'PDF.gif','gif','Loopcount',inf,'DelayTime',2);
        else
            imwrite(im,map,'PDF.gif','gif','DelayTime',2,'WriteMode','append');
        end 
        PDFDist = [PDFDist;PDFdist/range(tf)];
        %Correlation.(structdayname) = corrcov(LDAcov);
        figure
        imagesc(LDAcov);
        set(gca,'XTickLabel',{'LLPFC','MPFC','RLPFC','LMM1','SMA'})
        set(gca,'YTick',1:5)
        set(gca,'YTickLabel',{'LLPFC','MPFC','RLPFC','LMM1','SMA'})
        colorbar
        caxis([0 1]);
        title(['Day1 vs ',structdayname]);
        f = getframe(gcf);
        [im,map] = rgb2ind(f.cdata,512,'nodither');
        if i==2
            imwrite(im,map,'CovTest.gif','gif','Loopcount',inf,'DelayTime',2);
        else
            imwrite(im,map,'CovTest.gif','gif','DelayTime',2,'WriteMode','append');
        end
        MCE_N = [MCE_N;Type_II_N];
        MCE_E = [MCE_E;Type_II_E];
    end
%     figure
%     hold on
%     cmap = colormap(hsv(5));
%     set(gca, 'ColorOrder', cmap);
%     plot(2:length(Weights)+1,Weights,'Marker', '*', 'LineWidth', 2);
%     legend(titles(BrainRegions));
%     ylabel('LDA weights','fontsize',16)
%     set(gca,'XTickLabel',{'Day2','Day3','Day4','Day5','Day6','Day7','Day8','Day9','Day10','Day11'})
%     hold off
    
    figure
    Significant = BrainConnectivityP<=0.05;
    
    Connectivitylabels = {'LLPFC - MPFC','RLPFC - MPFC','RLPFC - LMM1','LMM1 - SMA','RLPFC - LLPFC','MPFC - LLM1','RLPFC - SMA','LLPFC - LMM1','MPFC - SMA','LLPFC - SMA'};
    cmap = colormap(hsv(size(BrainConnectivity,2)));
    set(gca, 'ColorOrder', cmap);
    
    SigCoeff = [1,2,5,8];
    cmap = colormap(cool(length(SigCoeff)));
    hold on
    for k1 = 1:4
        plot(1:size(BrainConnectivity,2),BrainConnectivity(SigCoeff(k1),:),'Color',cmap(k1,:),'Marker', '*', 'LineWidth', 2);
    end
    legend(Connectivitylabels(SigCoeff), 'fontsize', 8, 'Location', 'southeast');
    set(gca,'fontsize',10,'FontName','Helvetica');
    ylabel('Spearman correlation coefficient','fontsize',16,'FontName'   , 'AvantGarde')
    xlabel('Day 1 vs Day (n)', 'fontsize', 16,'FontName'   , 'AvantGarde')
    %title('Correlation of region specific functional activation','fontsize',16, 'FontName','AvantGarde')
    set(gca,'XTickLabel',{'Day 2','Day 3','Day 4','Day 5','Day 6','Day 7','Day 8','Day 9','Day 10','Day 11','Final'})
    set(gca, 'XTickLabelRotation', 45)
    ylim([-1 1]);
    hold off
    
    figure
    Connectivitylabels = {'LLPFC - MPFC','RLPFC - MPFC','RLPFC - LMM1','LMM1 - SMA','RLPFC - LLPFC','MPFC - LLM1','RLPFC - SMA','LLPFC - LMM1','MPFC - SMA','LLPFC - SMA'};
    cmap = colormap(hsv(size(BrainConnectivity,2)));
    set(gca, 'ColorOrder', cmap);
    
    SigCoeff = [1,2,5,8];
    cmap = colormap(cool(4));
    hold on
    for k1 = 1:4
        plot(1:size(ActivationIndex,2),ActivationIndex(k1,:),'Color',cmap(k1,:),'Marker', '*', 'LineWidth', 2);
    end
    legend(Connectivitylabels(SigCoeff), 'fontsize', 8, 'Location', 'southeast');
    set(gca,'fontsize',10,'FontName','Helvetica');
    ylabel('Activation Index','fontsize',16,'FontName'   , 'AvantGarde')
    xlabel('Day 1 vs Day (n)', 'fontsize', 16,'FontName'   , 'AvantGarde')
    set(gca,'XTickLabel',{'Day 2','Day 3','Day 4','Day 5','Day 6','Day 7','Day 8','Day 9','Day 10','Day 11','Final'})
    set(gca, 'XTickLabelRotation', 45)
    ylim([-1 1]);
    hold off
end