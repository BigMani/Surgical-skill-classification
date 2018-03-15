%function [N, E]= Novice_Expert_Plot(novice, expert)
novice = 'MGH_FLS_Novice_Temporal.mat';
expert = 'MGH_FLS_Expert_Temporal.mat';
%Load group HRF data from Homer analysis
load(novice)
N_time = group.procResult.tHRF;
N_index = knnsearch(N_time,0);
Novice_HbO = 1E6*reshape(group.procResult.dcAvg(:,1,:),length(N_time),33);

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
'Medial PFC';
'Right Lateral PFC';
'Left Lateral M1';
'Left Medial M1';
'Right Medial M1';
'Right Lateral M1';
'SMA'};
for i = 1:8
    subplot(3,3,i);
    errorbar(N_time,Novice_HbO_mean(:,i),Novice_HbO_mean_e(:,i),'c');
    hold on
    errorbar(E_time,Expert_HbO_mean(:,i),Expert_HbO_mean_e(:,i),'m');
    hold off
    title(titles_2(i), 'FontSize', 16,'FontName','Times New Roman')
    xlim([-25 105]);
    set(gca,'XTickLabel',{' '});
    if i>7
        ylim([-2 1]);
    else
        ylim([-1 1]);
    end
    set(gca,'FontName','Times New Roman','FontSize',14)
    %# vertical line
    
    if i==1
        xlabel('Time (s)')
        ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',16,'interpreter','tex')
        set(gca,'XTickLabel',[0 50 100]);
    end
end