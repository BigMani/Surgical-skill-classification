% Perform HRF analysis on MGH FLS dataset with FLS metrics
%
% Author: Arun Nemani

%% DEBUG ZONE

close all
clear variables
global PDFxlabel;
global PDFdist;
global Type_II_E;
global Type_II_N;
PDFxlabel = 'LDA projected scores (fNIRS)';
BrainRegions = [1,2,3,5,8];
%Subjects = 'S1|S2|S3|S4|S6|S7|S8'; % All students
%Subjects = 'S2|S3|S6'; % "Senior" S5 only has PFC data and is thus excluded
Subjects = 'S1|S4|S7|S8'; % "Junior"
%Subjects = 'S2';
withScore = 0;
changeDirection = 0;
drawBoxplots = 0;
plotCUSUM = 0;
createGIF = 1;
method = 3; %1 - report maximum peak value of HRFs, 2 - report integral of HRFs, 3 - report average value across entire HRF
SeniorThresh = 60;
JuniorThresh = 41;
IntermediateThresh = 65;
PFC_THRESH = .5; %Junior: 41, Intermediate: 65, Senior: 76
M_THRESH = -.2; %Junior: 59, Intermediate: 64, Senior: 68
SMA_THRESH = -.5;

%% Initializations
FLS = 'Learning_FLS_2.mat';
CTRL = 'Learning_CTRL.mat';
%CTRL = 'CTRL_Learning_HRF_2';
%FLSfinal = 'FLS_FINAL_HRF.mat';
Display = [{'0'} {'2'} {'0'} {'2'} {'1'} {'0'}];
crossVDisplay = [{'0'} {'0'} {'0'} {'0'} {'0'} {'1'}];
titles_2 = {'Left Lateral PFC';
'Medial PFC';
'Right Lateral PFC';
'Left Lateral M1';
'Left Medial M1';
'Right Medial M1';
'Right Lateral M1';
'SMA'};

F = load(FLS);
F_trials = fields(F.(char(fields(F))));

C = load(CTRL);
C_trials = fields(C.(char(fields(C))));

FLSdata = zeros(length(F_trials),8);
FLSscore = zeros(length(F_trials),1);
for i=1:length(F_trials) 
    name = char(F_trials(i));
    FLSscore(i,1) = F.(char(fields(F))).(name).score;
    for j = 1:32
        if method == 1
            [aa,~] = HRF_LocalMaxima(F.(char(fields(F))).(name).data(:,j));
            Temp2(j,1) = max(aa);
        elseif method ==2
            Temp2(j,1) = HRF_Integral(F.(char(fields(F))).(name).data(:,j));
        else
            Temp2(j,1) = HRF_Avg(F.(char(fields(F))).(name).data(:,j));
        end
    end
    g2(1,1) = nanmean(Temp2(1:2,:));
    g2(1,2) = nanmean(Temp2(4:5,:));
    g2(1,3) = nanmean(Temp2(7:8,:));
    g2(1,4) = nanmean(Temp2(10:13,:));
    g2(1,5) = nanmean(Temp2(15:18,:));
    g2(1,6) = nanmean(Temp2(20:23,:));
    g2(1,7) = nanmean(Temp2(25:28,:));
    g2(1,8) = nanmean(Temp2(30:32,:));
    FLSdata(i,:) = g2;
end

CTRLdata = zeros(length(C_trials),8);
CTRLscore = zeros(length(C_trials),1);
for i=1:length(C_trials) 
    name = char(C_trials(i));
    CTRLscore(i,1) = C.(char(fields(C))).(name).score;
    Temp2 = zeros(31,1);
    for j = 1:32
        if method == 1
            [aa,~] = HRF_LocalMaxima(C.(char(fields(C))).(name).data(:,j));
            Temp2(j,1) = max(aa);
        elseif method ==2
            Temp2(j,1) = HRF_Integral(C.(char(fields(C))).(name).data(:,j));
        else
            Temp2(j,1) = HRF_Avg(C.(char(fields(C))).(name).data(:,j));
        end
    end
    g2(1,1) = nanmean(Temp2(1:2,:));
    g2(1,2) = nanmean(Temp2(4:5,:));
    g2(1,3) = nanmean(Temp2(7:8,:));
    g2(1,4) = nanmean(Temp2(10:13,:));
    g2(1,5) = nanmean(Temp2(15:18,:));
    g2(1,6) = nanmean(Temp2(20:23,:));
    g2(1,7) = nanmean(Temp2(25:28,:));
    g2(1,8) = nanmean(Temp2(30:32,:));
    CTRLdata(i,:) = g2;
end

%% Remove large outliers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i = 1:8
%     for j = 1:12
%         structdayname = ['Day',num2str(j)];
%         FLS_byDay.(structdayname)(:,i) = deleteoutliers(FLS_byDay.(structdayname)(:,i),.05,1);
%         %FLS_byDay.(structdayname)(:,i) = removeOutlier(FLS_byDay.(structdayname)(:,i));
%     end
%    %FLSfinaldata(:,i) = removeOutlier(FLSfinaldata(:,i));
%    %FLS_byDay.Day11(:,i) = removeOutlier(FLS_byDay.Day11(:,i));
%    %FLS_byDay.Day1(:,i) = removeOutlier(FLS_byDay.Day1(:,i));
%    %CTRLposttest(:,i) = removeOutlier(CTRLposttest(:,i));
% end

%FLS_byDay.Day1(16,:) = [];
%FLSfinaldata(14,:) = [];
%CTRLposttest([4,8],:) = [];

%% Plot FLS scores by day
%%%%%%%%%%%%%%%%%%%%%%%%%
dayGroup = [];

%Strucutre CTRL pre test scores
idx = ~cellfun(@isempty,strfind(C_trials,'_Pre'));
CTRLpretestscore = CTRLscore(idx);
%CTRLpretestscore = [38;84;44;34;57;79;55;30;54;0;10;85;0;0;0;0];
dayGroup = [dayGroup;repmat({'CTRL Day 1'},size(CTRLpretestscore,1),1)];

idx = [];
%Strucutre FLS learning
for i = 1:12
    day = ['_D',num2str(i),'_'];
    idx_day = ~cellfun(@isempty,strfind(F_trials,day));
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = sum([idx_day,idx_sub],2) > 1;
    structdayname = ['Day',num2str(i)];
    FLS_byDayScore.(structdayname) = FLSscore(idx,:);
    dayGroup = [dayGroup;repmat({structdayname},length(FLS_byDayScore.(structdayname)),1)];
end

%Structure break
BREAK = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN];
dayGroup = [dayGroup;{'Break week 1';'Break week 2'}];

%Structure CTL final
idx_C = ~cellfun(@isempty,strfind(C_trials,'_Post'));
CTRLposttestscore = CTRLscore(idx_C);
%CTRLposttestscore = [87;94;60;57;99;128;54;67;106;63];
dayGroup = [dayGroup;repmat({'CTRL Final'},size(CTRLposttestscore,1),1)];

%Structure FLS final
idx_day = ~cellfun(@isempty,strfind(F_trials,'_Final'));
idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
idx = sum([idx_day,idx_sub],2) > 1;
FLSposttestscore = FLSscore(idx);
%FLSposttestscore = [219;227;206;236;237;211;228;230;222;229;237;222;223;229;235;244;246;222;245;250];
dayGroup = [dayGroup;repmat({'FLS final'},size(FLSposttestscore,1),1)];

if(drawBoxplots)
for k = 1:11
    figure
    g = boxplot([CTRLpretestscore(:,k);NaN(size(dayGroup,1)-(size(CTRLpretestscore,1))-(size(CTRLposttestscore,1))-(size(FLSposttestscore,1)),1);CTRLposttestscore(:,k);NaN(size(FLSposttestscore,1),1)],dayGroup,'Colors','r');
    hold on
    h = boxplot([NaN(size(CTRLpretestscore,1),1);FLS_byDayScore.Day1(:,k);FLS_byDayScore.Day2(:,k);FLS_byDayScore.Day3(:,k);FLS_byDayScore.Day4(:,k);FLS_byDayScore.Day5(:,k);FLS_byDayScore.Day6(:,k);FLS_byDayScore.Day7(:,k);FLS_byDayScore.Day8(:,k);FLS_byDayScore.Day9(:,k);FLS_byDayScore.Day10(:,k);FLS_byDayScore.Day11(:,k);FLS_byDayScore.Day12(:,k);BREAK(:,k);BREAK(:,k);NaN(size(CTRLposttestscore,1),1);FLSposttestscore(:,k)],dayGroup,'Colors','b');
    hold off
    set(gca,'FontSize',16,'XTickLabelRotation',45)
    ylim([-50 300]);
    ylabel('FLS pattern cutting score','FontName','Times New Roman','FontSize',22,'interpreter','tex')
    title('FLS pattern cutting learning curve', 'FontSize', 16);
    [p] = ranksum(CTRLpretestscore,FLS_byDayScore.Day1);
    p = floor(p*1000)/1000;
    if p<0.05
        pp = '*';
    else
        pp = 'n.s.';
    end
    text(.06,.08,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    [P] = ranksum(CTRLposttestscore,FLSposttestscore);
    P = floor(P*1000)/1000;
    if P<0.05
        PP = '*';
    else
        PP = 'n.s.';
    end
    text(.93,.08,PP,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
end
end

%% Plot NIRS by day
%%%%%%%%%%%%%%%%%%%%%%%%%
dayGroup = [];

%Strucutre CTRL pre test NIRS
idx = ~cellfun(@isempty,strfind(C_trials,'_Pre'));
CTRLpretest = CTRLdata(idx,:);
dayGroup = [dayGroup;repmat({'CTRL Day 1'},size(CTRLpretest,1),1)];

%Strucutre FLS learning NIRS
for i = 1:11
    day = ['_D',num2str(i),'_'];
    idx_day = ~cellfun(@isempty,strfind(F_trials,day));
    idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
    idx = nansum([idx_day,idx_sub],2) > 1;
    dayname = ['FLS Day ',num2str(i)];
    structdayname = ['Day',num2str(i)];
    FLS_byDay.(structdayname) = FLSdata(idx,:);
%     for j = 1:8
%         FLS_byDay.(structdayname)(:,j) = deleteoutliers(FLS_byDay.(structdayname)(:,j),.05,1);
%     end
        %FLS_byDay.(structdayname)(:,i) = removeOutlier(FLS_byDay.(structdayname)(:,i));
    dayGroup = [dayGroup;repmat({structdayname},length(FLS_byDay.(structdayname)),1)];
end

%Structure break
BREAK = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN];
dayGroup = [dayGroup;{'Break week 1';'Break week 2'}];

%Structure CTL final NIRS
idx = ~cellfun(@isempty,strfind(C_trials,'_Post'));
CTRLposttest = CTRLdata(idx,:);
dayGroup = [dayGroup;repmat({'CTRL Final'},size(CTRLposttest,1),1)];

%Structure FLS final NIRS
idx_day = ~cellfun(@isempty,strfind(F_trials,'_Final'));
idx_sub = ~cellfun(@isempty,regexp(F_trials,Subjects));
idx = nansum([idx_day,idx_sub],2) > 1;
FLSposttest = FLSdata(idx,:);
dayGroup = [dayGroup;repmat({'FLS final'},size(FLSposttest,1),1)];

CTRLmiddle = NaN((size(dayGroup,1)-(size(CTRLpretest,1))-(size(CTRLposttest,1))-(size(FLSposttest,1))),1);
if (drawBoxplots)
    for k = [1:3,5,8]
        %subplot(2,2,k)
        figure
        boxcontrol = [CTRLpretest(:,k);CTRLmiddle;CTRLposttest(:,k);NaN(size(FLSposttest,1),1)];
        g = boxplot(boxcontrol,dayGroup,'Colors','r');
        hold on
        boxFLS = [NaN(size(CTRLpretest,1),1);FLS_byDay.Day1(:,k);FLS_byDay.Day2(:,k);FLS_byDay.Day3(:,k);FLS_byDay.Day4(:,k);FLS_byDay.Day5(:,k);FLS_byDay.Day6(:,k);FLS_byDay.Day7(:,k);FLS_byDay.Day8(:,k);FLS_byDay.Day9(:,k);FLS_byDay.Day10(:,k);FLS_byDay.Day11(:,k);BREAK(1,k);BREAK(1,k);NaN(size(CTRLposttest,1),1);FLSposttest(:,k)];
        h = boxplot(boxFLS,dayGroup,'Colors','b');
        hold off
        set(gca,'FontSize',14,'XTickLabelRotation',45)
        ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',18,'interpreter','tex')
        title(titles_2(k), 'FontSize', 16);
        p = ranksum(CTRLpretest(:,k),FLS_byDay.Day1(:,k));
        p = floor(p*1000)/1000;
        if p<0.05
            pp = '*';
        else
        end
            pp = 'n.s.';
        text(.06,.08,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        P = ranksum(CTRLposttest(:,k),FLSposttest(:,k));
        P = floor(P*1000)/1000;
        if P<0.05
            PP = '*';
        else
            PP = 'n.s.';
        end
        text(.93,.08,PP,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    end
end

%% CUSUM scores
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    title(titles_2(k), 'FontSize', 16);
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
        title(titles_2(k), 'FontSize', 16);
        legend('FLS-1','FLS-2', 'FLS-3', 'FLS-4','FLS-6','FLS-7','FLS-8');
        hold on;
        plot(1:100,UL, 'Color',[0,0,0], 'LineWidth', 2);
        plot(1:100,LL, 'Color',[0,0,0], 'LineWidth', 2);
        hold off;
        clear UL;
        clear LL;
    end

end
%% LDA classification

FLSfinaldata = FLSposttest;
% % FLS day1  vs FLS day 12
% 
% LDAData    = ReadDatabyRegion(FLS_byDay.Day1,FLS_byDay.Day11,FLS_byDayScore.Day1,FLS_byDayScore.Day11,BrainRegions,withScore);
% LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
% PlotResults(LDAModel,LDAData,Display,changeDirection);
% LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
% PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
% 
% % FLS day12  vs FLS Final
% 
% LDAData    = ReadDatabyRegion(FLSfinaldata,FLS_byDay.Day11,FLSposttestscore,FLS_byDayScore.Day11,BrainRegions,withScore);
% LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
% PlotResults(LDAModel,LDAData,Display,changeDirection);
% LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
% PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
% 
% % CTRL post test  vs FLS final
% 
% LDAData    = ReadDatabyRegion(CTRLposttest,FLSfinaldata,CTRLposttestscore,FLSposttestscore,BrainRegions,withScore);
% LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
% PlotResults(LDAModel,LDAData,Display,changeDirection);
% LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
% PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
MCE_N = [];
MCE_E = [];
if (createGIF)
    for i = 2:11
        if i<12
            structdayname = ['Day',num2str(i)];
        end
        if i==12
            structdayname = 'FLS Final';
        end
        LDAData    = ReadDatabyRegion(FLS_byDay.Day1,FLS_byDay.(structdayname),FLS_byDayScore.Day1,FLS_byDayScore.(structdayname),BrainRegions,withScore);
        LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
        Weights(:,i-1) = LDAModel.P;
        PlotResults(LDAModel,LDAData,Display,changeDirection);
        MCE_N = [MCE_N;Type_II_N];
        MCE_E = [MCE_E;Type_II_E];
        title(structdayname);
        f = getframe(gcf);
        [im,map] = rgb2ind(f.cdata,512,'nodither');
        if i==2
            imwrite(im,map,'Test.gif','gif','Loopcount',inf,'DelayTime',1);
        else
            imwrite(im,map,'Test.gif','gif','DelayTime',1,'WriteMode','append');
        end
    end
    plot(1:10,Weights,'Marker', '*', 'LineWidth', 2);
    legend(titles_2(BrainRegions));
end
