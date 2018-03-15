%function [N, E]= Novice_Expert_Plot(novice, expert)
close all
novice = 'MGH_FLS_Novice_Temporal.mat';
expert = 'MGH_FLS_Expert_Temporal.mat';
%Load group HRF data from Homer analysis
load(novice)
N_time = group.procResult.tHRF;
N_index = knnsearch(N_time,0);
Novice_HbO = 1E6*reshape(group.procResult.dcAvg(:,1,:),length(N_time),33);
%% 

load(expert)
E_time = group.procResult.tHRF;
E_index = knnsearch(E_time,0);
Expert_HbO = 1E6*reshape(group.procResult.dcAvg(:,1,:),length(E_time),33);

%Remove SS channels
a = [3,6,9,14,19,24,29,33];
Expert_HbO(:,a)=[];
Novice_HbO(:,a)=[];

% Mean of brain regions
Novice_HbO_mean(:,1) = nanmean(Novice_HbO(:,1:2),2);
Novice_HbO_mean(:,2) = nanmean(Novice_HbO(:,3:4),2);
Novice_HbO_mean(:,3) = nanmean(Novice_HbO(:,5:6),2);
Novice_HbO_mean(:,4) = nanmean(Novice_HbO(:,7:12),2);
Novice_HbO_mean(:,5) = nanmean(Novice_HbO(:,13:14),2);
Novice_HbO_mean(:,6) = nanmean(Novice_HbO(:,15:16),2);
Novice_HbO_mean(:,7) = nanmean(Novice_HbO(:,17:22),2);
Novice_HbO_mean(:,8) = nanmean(Novice_HbO(:,23:25),2);
N = mean(Novice_HbO_mean(N_index:end,:),1);
Expert_HbO_mean(:,1) = nanmean(Expert_HbO(:,1:2),2);
Expert_HbO_mean(:,2) = nanmean(Expert_HbO(:,3:4),2);
Expert_HbO_mean(:,3) = nanmean(Expert_HbO(:,5:6),2);
Expert_HbO_mean(:,4) = nanmean(Expert_HbO(:,7:12),2);
Expert_HbO_mean(:,5) = nanmean(Expert_HbO(:,13:14),2);
Expert_HbO_mean(:,6) = nanmean(Expert_HbO(:,15:16),2);
Expert_HbO_mean(:,7) = nanmean(Expert_HbO(:,17:22),2);
Expert_HbO_mean(:,8) = nanmean(Expert_HbO(:,23:25),2);
E = mean(Expert_HbO_mean(E_index:end,:),1);

Novice_HbO_mean_e = repmat(std(Novice_HbO_mean(N_index:end,:)),[size(Novice_HbO,1) 1]);
a = mod(1:length(Novice_HbO_mean_e),30)>0;
Novice_HbO_mean_e([a],:) = NaN;
Expert_HbO_mean_e = repmat(std(Expert_HbO_mean(E_index:end,:)),[size(Expert_HbO,1) 1]);
a = mod(1:length(Expert_HbO_mean_e),30)>0;
Expert_HbO_mean_e([a],:) = NaN;

figure
titles_2 = {'Left Lateral PFC';
'Central PFC';
'Right Lateral PFC';
'Left Lateral M1';
'Left Medial M1';
'Right Medial M1';
'Right Lateral M1';
'SMA'};
for i=[1,2,3,5,8]
    if(i==5)
        h1 = subplot(2,3,4);
    elseif(i==8)
        h1 = subplot(2,3,5);
    else
        h1 = subplot(2,3,i);
    end
    hold on
    d1 = shadedErrorBar(N_time',Novice_HbO_mean(:,i)',repmat(std(Novice_HbO_mean(:,i)),1,size(N_time,1)),{'Color',[0 176 80]/256,'Marker','.','MarkerEdgeColor',[0 176 80]/256,'markerfacecolor',[0 176 80]/256});
    d2 = shadedErrorBar(E_time',Expert_HbO_mean(:,i)',repmat(std(Expert_HbO_mean(:,i)),1,size(E_time,1)),{'Color',[192 0 0]/256,'Marker','.','MarkerEdgeColor',[192 0 0]/256,'markerfacecolor',[192 0 0]/256});

% 
%     d1 = errorbar(N_time,Novice_HbO_mean(:,i),Novice_HbO_mean_e(:,i),'-','MarkerSize',5,'MarkerEdgeColor',[0 176 80]/256, 'Color', [0 176 80]/256,'LineStyle', ':', 'CapSize', 1);
%     d1.Bar.LineStyle = 'dotted';
%     d2 = errorbar(N_time(N_index:end),Novice_HbO_mean(N_index:end,i),Novice_HbO_mean_e(N_index:end,i),'-s','MarkerSize',5,'MarkerEdgeColor',[0 176 80]/256, 'Color', [0 176 80]/256);
% 
%     d3 = errorbar(E_time,Expert_HbO_mean(:,i),Expert_HbO_mean_e(:,i),'-','MarkerSize',5,'MarkerEdgeColor',[192 0 0]/256, 'Color', [192 0 0]/256,'LineStyle', ':', 'CapSize', 1);
%     d3.Bar.LineStyle = 'dotted';
%     d4 = errorbar(E_time(E_index:end),Expert_HbO_mean(E_index:end,i),Expert_HbO_mean_e(E_index:end,i),'-s','MarkerSize',5,'MarkerEdgeColor',[192 0 0]/256, 'Color', [192 0 0]/256);
%     
    line([0 0], [-2 1], 'LineWidth', 2, 'Color', 'k', 'LineStyle', '--')
    hold off
    axis([-25 105 -2 1]);
    set(gca,'XTickLabel',{' '});
    Patch = findobj(gca,'Type', 'Patch');
    L = findobj(gca,'Type','Line');
    if i>7
        ylim([-2 1]);
    else
        ylim([-1 1]);
    end
    set(gca,'FontName','Times New Roman','FontSize',14)
    h = findobj(gca,'Type','line');
    if i==1
        xlabel('Time (s)')
        ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',16,'interpreter','tex')
        set(gca,'XTickLabel',[0 50 100]);
        legend([Patch(1),L(2),Patch(2),L(5),L(1)],{'Expert surgeon SD','Expert surgeon mean','Novice surgeon SD','Novice surgeon mean','FLS task start'})

    end
    title(titles_2(i), 'FontSize', 13,'FontName','Times New Roman')
    end