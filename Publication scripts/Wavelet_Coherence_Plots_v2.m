close all
clear

load('MGH_VBLAST_Novice_Coherence.mat');
load('MGH_VBLAST_Expert_Coherence.mat');
load('MGH_FLS_Novice_Coherence.mat');
load('MGH_FLS_Expert_Coherence.mat');
load('MGH_FLS_Training_Coherence.mat');
load('MGH_VBLAST_Training_Coherence.mat');
load('MGH_CTRL_Training_Coherence.mat');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUG ZONE

flipcolormap = 0;
colortype = 'jet';
%FLSSubjects = {'FLS2','FLS3','FLS6'}; %Seniors only
%FLSSubjects = {'FLS1','FLS4','FLS7','FLS8'}; %Juniors only
FLSSubjects = {'FLS1','FLS2','FLS3','FLS4','FLS6','FLS7','FLS8'}; % all subjects
VBLASTLearningSubjects = {'VBLAST1','VBLAST2','VBLAST3','VBLAST4','VBLAST5','VBLAST6'}; % all subjects
LearingcurveFreq = 'WPCO_IV'; % Select from WCO or WCPO with freq ranging from I - V

%END DEBUG ZONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure
% subplot(2,2,1)
% [~, ~] = plotConnectivity(MGH_FLS_Expert_Coherence, MGH_FLS_Novice_Coherence, 'WCO_IV', [192 0 0]/256, [0 176 80]/256, {'FLS','WCO (IV)'});
% subplot(2,2,2)
% [FLS_Struct1Data, FLS_Struct2Data] = plotConnectivity(MGH_FLS_Expert_Coherence, MGH_FLS_Novice_Coherence, 'WPCO_IV', [192 0 0]/256, [0 176 80]/256, {'FLS', 'WPCO (IV)'});
% subplot(2,2,3)
% [~, ~] = plotConnectivity(MGH_VBLAST_Expert_Coherence, MGH_VBLAST_Novice_Coherence, 'WCO_IV', [112 48 160]/256, [91 155 213]/256, {'VBLaST', 'WCO (IV)'});
% subplot(2,2,4)
% [VBLAST_Struct1Data, VBLAST_Struct2Data] = plotConnectivity(MGH_VBLAST_Expert_Coherence, MGH_VBLAST_Novice_Coherence, 'WPCO_IV', [112 48 160]/256, [91 155 213]/256, {'VBLaST', 'WPCO (IV)'});


% [FLSCTRLpre, FLSCTRLpost, FLSpre, FLSpost] = plotFLSLearningConnectivity(MGH_CTRL_Training_Coherence, MGH_FLS_Training_Coherence, FLSSubjects, LearingcurveFreq);
% [VBLASTCTRLpre, VBLASTCTRLpost, VBLASTpre, VBLASTpost] = plotVBLASTLearningConnectivity(MGH_CTRL_Training_Coherence, MGH_VBLAST_Training_Coherence, VBLASTLearningSubjects, LearingcurveFreq);
% close all
% 
% plotFinalConnectivity(FLSCTRLpre, FLSpre, [0 0 0], [192 0 0]/256, {'FLS','WPCO (IV)'});
% plotFinalConnectivity(FLSCTRLpost, FLSpost, [0 0 0], [192 0 0]/256, {'FLS','WPCO (IV)'});
% plotFinalConnectivity(VBLASTCTRLpre, VBLASTpre, [0 0 0], [91 155 213]/256, {'VBLaST','WPCO (IV)'});
% plotFinalConnectivity(VBLASTCTRLpost, VBLASTpost, [0 0 0], [91 155 213]/256, {'VBLaST','WCO (IV)'});


figure
%subplot(2,2,1)
[~, ~] = plotConnectivity(MGH_FLS_Expert_Coherence, MGH_FLS_Novice_Coherence, 'WCO_IV', [192 0 0]/256, [0 176 80]/256, {'FLS WCO'});
%subplot(2,2,2)
figure
[FLS_Struct1Data, FLS_Struct2Data] = plotConnectivity(MGH_FLS_Expert_Coherence, MGH_FLS_Novice_Coherence, 'WPCO_IV', [192 0 0]/256, [0 176 80]/256, {'FLS WPCO'});
%subplot(2,2,3)
figure
[~, ~] = plotConnectivity(MGH_VBLAST_Expert_Coherence, MGH_VBLAST_Novice_Coherence, 'WCO_IV', [112 48 160]/256, [91 155 213]/256, {'VBLaST WCO'});
%subplot(2,2,4)
figure
[VBLAST_Struct1Data, VBLAST_Struct2Data] = plotConnectivity(MGH_VBLAST_Expert_Coherence, MGH_VBLAST_Novice_Coherence, 'WPCO_IV', [112 48 160]/256, [91 155 213]/256, {'VBLaST WPCO'});

figure
subplot(1,4,1)
plotBrainConnectivity(nanmean(FLSCTRLpost,2), colortype, flipcolormap, {'FLS WPCO (IV)','Control subjects'}, 'WCPO')
subplot(1,4,2)
plotBrainConnectivity(nanmean(FLSpost,2), colortype, flipcolormap, {'FLS WPCO (IV)','Trained subjects'}, 'WCPO')
subplot(1,4,3)
plotBrainConnectivity(nanmean(VBLASTCTRLpost,2), colortype, flipcolormap, {'VBLaST WPCO (IV)','Control subjects'}, 'WCPO')
subplot(1,4,4)
plotBrainConnectivity(nanmean(VBLASTpost,2), colortype, flipcolormap, {'VBLaST WPCO (IV)','Trained subjects'}, 'WCPO')
WPCOMeans = [nanmean(FLSCTRLpost(6,:)), nanmean(FLSpost(6,:));nanmean(VBLASTCTRLpost(6,:)), nanmean(VBLASTpost(6,:))];
WPCOErr = [nanstd(FLSCTRLpost(6,:)), nanstd(FLSpost(6,:));nanstd(VBLASTCTRLpost(6,:)), nanstd(VBLASTpost(6,:))];

figure
h = barwitherr(WPCOErr, WPCOMeans);
set(gca,'XTickLabel',{'FLS','VBLAST'})
set(gca,'FontSize',14)
legend('Control subjects','Trained subjects','Location','North')
ylabel('WPCO (IV)')
ylim([0 1.5])
set(h(1),'FaceColor',[237 125 49]/256);
set(h(2),'FaceColor',[.8 .8 .8]);
[~,ptext] = sigStar(FLSCTRLpost(6,:),FLSpost(6,:),'ranksum');
text(.23,.80,ptext,'Units','normalized','FontName','Times New Roman','FontSize',20,'HorizontalAlignment','center');
[~,ptext] = sigStar(VBLASTCTRLpost(6,:),VBLASTpost(6,:),'ranksum');
text(.77,.80,ptext,'Units','normalized','FontName','Times New Roman','FontSize',20,'HorizontalAlignment','center');

function [Struct1Data, Struct2Data] = plotConnectivity(Struct1, Struct2, Label, Color1, Color2, Ylabel)
    Struct1Data = [Struct1.(char(Label))]';
    Struct2Data = [Struct2.(char(Label))]';
    Data = [Struct1Data;Struct2Data;NaN(1,10)];
    Group = [repmat(1:3:30,[size(Struct1Data,1),1]);repmat(2:3:30,[size(Struct2Data,1),1]);repmat(3:3:30,[1,1])];
    ColorGroup = [ones([size(Struct1Data,1),10]);repmat(2,[size(Struct2Data,1),10]);repmat(3,[1,10])];

    h = boxplot(Data(:),Group(:),'colorgroup',ColorGroup(:),'colors',[Color1; Color2;0 0 0],'medianstyle', 'line');
    set(h,{'linew'},{2})
    set(gca,'XTickLabel',{'','LPFC-CPFC','','','LPFC-RPFC','','','LPFC-SMA','','','LPFC-LMM1','','','CPFC-RPFC','','','CPFC-SMA','','','CPFC-LMM1','','','RPFC-SMA','','','RPFC-LMM1','','','SMA-LMM1','',},'FontSize',16)
    xtickangle(gca,45)
    for i = 1:10
        [~,ptext] = sigStar(Struct1Data(:,i),Struct2Data(:,i),'ranksum');
        text((i*.1)-.06,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    end
    ylabel(Ylabel,'FontSize',18,'Rotation',90);
    ylim([0 1.2])
end

function [CTRLpre, CTRLpost, FLSpre, FLSpost] = plotFLSLearningConnectivity(CTRLdataset, Learningdataset, Subjects, Label)
% CTRLdataset = MGH_CTRL_Training_Coherence;
% Learningdataset = MGH_FLS_Training_Coherence;
% Label = 'WCO_IV';
% Subjects = {'FLS2','FLS4','FLS6'};

Data = [];
Group = [];
ColorGroup = [];

CTRLpre = [CTRLdataset(arrayfun(@(n) contains(CTRLdataset(n).Name, '_FLS'), 1:numel(CTRLdataset))).(char(Label))];
Data = [Data;CTRLpre'];
Group = [Group; [repmat([1:1:10]',1,size(CTRLpre,2))]'];
ColorGroup = [ColorGroup; [repmat('C',10,size(CTRLpre,2))]'];
Learningdataset = arrayfun(@(s) setfield(s,'Name',[s.Name,'_']),Learningdataset);
idx = arrayfun(@(n) contains(Learningdataset(n).Name, Subjects), 1:numel(Learningdataset));
Learningdataset = Learningdataset(idx);

Day = ['_',num2str(1),'_'];
dayidx = arrayfun(@(n) contains(Learningdataset(n).Name, Day), 1:numel(Learningdataset));
FLSpre = [Learningdataset(dayidx).(char(Label))];
LGroup = repmat([(10*(1+1)-9):1:(10*(1+1))]',1,size(FLSpre,2));
ColorGroup = [ColorGroup; [repmat('F',10,size(FLSpre,2))]'];
Data = [Data;FLSpre'];
Group = [Group;LGroup'];
    
for i = 2:11
    Day = ['_',num2str(i),'_'];
    dayidx = arrayfun(@(n) contains(Learningdataset(n).Name, Day), 1:numel(Learningdataset));
    LData = [Learningdataset(dayidx).(char(Label))];
    LGroup = repmat([(10*(i+1)-9):1:(10*(i+1))]',1,size(LData,2));
    ColorGroup = [ColorGroup; [repmat('F',10,size(LData,2))]'];
    Data = [Data;LData'];
    Group = [Group;LGroup'];
end

%Break vector
Data = [Data;NaN(2,10)];
Group = [Group; [201:1:210;211:1:220]];
ColorGroup = [ColorGroup; repmat('F',2,10)];

%Final vector
CTRLpost = [CTRLdataset(arrayfun(@(n) contains(CTRLdataset(n).Name, 'FinalFLS'), 1:numel(CTRLdataset))).(char(Label))];
Data = [Data;[CTRLpost]'];
Group = [Group; [repmat([2001:1:2010]',1,size(CTRLpost,2))]'];
ColorGroup = [ColorGroup; [repmat('C',10,size(CTRLpost,2))]'];
dayidx = arrayfun(@(n) contains(Learningdataset(n).Name, 'FinalFLS'), 1:numel(Learningdataset));
FLSpost = [Learningdataset(dayidx).(char(Label))];
Data = [Data;FLSpost'];
Group = [Group; [repmat([2011:1:2020]',1,size(FLSpost,2))]'];
ColorGroup = [ColorGroup; [repmat('F',10,size(FLSpost,2))]'];

titles = {'LPFC-CPFC','LPFC-RPFC','LPFC-SMA','LPFC-LMM1','CPFC-RPFC','CPFC-SMA','CPFC-LMM1','RPFC-SMA','RPFC-LMM1','SMA-LMM1'};    
    for k=1:10
        figure
        boxplot(Data(:,k),Group(:,k),'colorgroup',ColorGroup(:,k),'colors',[[237 125 49]/256; [192 0 0]/256],'medianstyle', 'line');
        set(findobj('Tag','Box'),'LineWidth',2);
        set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
        set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
        set(gca,'FontSize',12,'XTickLabelRotation',45)
        title(titles(k), 'FontSize', 16);

        [~,ptext] = sigStar(CTRLpre(k,:)',FLSpre(k,:)','ranksum');
        text(.06,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        [~,ptext] = sigStar(CTRLpost(k,:)',FLSpost(k,:)','ranksum');
        text(.93,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
         set(gca,'XTickLabel',{' '});
         ylim([-.2 1.1])
         Label = strrep(Label,'_','_{');
         Label = [Label,'}'];
       ylabel(['FLS ',Label],'FontSize',14,'interpreter','tex')
       DayLabels = [{repmat('Day ', i-1,1)},num2str([2:1:i]')]';
       set(gca,'XTickLabel',{'Control pretest', 'Training pretest', 'Day 2', 'Day 3', 'Day 4','Day 5','Day 6', 'Day 7','Day 8','Day 9','Day 10','Day 11','Break 1','Break 2','Control posttest', 'Training posttest'});
    end
end

function [CTRLpre, CTRLpost, VBLASTpre, VBLASTpost] = plotVBLASTLearningConnectivity(CTRLdataset, Learningdataset, Subjects, Label)
% CTRLdataset = MGH_CTRL_Training_Coherence;
% Learningdataset = MGH_VBLAST_Training_Coherence;
% Label = 'WCO_IV';
% Subjects = {'FLS2','FLS4','FLS6'};
Data = [];
Group = [];
ColorGroup = [];

CTRLpre = [CTRLdataset(arrayfun(@(n) contains(CTRLdataset(n).Name, '_VBLAST'), 1:numel(CTRLdataset))).(char(Label))];
Data = [Data;[CTRLpre]'];
Group = [Group; [repmat([1:1:10]',1,size(CTRLpre,2))]'];
ColorGroup = [ColorGroup; [repmat('C',10,size(CTRLpre,2))]'];
Learningdataset = arrayfun(@(s) setfield(s,'Name',[s.Name,'_']),Learningdataset);
idx = arrayfun(@(n) contains(Learningdataset(n).Name, Subjects), 1:numel(Learningdataset));
Learningdataset = Learningdataset(idx);

Day = ['_',num2str(1),'_'];
dayidx = arrayfun(@(n) contains(Learningdataset(n).Name, Day), 1:numel(Learningdataset));
VBLASTpre = [Learningdataset(dayidx).(char(Label))];
LGroup = repmat([(10*(1+1)-9):1:(10*(1+1))]',1,size(VBLASTpre,2));
ColorGroup = [ColorGroup; [repmat('F',10,size(VBLASTpre,2))]'];
Data = [Data;VBLASTpre'];
Group = [Group;LGroup'];
    
for i = 2:10
    Day = ['_',num2str(i),'_'];
    dayidx = arrayfun(@(n) contains(Learningdataset(n).Name, Day), 1:numel(Learningdataset));
    LData = [Learningdataset(dayidx).(char(Label))];
    LGroup = repmat([(10*(i+1)-9):1:(10*(i+1))]',1,size(LData,2));
    ColorGroup = [ColorGroup; [repmat('F',10,size(LData,2))]'];
    Data = [Data;LData'];
    Group = [Group;LGroup'];
end

%Break vector
Data = [Data;NaN(2,10)];
Group = [Group; [201:1:210;211:1:220]];
ColorGroup = [ColorGroup; repmat('F',2,10)];

%Final vector
CTRLpost = [CTRLdataset(arrayfun(@(n) contains(CTRLdataset(n).Name, '_FinalVBLAST'), 1:numel(CTRLdataset))).(char(Label))];
Data = [Data;[CTRLpost]'];
Group = [Group; [repmat([2001:1:2010]',1,size(CTRLpost,2))]'];
ColorGroup = [ColorGroup; [repmat('C',10,size(CTRLpost,2))]'];
dayidx = arrayfun(@(n) contains(Learningdataset(n).Name, '_FinalVBLAST'), 1:numel(Learningdataset));
VBLASTpost = [Learningdataset(dayidx).(char(Label))];
Data = [Data;VBLASTpost'];
Group = [Group; [repmat([2011:1:2020]',1,size(VBLASTpost,2))]'];
ColorGroup = [ColorGroup; [repmat('F',10,size(VBLASTpost,2))]'];

titles = {'LPFC-CPFC','LPFC-RPFC','LPFC-SMA','LPFC-LMM1','CPFC-RPFC','CPFC-SMA','CPFC-LMM1','RPFC-SMA','RPFC-LMM1','SMA-LMM1'};    
    for k=1:10
        figure
        boxplot(Data(:,k),Group(:,k),'colorgroup',ColorGroup(:,k),'colors',[[237 125 49]/256; [91 155 213]/256],'medianstyle', 'line');
        set(findobj('Tag','Box'),'LineWidth',2);
        set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
        set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
        set(gca,'FontSize',12,'XTickLabelRotation',45)
        title(titles(k), 'FontSize', 16);

        [~,ptext] = sigStar(CTRLpre(k,:)',VBLASTpre(k,:)','ranksum');
        text(.06,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        [~,ptext] = sigStar(CTRLpost(k,:)',VBLASTpost(k,:)','ranksum');
        text(.93,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
         set(gca,'XTickLabel',{' '});
         ylim([-.2 1.1])
         Label = strrep(Label,'_','_{');
         Label = [Label,'}'];
       ylabel(['VBLAST ',Label],'FontSize',14,'interpreter','tex')
       DayLabels = [{repmat('Day ', i-1,1)},num2str([2:1:i]')]';
       set(gca,'XTickLabel',{'Control pretest', 'Training pretest', 'Day 2', 'Day 3', 'Day 4','Day 5','Day 6', 'Day 7','Day 8','Day 9','Day 10','Break 1','Break 2','Control posttest', 'Training posttest'});
    end
end

function  plotFinalConnectivity(CTRL, Stim, Color1, Color2, Ylabel)
figure
CTRL = CTRL';
Stim = Stim';
Data = [CTRL;Stim;NaN(1,10)];
Group = [repmat(1:3:30,[size(CTRL,1),1]);repmat(2:3:30,[size(Stim,1),1]);repmat(3:3:30,[1,1])];
ColorGroup = [ones([size(CTRL,1),10]);repmat(2,[size(Stim,1),10]);repmat(3,[1,10])];

h = boxplot(Data(:),Group(:),'colorgroup',ColorGroup(:),'colors',[Color1; Color2;0 0 0],'medianstyle', 'line');
set(h,{'linew'},{2})
set(gca,'XTickLabel',{'','LPFC-CPFC','','','LPFC-RPFC','','','LPFC-SMA','','','LPFC-LMM1','','','CPFC-RPFC','','','CPFC-SMA','','','CPFC-LMM1','','','RPFC-SMA','','','RPFC-LMM1','','','SMA-LMM1','',},'FontSize',16)
xtickangle(gca,45)
for i = 1:10
    [~,ptext] = sigStar(CTRL(:,i),Stim(:,i),'ranksum');
    text((i*.1)-.06,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
end
ylabel(Ylabel,'FontSize',18,'Rotation',90);
ylim([0 1.2])

end

function [CTRLpre, CTRLpost, VBLASTpre, VBLASTpost] = plotVBLASTFinalConnectivity(CTRLdataset, Learningdataset, Subjects, Label)
% CTRLdataset = MGH_CTRL_Training_Coherence;
% Learningdataset = MGH_VBLAST_Training_Coherence;
% Label = 'WCO_IV';
% Subjects = {'FLS2','FLS4','FLS6'};
Data = [];
Group = [];
ColorGroup = [];

CTRLpre = [CTRLdataset(arrayfun(@(n) contains(CTRLdataset(n).Name, '_VBLAST'), 1:numel(CTRLdataset))).(char(Label))];
Data = [Data;[CTRLpre]'];
Group = [Group; [repmat([1:1:10]',1,size(CTRLpre,2))]'];
ColorGroup = [ColorGroup; [repmat('C',10,size(CTRLpre,2))]'];
Learningdataset = arrayfun(@(s) setfield(s,'Name',[s.Name,'_']),Learningdataset);
idx = arrayfun(@(n) contains(Learningdataset(n).Name, Subjects), 1:numel(Learningdataset));
Learningdataset = Learningdataset(idx);

Day = ['_',num2str(1),'_'];
dayidx = arrayfun(@(n) contains(Learningdataset(n).Name, Day), 1:numel(Learningdataset));
VBLASTpre = [Learningdataset(dayidx).(char(Label))];
LGroup = repmat([(10*(1+1)-9):1:(10*(1+1))]',1,size(VBLASTpre,2));
ColorGroup = [ColorGroup; [repmat('F',10,size(VBLASTpre,2))]'];
Data = [Data;VBLASTpre'];
Group = [Group;LGroup'];
    
for i = 2:10
    Day = ['_',num2str(i),'_'];
    dayidx = arrayfun(@(n) contains(Learningdataset(n).Name, Day), 1:numel(Learningdataset));
    LData = [Learningdataset(dayidx).(char(Label))];
    LGroup = repmat([(10*(i+1)-9):1:(10*(i+1))]',1,size(LData,2));
    ColorGroup = [ColorGroup; [repmat('F',10,size(LData,2))]'];
    Data = [Data;LData'];
    Group = [Group;LGroup'];
end

%Break vector
Data = [Data;NaN(2,10)];
Group = [Group; [201:1:210;211:1:220]];
ColorGroup = [ColorGroup; repmat('F',2,10)];

%Final vector
CTRLpost = [CTRLdataset(arrayfun(@(n) contains(CTRLdataset(n).Name, '_FinalVBLAST'), 1:numel(CTRLdataset))).(char(Label))];
Data = [Data;[CTRLpost]'];
Group = [Group; [repmat([2001:1:2010]',1,size(CTRLpost,2))]'];
ColorGroup = [ColorGroup; [repmat('C',10,size(CTRLpost,2))]'];
dayidx = arrayfun(@(n) contains(Learningdataset(n).Name, '_FinalVBLAST'), 1:numel(Learningdataset));
VBLASTpost = [Learningdataset(dayidx).(char(Label))];
Data = [Data;VBLASTpost'];
Group = [Group; [repmat([2011:1:2020]',1,size(VBLASTpost,2))]'];
ColorGroup = [ColorGroup; [repmat('F',10,size(VBLASTpost,2))]'];

titles = {'LPFC-CPFC','LPFC-RPFC','LPFC-SMA','LPFC-LMM1','CPFC-RPFC','CPFC-SMA','CPFC-LMM1','RPFC-SMA','RPFC-LMM1','SMA-LMM1'};    
    for k=1:10
        figure
        boxplot(Data(:,k),Group(:,k),'colorgroup',ColorGroup(:,k),'colors',[[237 125 49]/256; [91 155 213]/256],'medianstyle', 'line');
        set(findobj('Tag','Box'),'LineWidth',2);
        set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
        set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
        set(gca,'FontSize',12,'XTickLabelRotation',45)
        title(titles(k), 'FontSize', 16);

        [~,ptext] = sigStar(CTRLpre(k,:)',VBLASTpre(k,:)','ranksum');
        text(.06,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        [~,ptext] = sigStar(CTRLpost(k,:)',VBLASTpost(k,:)','ranksum');
        text(.93,.08,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
         set(gca,'XTickLabel',{' '});
         ylim([-.2 1.1])
         Label = strrep(Label,'_','_{');
         Label = [Label,'}'];
       ylabel(['VBLAST ',Label],'FontSize',14,'interpreter','tex')
       DayLabels = [{repmat('Day ', i-1,1)},num2str([2:1:i]')]';
       set(gca,'XTickLabel',{'Control pretest', 'Training pretest', 'Day 2', 'Day 3', 'Day 4','Day 5','Day 6', 'Day 7','Day 8','Day 9','Day 10','Break 1','Break 2','Control posttest', 'Training posttest'});
    end
end

function plotBrainConnectivity(data, Type, flipmap,Plottitle, Colorlabel)
    thresh = 128; % full spectrum
    if (strcmpi(Type,'jet'))
        if flipmap
            colors = flipud(jet(256-thresh));
        else
            colors = jet(256-thresh);
        end
    elseif (strcmpi(Type,'gray'))
        if flipmap
            colors = flipud(gray(256-thresh));
        else
            colors = gray(256-thresh);
        end
    elseif (strcmpi(Type,'summer'))
        if flipmap
            colors = flipud(summer(256-thresh));
        else
            colors = summer(256-thresh);
        end
    elseif (strcmpi(Type,'hot'))
        if flipmap
            colors = flipud(hot(256-thresh));
        else
            colors = hot(256-thresh);
        end
    elseif (strcmpi(Type,'cool'))
        if flipmap
            colors = flipud(cool(256-thresh));
        else
            colors = cool(256-thresh);
        end
    elseif (strcmpi(Type,'parula'))
        if flipmap
            colors = flipud(parula(256-thresh));
        else
            colors = parula(256-thresh);
        end
    else
        disp('invalid color scheme')
        return
    end

    colors = [ones(thresh,3);colors];
    colormap(colors)
    
    
    MCEcolors = round(data*256);
    MCEcolors(~MCEcolors) = 1;
    Brain = imread('BrainTopView.jpg');
    imshow(Brain)
    radius = 60;
    CPFCcentroid = [470 70];
    LPFCcentroid = [240 120];
    RPFCcentroid = [700 120];
    LMM1centroid = [300 640];
    SMAcentroid = [470 520];
    Linethickness = 4;
    
    hold on
    plot([LPFCcentroid(1) CPFCcentroid(1)], [LPFCcentroid(2) CPFCcentroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(1),:))
    plot([LPFCcentroid(1) RPFCcentroid(1)], [LPFCcentroid(2) RPFCcentroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(2),:))
    plot([LPFCcentroid(1) SMAcentroid(1)],  [LPFCcentroid(2) SMAcentroid(2)], 'LineWidth', Linethickness, 'Color', colors(MCEcolors(3),:))
    plot([LPFCcentroid(1) LMM1centroid(1)], [LPFCcentroid(2) LMM1centroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(4),:))
  
    plot([CPFCcentroid(1) RPFCcentroid(1)], [CPFCcentroid(2) RPFCcentroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(5),:))
    plot([CPFCcentroid(1) SMAcentroid(1)],  [CPFCcentroid(2) SMAcentroid(2)], 'LineWidth', Linethickness, 'Color', colors(MCEcolors(6),:))
    plot([CPFCcentroid(1) LMM1centroid(1)], [CPFCcentroid(2) LMM1centroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(7),:))
    
    plot([RPFCcentroid(1) SMAcentroid(1)],  [RPFCcentroid(2) SMAcentroid(2)], 'LineWidth', Linethickness, 'Color', colors(MCEcolors(8),:))
    plot([RPFCcentroid(1) LMM1centroid(1)], [RPFCcentroid(2) LMM1centroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(9),:))
    
    plot([SMAcentroid(1)  LMM1centroid(1)], [SMAcentroid(2)  LMM1centroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(10),:))
    

    rectangle('Position',[LPFCcentroid(1)-radius LPFCcentroid(2)-radius 2*radius 2*radius],'Curvature',[1 1],'FaceColor',[1 1 1]) 
    rectangle('Position',[CPFCcentroid(1)-radius CPFCcentroid(2)-radius 2*radius 2*radius],'Curvature',[1 1],'FaceColor',[1 1 1])
    rectangle('Position',[RPFCcentroid(1)-radius RPFCcentroid(2)-radius 2*radius 2*radius],'Curvature',[1 1],'FaceColor',[1 1 1])
    rectangle('Position',[LMM1centroid(1)-radius LMM1centroid(2)-radius 2*radius 2*radius],'Curvature',[1 1],'FaceColor',[1 1 1])
    rectangle('Position',[SMAcentroid(1)-radius SMAcentroid(2)-radius 2*radius 2*radius],'Curvature',[1 1],'FaceColor',[1 1 1])
    text(LPFCcentroid(1),LPFCcentroid(2),'LPFC','HorizontalAlignment','center','FontSize',7,'FontWeight','bold')
    text(CPFCcentroid(1),CPFCcentroid(2),'CPFC','HorizontalAlignment','center','FontSize',7,'FontWeight','bold')
    text(RPFCcentroid(1),RPFCcentroid(2),'RPFC','HorizontalAlignment','center','FontSize',7,'FontWeight','bold')
    text(LMM1centroid(1),LMM1centroid(2),'LMM1','HorizontalAlignment','center','FontSize',7,'FontWeight','bold')
    text(SMAcentroid(1), SMAcentroid(2),'SMA','HorizontalAlignment','center','FontSize',7,'FontWeight','bold')
    

    title(Plottitle, 'FontSize', 14);
    h = colorbar;
    ylabel(h, Colorlabel, 'Rotation', 90, 'FontSize', 12)
    hold off
end
