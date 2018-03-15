% Perform HRF analysis on MGH FLS dataset with FLS metrics
%
% Author: Arun Nemani

close all
%clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEBUG ZONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
method = 3; %1 - report maximum peak value of HRFs
            %2 - report integral of HRFs
            %3 - report average value across entire HRF

%novice = 'MGH_FLS_Novice_Trial_noSS.mat';
%expert = 'MGH_FLS_Expert_Trial_noSS.mat';
novice = 'MGH_FLS_Novice_Trial.mat';
expert = 'MGH_FLS_Expert_Trial.mat';

classifer = 'LDA';
Display = [{'1'} {'2'} {'1'} {'2'} {'1'} {'2'}];
crossVDisplay = [{'1'} {'1'} {'0'} {'0'} {'0'} {'1'}];
global PDFxlabel
global Type_II_E
global Type_II_N
global CVplottitle

PDFDist = [];
%PDFxlabel = 'Normalized task performance scores';
PDFxlabel = 'LDA projected scores (fNIRS)';
CVplottitle = 'Cross-validated LDA model (FLS score)';
CVboxescolor = 'gray';

BrainRegions = [1,2,3,5,8];
withScore = 0;
drawBoxplots = 0;
habituationPlots = 0;
changeDirection = 0;
swapClasses = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initializations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
titles_2 = {'Left Lateral PFC';
'Central PFC';
'Right Lateral PFC';
'Left Lateral M1';
'Left Medial M1';
'Right Medial M1';
'Right Lateral M1';
'SMA'};
N = load(novice);
E = load(expert);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove large outliers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:8
   novicedata(:,i) = deleteoutliers(novicedata(:,i),.1,1);
   expertdata(:,i) = deleteoutliers(expertdata(:,i),.1,1);
end
%novicedata(27,:) = [];
%Novice_score(27) = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptive statistics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch drawBoxplots
    case 1

figure
for i=1:8
    if(i>3 && i<8)
        h1 = subplot(2,4,i+1);
    elseif(i==8)
        h1 = subplot(2,4,4);
    else
        h1 = subplot(2,4,i);
    end
    switch (i==9)
        case 0
            %[p] = ranksum(novicedata(:,i),expertdata(:,i));
            [~,p] = ttest2(novicedata(:,i),expertdata(:,i));
            p = floor(p*1000)/1000;
            if p<0.05
                pp = '*';
            else
                pp = 'n.s.';
            end
            group = [repmat({'Novice'}, size(novicedata,1), 1); repmat({'Expert'}, size(expertdata,1), 1)];
            boxplot([novicedata(:,i);expertdata(:,i)],group)
            a = get(get(gca,'children'),'children');   % Get the handles of all the objects
            t = get(a,'tag');   % List the names of all the objects 
            box1 = a(3);   % Expert median line
            set(box1,'LineWidth',2,'Color', 'k');
            box2 = a(4);   % Novice median line
            set(box2,'LineWidth',2, 'Color', 'k');
            box3 = a(5);   % Expert box
            set(box3,'LineWidth',2, 'Color', [192 0 0]/255);
            box4 = a(6);   % Expert box
            set(box4,'LineWidth',2, 'Color', [0 176 80]/255);
            
            ppos = get(h1,'pos');
            ppos(3) = ppos(3) + 0.01;
            set(h1,'pos',ppos);
            set(gca,'XTickLabel',{' '});
            set(gca,'FontSize',14,'FontName','Times New Roman')
            text(.5,.9,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
            title(titles_2(i),'FontName','Times New Roman','FontSize', 16);
            if (i==1)
                ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',16,'interpreter','tex')
                xticklabels({'Novice','Expert'});
            end
            %if i>6
                %ylim([-3 2]);
            %else
                %ylim([-3 2]);
            %end
        otherwise
            h1 = figure;
            ylim auto
            [p,~] = ranksum(Novice_score,Expert_score);
            %[~,p] = ttest2(Novice_score,Expert_score);
            p = floor(p*1000)/1000;
            if p<0.05
                pp = '*';
            else
                pp = 'n.s.';
            end
            group = [repmat({'Novice'}, size(Novice_score,1), 1); repmat({'Expert'}, size(Expert_score,1), 1)];
            boxplot([Novice_score;Expert_score],group)
            a = get(get(gca,'children'),'children');   % Get the handles of all the objects
            t = get(a,'tag');   % List the names of all the objects 
            box1 = a(3);   % Expert median line
            set(box1,'LineWidth',2, 'Color', 'k');
            box2 = a(4);   % Novice median line
            set(box2,'LineWidth',2, 'Color', 'k');
            box3 = a(5);   % Expert box
            set(box3,'LineWidth',2, 'Color', [192 0 0]/255);
            box4 = a(6);   % Expert box
            set(box4,'LineWidth',2, 'Color', [0 176 80]/255);
            ppos = get(h1,'pos');
            ppos(3) = ppos(3) + 0.01;
            set(h1,'pos',ppos);
            set(gca,'FontSize',12)
            text(.5,.9,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
            %title('FLS task performance','FontName','Times New Roman','FontSize', 20);
            ylabel('FLS performance score','FontName','Times New Roman','FontSize',20)
     end

end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Habituation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch habituationPlots 
    case 1
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
            
            boxplot([N_habit.one(:,k);N_habit.two(:,k);N_habit.three(:,k);N_habit.four(:,k);N_habit.five(:,k)],N_group,'PlotStyle','compact','Colors','c')
            [p,~] = ranksum(N_habit.one(:,k),N_habit.two(:,k));
            p = floor(p*1000)/1000;
            if p<0.05
                pp = strcat('p=',{''},num2str(p));
            else
                pp = 'n.s.';
            end
            t = text(0.20,.93,pp,'Units','normalized','FontName','Times New Roman','FontSize',18,'HorizontalAlignment','center');
            [p,~] = ranksum(N_habit.two(:,k),N_habit.three(:,k));
            p = floor(p*100)/100;
            if p<0.05
                pp = strcat('p=',{''},num2str(p));
            else
                pp = 'n.s.';
            end
            t = text(0.40,.93,pp,'Units','normalized','FontName','Times New Roman','FontSize',18,'HorizontalAlignment','center');
            [p,~] = ranksum(N_habit.three(:,k),N_habit.four(:,k));
            p = floor(p*1000)/1000;
            if p<0.05
                pp = strcat('p=',{''},num2str(p));
            else
                pp = 'n.s.';
            end
            t = text(0.60,.93,pp,'Units','normalized','FontName','Times New Roman','FontSize',18,'HorizontalAlignment','center');
            [p,~] = ranksum(N_habit.four(:,k),N_habit.five(:,k));
            p = floor(p*1000)/1000;
            if p<0.05
                pp = strcat('p=',{''},num2str(p));
            else
                pp = 'n.s.';
            end
            t = text(0.80,.93,pp,'Units','normalized','FontName','Times New Roman','FontSize',18,'HorizontalAlignment','center');
            
            title(titles_2(k), 'FontSize', 16,'FontWeight','bold');
            if(k==1)
                ylabel('\Delta HbO conc (\muM*mm)','FontSize',22)
                xlabel('Trial number');
            end
            set(gca,'FontSize',18)
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
            set(gca,'FontSize',18)
            boxplot([E_habit.one(:,k);E_habit.two(:,k);E_habit.three(:,k);E_habit.four(:,k);E_habit.five(:,k)],E_group,'PlotStyle','compact','Colors','m')
            [p,~] = ranksum(E_habit.one(:,k),E_habit.two(:,k));
            p = floor(p*1000)/1000;
            if p<0.05
                pp = strcat('p=',{''},num2str(p));
            else
                pp = 'n.s.';
            end
            t = text(0.20,.93,pp,'Units','normalized','FontName','Times New Roman','FontSize',18,'HorizontalAlignment','center');
            [p,~] = ranksum(E_habit.two(:,k),E_habit.three(:,k));
            p = floor(p*100)/100;
            if p<0.05
                pp = strcat('p=',{''},num2str(p));
            else
                pp = 'n.s.';
            end
            t = text(0.40,.93,pp,'Units','normalized','FontName','Times New Roman','FontSize',18,'HorizontalAlignment','center');
            [p,~] = ranksum(E_habit.three(:,k),E_habit.four(:,k));
            p = floor(p*1000)/1000;
            if p<0.05
                pp = strcat('p=',{''},num2str(p));
            else
                pp = 'n.s.';
            end
            t = text(0.60,.93,pp,'Units','normalized','FontName','Times New Roman','FontSize',18,'HorizontalAlignment','center');
            [p,~] = ranksum(E_habit.four(:,k),E_habit.five(:,k));
            p = floor(p*1000)/1000;
            if p<0.05
                pp = strcat('p=',{''},num2str(p));
            else
                pp = 'n.s.';
            end
            t = text(0.80,.93,pp,'Units','normalized','FontName','Times New Roman','FontSize',18,'HorizontalAlignment','center');

            title(titles_2(k), 'FontSize', 16,'FontWeight','bold');
            if(k==1)
                ylabel('\Delta HbO conc (\muM*mm)','FontSize',22)
                xlabel('Trial number');
            end
            set(gca,'FontSize',18)
        end
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Classification
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    switch (classifer)
        case 'SVM'
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
                [~, Mdl_FLS, Mdl_NIRS, truelabels, orig_truelabels] = classifyDataSVM(nirs_data(:,i),scores_data,truth_label,[192 0 0]/256,[0 176 80]/256);

                set(gca,'FontSize',18);
                xlim([0 300]);
                %ylim([-3 2]);
                legend('off')

                title(titles_2(i), 'FontSize', 22,'FontWeight','bold');
                if(i==1)
                    ylabel('\Delta HbO conc (\muM*mm)','FontSize',18)
                    xlabel('Pattern Cutting score','FontSize',18)
                    legend({'Expert surgeon','Novice surgeon','Support Vectors','Decision Boundary'},'FontSize',18);
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
                 %figure(f4);
                %subplot(3,3,i)
                %plotROCThreshold(i, nirs_data(:,i),scores_data,truth_label,'FLS')
            end
        case 'LDA'
            LDAData    = ReadDatabyRegion(novicedata,expertdata,Novice_score, Expert_score, BrainRegions,withScore);
            LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
            PlotResults(LDAModel,LDAData,Display,changeDirection);
            LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
            PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
            if (changeDirection==1)
                CVMCE = 100*sum((1-LDACVModel.pValueTypeII)<0.05)/size(LDACVModel.pValueTypeII,2);
            else
                CVMCE = 100*sum(LDACVModel.pValueTypeII<0.05)/size(LDACVModel.pValueTypeII,2);
            end
            ylim([0 1]);
            
            createCVLDAcolormap(LDAData,LDACVModel,0.05,[192 0 0]/256,[0 176 80]/256,CVboxescolor, swapClasses)
        case 'SVM+LDA'
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
            
            [~, Mdl_FLS, Mdl_NIRS, truelabels, orig_truelabels] = classifyDataSVM(nirs_data,scores_data,truth_label,[192 0 0]/256,[0 176 80]/256);
            set(gca,'FontSize',18);
            xlim([0 300]);
            %ylim([-3 2]);
            legend('off')
            ylabel('Weighted \Delta HbO conc (\muM*mm)','FontSize',18)
            xlabel('Pattern Cutting score','FontSize',18)
            legend({'Expert surgeon','Novice surgeon','Support Vectors','Decision Boundary'},'FontSize',18);

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
    