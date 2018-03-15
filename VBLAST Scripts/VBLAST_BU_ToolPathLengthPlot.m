close all
%Total pathlength plots
[p,~] = ranksum(Novice_LeftPathlength,Expert_LeftPathlength);
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
group = [repmat({'Novice'}, length(Novice_LeftPathlength), 1); repmat({'Expert'}, length(Expert_LeftPathlength), 1)];
figure;
boxplot([Novice_LeftPathlength;Expert_LeftPathlength], group)
%ylim([40 240])
t = text(.85,.96,pp,'Units','normalized','FontSize',14,'FontWeight','bold');
ylabel('Total path length (m)','FontSize',16,'FontWeight','bold')
title('Total VBLAST left tool tip pathlength','FontSize',18,'FontWeight','bold')
set(gca,'FontSize',12)

[p,~] = ranksum(Novice_RightPathlength,Expert_RightPathlength);
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
group = [repmat({'Novice'}, length(Novice_RightPathlength), 1); repmat({'Expert'}, length(Expert_RightPathlength), 1)];
figure;
boxplot([Novice_RightPathlength;Expert_RightPathlength], group)
%ylim([40 240])
t = text(.85,.96,pp,'Units','normalized','FontSize',14,'FontWeight','bold');
ylabel('Total path length (m)','FontSize',16,'FontWeight','bold')
title('Total VBLAST right tool tip pathlength','FontSize',18,'FontWeight','bold')
set(gca,'FontSize',12)