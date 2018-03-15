figure
load('E_Avg.mat')
load('N_Avg.mat')

%nirsdata = [N_Avg;E_Avg];
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
    t_n = N_Avg(:,i);
    t_e = E_Avg(:,i);
    [p,~] = ranksum(t_n,t_e);
    p = floor(p*1000)/1000;
    pp = strcat('p = ',{' '},num2str(p));
    group = [repmat({'Novice'}, size(N_Avg,1), 1); repmat({'Expert'}, size(E_Avg,1), 1)];
    boxplot(1E6*[N_Avg(:,i);E_Avg(:,i)],group)
    ppos = get(h1,'pos');
    ppos(3) = ppos(3) + 0.01;
    set(h1,'pos',ppos);
    set(gca,'FontSize',14)
    t = text(.4,.93,pp,'Units','normalized','FontSize',12,'FontWeight','bold');
    title(titles_2(i), 'FontSize', 16,'FontWeight','bold');
    if(i==1)
        ylabel('\Delta HbO conc (\muM*mm)','FontSize',14,'FontWeight','bold')
    end
        ylim([-1.8 1]);
end
Novice_PC = [166.56;158.07;59.8;173.78;122.59;127.57;123.98];
Expert_PC = [186.36;222.024;198.88;167.14;184.63;150.58;181.19];
scores = [Novice_PC;Expert_PC];
nirsdata = [N_Avg;E_Avg];
clusterdata = [nirsdata,scores];

figure
for i = 1:8
    subplot(3,3,i);

    %k means clustering of PC scores and delta HbO2
    opts = statset('Display','final','UseParallel',1);
    X = [clusterdata(:,9),1E6*clusterdata(:,i)];
    [idx,C] = kmeans(X,2,'Distance','sqeuclidean','Options',opts,'Replicates',5);
    if(any(X(idx==1,1)>200))
        
        plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',22)
        hold on
        plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',22)
    else
        plot(X(idx==1,1),X(idx==1,2),'b.','MarkerSize',22)
        hold on
        plot(X(idx==2,1),X(idx==2,2),'r.','MarkerSize',22)
    end
    
    plot(C(:,1),C(:,2),'kx',...
         'MarkerSize',15,'LineWidth',3)
    %legend('Novice','Expert','Centroids','Location','NW')
           
    title(titles_2(i), 'FontSize', 16,'FontWeight','bold');
    set(gca,'FontSize',14);
    ylim([-1.5, 1]);
    if(i==1)
        ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',22,'interpreter','tex')
        xlabel('Pattern Cutting score')
    end
end

figure
for i = 1:8
    subplot(3,3,i);

    %ground truth
    X = [clusterdata(:,9),1E6*clusterdata(:,i)];   
        plot(X(1:7,1),X(1:7,2),'b.','MarkerSize',22)
        hold on
        plot(X(8:end,1),X(8:end,2),'r.','MarkerSize',22)  
    title(titles_2(i), 'FontSize', 16,'FontWeight','bold');
    set(gca,'FontSize',14);
    ylim([-1.5, 1]);
    if(i==1)
        ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',22,'interpreter','tex')
        xlabel('Pattern Cutting score (ground truth)')
    end
end