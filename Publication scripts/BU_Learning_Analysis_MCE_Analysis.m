
% Perform differentiation and classification analysis on UB learning curve
% data
%
% Author: Arun Nemani

% DEBUG ZONE
% ------------------------------------------------------------------------
clear
close all
Display = [{'0'} {'2'} {'0'} {'2'} {'1'} {'2'}];
crossVDisplay = [{'0'} {'0'} {'0'} {'0'} {'0'} {'1'}];
global PDFxlabel;
global Type_II_E;
global Type_II_N;
PDFxlabel = 'LDA projected scores (fNIRS)';
load('UBLearningData_2.mat')
CVboxescolor = 'gray';
BrainRegions = [1,2,3,5,8];
withScore = 0;
changeDirection = 0;
swapClasses = 0;
PDFxlabel = 'LDA projected scores (fNIRS)';
PDFlegend = {'Training day N PDF', 'Training day N trials', 'Training day 1 PDF', 'Training day 1 trials'};

Subjects = 'S1|S4|S7|S8'; % "Junior"
[BoxDataFLS_J, BoxDataNIRS_J, BoxGroupNIRS_J] = drawLearningBoxplotsbyDay(C_trials, CTRLdataAvg, CTRLscore, F_trials, FLSdataAvg, FLSscore, Subjects);
Subjects = 'S2|S3|S6'; % "Seniors"
[BoxDataFLS_S, BoxDataNIRS_S, BoxGroupNIRS_S] = drawLearningBoxplotsbyDay(C_trials, CTRLdataAvg, CTRLscore, F_trials, FLSdataAvg, FLSscore, Subjects);
% 
% LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,'FLS Final'),:),0.05,1),deleteoutliers(BoxDataNIRS_S(strcmpi(BoxGroupNIRS_S,'FLS Final'),:),0.05,1), deleteoutliers(BoxDataFLS_J(strcmpi(BoxGroupNIRS_J,'FLS Final'),:),0.05,1), deleteoutliers(BoxDataFLS_J(strcmpi(BoxGroupNIRS_J,'FLS Final'),:),0.05,1), BrainRegions, withScore);
%     LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
%     PlotResults(LDAModel,LDAData,Display,changeDirection);
%     legend('FLS junior post-test PDF','FLS junior post-test','Expert PDF','Expert trials');
%     LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
%     PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
%     ylim([0 1]);
%     createCVLDAcolormap(LDAData,LDACVModel,0.05,  [91 155 213]/256,[112 48 160]/256, CVboxescolor,swapClasses)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MCE color maps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 12%[3,5,7,9,11,12]
        MCE = [];
        if i<12
            structdayname = ['Day',num2str(i)];
            CTRLdayname = 'CTRL Day 1';
            MCExlabel = structdayname;
        else
            structdayname = 'FLS Final';
            CTRLdayname = 'CTRL Final';
            MCExlabel = 'Post-test';
        end
        
        if(i==1)
            MCExlabel = 'Post-test';
        end
        % Pre control vs control
            if i<12
                MCE = [MCE;1];
                MCE = [MCE;1];
            else
                LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,CTRLdayname),:),0.05,1), deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,CTRLdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
                LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
                %[LDAData, LDAModel] = filterFDAscores(LDAData, LDAModel);
                PlotResults(LDAModel,LDAData,Display,changeDirection);
                MCE = [MCE;Type_II_E];
                MCE = [MCE;Type_II_N];
            end
changeDirection = 0;
        % Pre control vs Junior
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,CTRLdayname),:),0.05,1), deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,structdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
            %[LDAData, LDAModel] = filterFDAscores(LDAData, LDAModel);
            PlotResults(LDAModel,LDAData,Display,changeDirection);
            MCE = [MCE;Type_II_E];
            MCE = [MCE;Type_II_N];
changeDirection = 0;
        % Pre control vs senior
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,CTRLdayname),:),0.05,1), deleteoutliers(BoxDataNIRS_S(strcmpi(BoxGroupNIRS_S,structdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
            %[LDAData, LDAModel] = filterFDAscores(LDAData, LDAModel);
            PlotResults(LDAModel,LDAData,Display,changeDirection);
            MCE = [MCE;Type_II_E];
            MCE = [MCE;Type_II_N];
changeDirection = 0;
        % Pre junior vs control
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,'Day1'),:),0.05,1),deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,CTRLdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
            %[LDAData, LDAModel] = filterFDAscores(LDAData, LDAModel);
            PlotResults(LDAModel,LDAData,Display,changeDirection);
            MCE = [MCE;Type_II_E];
            MCE = [MCE;Type_II_N];
changeDirection = 0;
        % Pre junior vs junior
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,'Day1'),:),0.05,1), deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,structdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
            %[LDAData, LDAModel] = filterFDAscores(LDAData, LDAModel);
            PlotResults(LDAModel,LDAData,Display,changeDirection);
            MCE = [MCE;Type_II_E];
            MCE = [MCE;Type_II_N];
%             MCE = [MCE;1];
%             MCE = [MCE;1];
changeDirection = 0;   
        % Pre junior vs senior
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,'Day1'),:),0.05,1), deleteoutliers(BoxDataNIRS_S(strcmpi(BoxGroupNIRS_S,structdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
            %[LDAData, LDAModel] = filterFDAscores(LDAData, LDAModel);
            PlotResults(LDAModel,LDAData,Display,changeDirection);
            MCE = [MCE;Type_II_E];
            MCE = [MCE;Type_II_N];
changeDirection = 0;            
        % Pre senior vs control
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS_S(strcmpi(BoxGroupNIRS_S,'Day1'),:),0.05,1), deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,CTRLdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
            %[LDAData, LDAModel] = filterFDAscores(LDAData, LDAModel);
            PlotResults(LDAModel,LDAData,Display,changeDirection);
            MCE = [MCE;Type_II_E];
            MCE = [MCE;Type_II_N];
changeDirection = 0;            
        % Pre senior vs junior
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS_S(strcmpi(BoxGroupNIRS_S,'Day1'),:),0.05,1), deleteoutliers(BoxDataNIRS_J(strcmpi(BoxGroupNIRS_J,structdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
            %[LDAData, LDAModel] = filterFDAscores(LDAData, LDAModel);
            PlotResults(LDAModel,LDAData,Display,changeDirection);
            MCE = [MCE;Type_II_E];
            MCE = [MCE;Type_II_N];
changeDirection = 0;
        % Pre senior vs senior
            LDAData = ReadDatabyRegion(deleteoutliers(BoxDataNIRS_S(strcmpi(BoxGroupNIRS_S,'Day1'),:),0.05,1), deleteoutliers(BoxDataNIRS_S(strcmpi(BoxGroupNIRS_S,structdayname),:),0.05,1), FLSscore, FLSscore, BrainRegions, withScore);
            LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
            PlotResults(LDAModel,LDAData,Display,changeDirection);
            MCE = [MCE;Type_II_E];
            MCE = [MCE;Type_II_N];
%             
%             
%             MCE = [MCE;1];
%             MCE = [MCE;1];
    close all
        createMCEcolormap(MCE, MCExlabel)
    end
    
function [LDAData, LDAModel] = filterFDAscores(LDAData, LDAModel)
% Filter outlier data in FDA model
% ----------------------------------------------------------------
K1 = deleteoutliers(LDAModel.t(1:LDAData.K(1)),.1,1);
K2 = deleteoutliers(LDAModel.t(LDAData.K(1)+1:end),.1,1);
LDAData.K(1) = length(K1(~isnan(K1)));
LDAData.K(2) = length(K2(~isnan(K2)));
clear LDAModel.t
LDAModel.t = [K1(~isnan(K1));K2(~isnan(K2))];
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
        boxplot(BoxDataNIRS(:,i),BoxGroupNIRS,'colorgroup',BoxColorGroupNIRS,'colors',[1 0 1; 0 0 0],'medianstyle', 'line');
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
    boxplot(BoxData,BoxGroup,'colorgroup',BoxColorGroup,'colors',[1 0 1; 0 0 0],'medianstyle', 'line');
    
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