close all
%Total pathlength plots
[p,~] = ranksum(ToolPathlength.Novice_Left,ToolPathlength.Expert_Left);
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
group = [repmat({'Novice'}, length(ToolPathlength.Novice_Left), 1); repmat({'Expert'}, length(ToolPathlength.Expert_Left), 1)];
figure;
boxplot([ToolPathlength.Novice_Left;ToolPathlength.Expert_Left], group)
%ylim([40 240])
t = text(.85,.96,pp,'Units','normalized','FontSize',14,'FontWeight','bold');
ylabel('Total path length (m)','FontSize',16,'FontWeight','bold')
title('Total VBLAST left tool tip pathlength','FontSize',18,'FontWeight','bold')
set(gca,'FontSize',12)

[p,~] = ranksum(ToolPathlength.Novice_Right,ToolPathlength.Expert_Right);
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
group = [repmat({'Novice'}, length(ToolPathlength.Novice_Right), 1); repmat({'Expert'}, length(ToolPathlength.Expert_Right), 1)];
figure;
boxplot([ToolPathlength.Novice_Right;ToolPathlength.Expert_Right], group)
%ylim([40 240])
t = text(.85,.96,pp,'Units','normalized','FontSize',14,'FontWeight','bold');
ylabel('Total path length (m)','FontSize',16,'FontWeight','bold')
title('Total VBLAST right tool tip pathlength','FontSize',18,'FontWeight','bold')
set(gca,'FontSize',12)