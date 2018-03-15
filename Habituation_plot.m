load('N_Habit.mat')
load('E_Habit.mat')

trial = [1;2;3;4;5];

titles_2 = {'Left Lateral PFC';
'Medial PFC';
'Right Lateral PFC';
'Left Lateral M1';
'Left Medial M1';
'Right Medial M1';
'Right Lateral M1';
'SMA'};
figure
for k = 1:8
    subplot(3,3,k);
    hold on
    scatter(trial,1E6*N_Habit_mean(:,k),'filled')
    h1=errorbar(trial,1E6*N_Habit_mean(:,k),1E6*N_Habit_err(:,k));
    h2=errorbar(trial,1E6*E_Habit_mean(:,k),1E6*E_Habit_err(:,k),'r');
    scatter(trial,1E6*E_Habit_mean(:,k),'r','filled')
    hold off
    title(titles_2(k), 'FontSize', 16,'FontWeight','bold');
    set(gca,'FontSize',14)
    xlim([0 6]);
    ylim([-2 2]);
    xlabel('Trial')
    
    if(k==1)
        ylabel('\Delta HbO conc (\muM*mm)','FontSize',14,'FontWeight','bold')
        legend([h1 h2],{'Novice','Expert'});
    end
    if(k==8)
                ylim([-5 2])
    end
end