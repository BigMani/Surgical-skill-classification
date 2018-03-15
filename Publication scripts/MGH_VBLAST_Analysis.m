% Perform HRF analysis on MGH VBLAST dataset with VBLAST metrics
%
% Author: Arun Nemani


%% DEBUG ZONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
%clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEBUG ZONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
method = 3; %1 - report maximum peak value of HRFs
            %2 - report integral of HRFs
            %3 - report average value across entire HRF
            
novice = 'MGH_VBLAST_Novice_Trial_v2.mat';
expert = 'MGH_VBLAST_Expert_Trial_v2.mat';
pathlength = 'MGH_VBLAST_ToolPathlength_v2.mat';
Display = [{'1'} {'2'} {'1'} {'2'} {'1'} {'0'}];
crossVDisplay = [{'0'} {'0'} {'0'} {'0'} {'0'} {'1'}];
global PDFxlabel;
global Type_II_E
global Type_II_N
T = {'VBLaST score','Right tool PL','VBLaST score + PL','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'};
PDFxlabel = 'LDA projected scores (fNIRS)';
CVboxescolor = 'gray';

BrainRegions = [1,2,3,5,8];
withScore = 0;
withPathLength = 0;
drawBoxplots = 0;
changeDirection = 0;
statMethod = 'ranksum';
swapClasses = 0;

%% Initializations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = load(novice);
E = load(expert);
load(pathlength);
N_fields = fields(N);
E_fields = fields(E);

switch (isstruct(N.(char(N_fields(1)))))
    case 1
        Novice_HRFs = N.(char(N_fields(1)));
        Novice_score = N.(char(N_fields(2)));
        
    otherwise
        Novice_score = N.(char(N_fields(1)));
        Novice_HRFs = N.(char(N_fields(2)));
end

switch (isstruct(E.(char(E_fields(1)))))
    case 1
        Expert_HRFs = E.(char(E_fields(1)));
        Expert_score = E.(char(E_fields(2)));
        
    otherwise
        Expert_score = E.(char(E_fields(1)));
        Expert_HRFs = E.(char(E_fields(2)));
end

N_subjects = fields(Novice_HRFs);
E_subjects = fields(Expert_HRFs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determine HRF analysis for novices and experts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

novicedata = zeros(length(N_subjects),8);
for i=1:length(N_subjects) 
    name = char(N_subjects(i));
    Temp = zeros(31,1);
    for j = 1:32
        if method == 1
            [aa,~] = HRF_LocalMaxima(Novice_HRFs.(name).data(:,j));
            Temp(j,1) = max(aa);
        elseif method ==2
            Temp(j,1) = HRF_Integral(Novice_HRFs.(name).time,Novice_HRFs.(name).data(:,j));
        else
            Temp(j,1) = HRF_Avg(Novice_HRFs.(name).data(:,j));
        end
    end
    g(1,1) = nanmean(Temp(1:2,:));
    g(1,2) = nanmean(Temp(4:5,:));
    g(1,3) = nanmean(Temp(7:8,:));
    g(1,4) = nanmean(Temp(10:13,:));
    g(1,5) = nanmean(Temp(15:18,:));
    g(1,6) = nanmean(Temp(20:23,:));
    g(1,7) = nanmean(Temp(25:28,:));
    g(1,8) = nanmean(Temp(30:32,:));
    novicedata(i,:) = g;
end

expertdata = zeros(length(E_subjects),8);
for i=1:length(E_subjects) 
    name = char(E_subjects(i));
    Temp2 = zeros(31,1);
    for j = 1:32
        if method == 1
            [aa,~] = HRF_LocalMaxima(Expert_HRFs.(name).data(:,j));
            Temp2(j,1) = max(aa);
        elseif method ==2
            Temp2(j,1) = HRF_Integral(Expert_HRFs.(name).time,Expert_HRFs.(name).data(:,j));
        else
            Temp2(j,1) = HRF_Avg(Expert_HRFs.(name).data(:,j));
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
    expertdata(i,:) = g2;
end

%% Remove large outliers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:8
   novicedata(:,i) = deleteoutliers(novicedata(:,i),.05,1);
   expertdata(:,i) = deleteoutliers(expertdata(:,i),.05,1);
end
 novicedata(14,i) = NaN;
 novicedata(25,i) = NaN;

%% Descriptive statistics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch drawBoxplots
    case 1
    titles_2 = {'Left Lateral PFC';
    'Medial PFC';
    'Right Lateral PFC';
    'Left Lateral M1';
    'Left Medial M1';
    'Right Medial M1';
    'Right Lateral M1';
    'SMA'};
    for i = 1:8
        h1 = subplot(3,3,i);
        [~,pp]  = sigStar(novicedata(:,i),expertdata(:,i),statMethod);
        group = [repmat({'Novice'}, size(novicedata,1), 1); repmat({'Expert'}, size(expertdata,1), 1)];
        boxplot([novicedata(:,i);expertdata(:,i)],group)
        a = get(get(gca,'children'),'children');   % Get the handles of all the objects
        t = get(a,'tag');   % List the names of all the objects 
        box1 = a(3);   % Expert median line
        set(box1,'LineWidth',2,'Color', 'k');
        box2 = a(4);   % Novice median line
        set(box2,'LineWidth',2, 'Color', 'k');
        box3 = a(5);   % Expert box
        set(box3,'LineWidth',2, 'Color', [1 .25 0]);
        box4 = a(6);   % Expert box
        set(box4,'LineWidth',2, 'Color', 'c');
            
        ppos = get(h1,'pos');
        ppos(3) = ppos(3) + 0.01;
        set(h1,'pos',ppos);
        set(gca,'XTickLabel',{' '});
        set(gca,'FontSize',14,'FontName','Times New Roman')
        text(.5,.9,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        title(titles_2(i),'FontName','Times New Roman','FontSize', 16);
        if (i==1)
            ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',16,'interpreter','tex')
            set(gca,'XTickLabel',{'Novice','Expert'});
        end
    end

    % Plot VBLAST score
    figure;
    ylim auto
    [~,pp]  = sigStar(Novice_score,Expert_score,statMethod);
    group = [repmat({'Novice'}, size(Novice_score,1), 1); repmat({'Expert'}, size(Expert_score,1), 1)];
    boxplot([Novice_score;Expert_score],group)
    a = get(get(gca,'children'),'children');   % Get the handles of all the objects
    t = get(a,'tag');   % List the names of all the objects 
    box1 = a(3);   % Expert median line
    set(box1,'LineWidth',2, 'Color', 'k');
    box2 = a(4);   % Novice median line
    set(box2,'LineWidth',2, 'Color', 'k');
    box3 = a(5);   % Expert box
    set(box3,'LineWidth',2, 'Color', [1 .25 0]);
    box4 = a(6);   % Expert box
    set(box4,'LineWidth',2, 'Color', 'c');

    ppos = get(h1,'pos');
    ppos(3) = ppos(3) + 0.01;
    set(h1,'pos',ppos);
    set(gca,'FontSize',18)
    text(.5,.9,pp,'Units','normalized','FontName','Times New Roman','FontSize',26,'HorizontalAlignment','center');
    %title('Task Performance','FontName','Times New Roman','FontSize', 20);
    ylabel('VBLAST PC score','FontName','Times New Roman','FontSize',18)
    
    % Plot right tool pathlength
    figure;
    [~,pp] = sigStar(ToolPathlength.Novice_Right_Trial,ToolPathlength.Expert_Right_Trial,statMethod);
    group = [repmat({'Novice'}, size(novicedata,1), 1); repmat({'Expert'}, size(expertdata,1), 1)];
    boxplot([ToolPathlength.Novice_Right_Trial;ToolPathlength.Expert_Right_Trial],group)
    a = get(get(gca,'children'),'children');   % Get the handles of all the objects
    t = get(a,'tag');   % List the names of all the objects 
    box1 = a(3);   % Expert median line
    set(box1,'LineWidth',2, 'Color', 'k');
    box2 = a(4);   % Novice median line
    set(box2,'LineWidth',2, 'Color', 'k');
    box3 = a(5);   % Expert box
    set(box3,'LineWidth',2, 'Color', [1 .25 0]);
    box4 = a(6);   % Expert box
    set(box4,'LineWidth',2, 'Color', 'c');
    
    ppos = get(h1,'pos');
    ppos(3) = ppos(3) + 0.01;
    set(h1,'pos',ppos);
    set(gca,'FontSize',14)
    text(.5,.9,pp,'Units','normalized','FontName','Times New Roman','FontSize',26,'HorizontalAlignment','center');
    ylabel('Right tool total pathlength (m)','FontName','Times New Roman','FontSize',18)

    % Plot left tool pathlength
    figure;
    [~,pp] = sigStar(ToolPathlength.Novice_Left_Trial,ToolPathlength.Expert_Left_Trial,statMethod);
    group = [repmat({'Novice'}, size(novicedata,1), 1); repmat({'Expert'}, size(expertdata,1), 1)];
    boxplot([ToolPathlength.Novice_Left_Trial;ToolPathlength.Expert_Left_Trial],group)
    a = get(get(gca,'children'),'children');   % Get the handles of all the objects
    t = get(a,'tag');   % List the names of all the objects 
    box1 = a(3);   % Expert median line
    set(box1,'LineWidth',2, 'Color', 'k');
    box2 = a(4);   % Novice median line
    set(box2,'LineWidth',2, 'Color', 'k');
    box3 = a(5);   % Expert box
    set(box3,'LineWidth',2, 'Color', [1 .25 0]);
    box4 = a(6);   % Expert box
    set(box4,'LineWidth',2, 'Color', 'c');
    
    ppos = get(h1,'pos');
    ppos(3) = ppos(3) + 0.01;
    set(h1,'pos',ppos);
    set(gca,'FontSize',14)
    text(.5,.9,pp,'Units','normalized','FontName','Times New Roman','FontSize',26,'HorizontalAlignment','center');
    ylabel('Left tool total pathlength (m)','FontName','Times New Roman','FontSize',18)
end

%% Habituation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch 0 
    case (size(N_subjects,1)>10) && (size(E_subjects,1)>10)
        N_habit_idx = str2double(cellfun(@(x) x(end), N_subjects, 'un', 0));
        N_habit.one = novicedata(N_habit_idx == 1,:);
        N_habit.two = novicedata(N_habit_idx == 2,:);
        N_habit.three = novicedata(N_habit_idx == 3,:);
        N_habit.four = novicedata(N_habit_idx == 4,:);
        N_habit.five = novicedata(N_habit_idx == 5,:);
        N_group = [repmat({'1'}, size(N_habit.one,1), 1); repmat({'2'}, size(N_habit.two,1), 1); repmat({'3'}, size(N_habit.three,1), 1);repmat({'4'}, size(N_habit.four,1), 1);repmat({'5'}, size(N_habit.five,1), 1);];
        figure;

        for k = 1:8
            subplot(3,3,k);
            boxplot([N_habit.one(:,k);N_habit.two(:,k);N_habit.three(:,k);N_habit.four(:,k);N_habit.five(:,k)],N_group,'PlotStyle','compact','Colors','r')
            [p,~] = ranksum(N_habit.one(:,k),N_habit.two(:,k));
            p = floor(p*100)/100;
            pp = strcat('p=',{''},num2str(p));
            t = text(0.12,.93,pp,'Units','normalized','FontSize',10);
            [p,~] = ranksum(N_habit.two(:,k),N_habit.three(:,k));
            p = floor(p*100)/100;
            pp = strcat('p=',{''},num2str(p));
            t = text(0.32,.93,pp,'Units','normalized','FontSize',10);
            [p,~] = ranksum(N_habit.three(:,k),N_habit.four(:,k));
            p = floor(p*100)/100;
            pp = strcat('p=',{''},num2str(p));
            t = text(0.52,.93,pp,'Units','normalized','FontSize',10);
            [p,~] = ranksum(N_habit.four(:,k),N_habit.five(:,k));
            p = floor(p*100)/100;
            pp = strcat('p=',{''},num2str(p));
            t = text(0.72,.93,pp,'Units','normalized','FontSize',10);

            title(titles_2(k), 'FontSize', 16,'FontWeight','bold');
            if(k==1)
                ylabel('\Delta HbO conc (\muM*mm)','FontSize',14)
            end
        end
        E_habit_idx = str2double(cellfun(@(x) x(end), E_subjects, 'un', 0));
        
        E_habit.one = expertdata(E_habit_idx == 1,:);
        E_habit.two = expertdata(E_habit_idx == 2,:);
        E_habit.three = expertdata(E_habit_idx == 3,:);
        E_habit.four = expertdata(E_habit_idx == 4,:);
        E_habit.five = expertdata(E_habit_idx == 5,:);
        E_group = [repmat({'1'}, size(E_habit.one,1), 1); repmat({'2'}, size(E_habit.two,1), 1); repmat({'3'}, size(E_habit.three,1), 1);repmat({'4'}, size(E_habit.four,1), 1);repmat({'5'}, size(E_habit.five,1), 1);];

        figure;
        for k = 1:8
            subplot(3,3,k);
            boxplot([E_habit.one(:,k);E_habit.two(:,k);E_habit.three(:,k);E_habit.four(:,k);E_habit.five(:,k)],E_group,'PlotStyle','compact','Colors','b')
            [p,~] = ranksum(E_habit.one(:,k),E_habit.two(:,k));
            p = floor(p*100)/100;
            pp = strcat('p=',{''},num2str(p));
            t = text(0.12,.93,pp,'Units','normalized','FontSize',10);
            [p,~] = ranksum(E_habit.two(:,k),E_habit.three(:,k));
            p = floor(p*100)/100;
            pp = strcat('p=',{''},num2str(p));
            t = text(0.32,.93,pp,'Units','normalized','FontSize',10);
            [p,~] = ranksum(E_habit.three(:,k),E_habit.four(:,k));
            p = floor(p*100)/100;
            pp = strcat('p=',{''},num2str(p));
            t = text(0.52,.93,pp,'Units','normalized','FontSize',10);
            [p,~] = ranksum(E_habit.four(:,k),E_habit.five(:,k));
            p = floor(p*100)/100;
            pp = strcat('p=',{''},num2str(p));
            t = text(0.72,.93,pp,'Units','normalized','FontSize',10);

            title(titles_2(k), 'FontSize', 16,'FontWeight','bold');
            if(k==1)
                ylabel('\Delta HbO conc (\muM*mm)','FontSize',14)
            end

        end
end

%% Classification
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% LDAData    = ReadDatabyRegionVBLAST(novicedata,expertdata,Novice_score, Expert_score, ToolPathlength.Novice_Right_Trial, ToolPathlength.Expert_Right_Trial, BrainRegions, withScore, withPathLength);
% LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
% PlotResults(LDAModel,LDAData,Display,changeDirection);
% LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
% PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
% if (changeDirection==1)
%     CVMCE = 100*sum((1-LDACVModel.pValueTypeII)<0.05)/size(LDACVModel.pValueTypeII,2);
% else
%     CVMCE = 100*sum(LDACVModel.pValueTypeII<0.05)/size(LDACVModel.pValueTypeII,2);
% end
% ylim([0 1]);
% 
% createCVLDAcolormap(LDAData,LDACVModel,0.05,'m','c',CVboxescolor, swapClasses)
