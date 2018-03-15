%This script plots FLS, VBLAST, and retention scores
close all
load('Scores.mat');

h = figure;
set(h, 'DefaultTextFontSize', 10);
group = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', 'Break', 'Break ','Final'};
b1 = boxplot(CTRL_FLS,group,'color', 'r');
set(gca, 'xticklabel', {''});
hold on
%boxplot(VBLAST_finalFLS,group,'color', 'g');
set(gca, 'xticklabel', {''});
b2 = boxplot(FLS_byDay,group);
hold off
xlabel('Training Day','fontsize',14)
ylabel('FLS Pattern cutting score','fontsize',14);
legend([b1(4),b2(5)],'Control group','FLS training group','Location','south');
[p,~] = ranksum(CTRL_FLS(:,15),FLS_byDay(:,15));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.9,.05,pp,'Units','normalized','FontSize',12,'FontWeight','bold');
title('FLS performance score learning curve','FontSize',15);

figure;
v1 = boxplot(CTRL_VBLAST,group,'color', 'r');
set(gca, 'xticklabel', {''});
hold on
%boxplot(FLS_finalVBLAST,group,'color', 'g');
set(gca, 'xticklabel', {''});
v2 = boxplot(VBLAST_byDay,group);
hold off
xhandle=get(gca,'Xlabel');
set(xhandle,'Fontsize',15);
xlabel('Training Day','fontsize',14)
ylabel('VBLAST Pattern cutting score','fontsize',14);
legend([v1(4),v2(5)],'Control group','VBLAST training group','Location','south');
[p,~] = ranksum(CTRL_VBLAST(:,15),VBLAST_byDay(:,15));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.9,.05,pp,'Units','normalized','FontSize',12,'FontWeight','bold');
title('FLS performance score learning curve','FontSize',15);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CTRL_FLS(16:72,1) = NaN;
CTRL_FLS(16:72,15) = NaN;
CTRL_VBLAST(13:51,1) = NaN;
CTRL_VBLAST(13:51,15) = NaN;
FLS_finalVBLAST(22:51,15) = NaN;
VBLAST_finalFLS(19:72,15) = NaN;
VBLAST_finalVBLAST(19:51,15) = NaN;
BUFFER2(1:72,1) = NaN;
BUFFER3(1:51,1) = NaN;

c = [0,0,1;0,0.500000000000000,0;1,0,0;1,1,1;0,0.500000000000000,0;0,0,1;1,0,0];
group2 = {'','Day 1','','','','Final',''};
figure;
t1 = boxplot([CTRL_FLS(:,1),FLS_byDay(:,1),BUFFER2,BUFFER2,FLS_finalFLS,CTRL_FLS(:,15),VBLAST_finalFLS(:,15)],'colors',c, 'labels', group2);
xhandle=get(gca,'Xlabel');
set(xhandle,'Fontsize',15);
ylabel('FLS Pattern cutting scores','fontsize',14);
legend([t1(3),t1(12),t1(20)],'Control','FLS','VBLAST','Location','northwest');
[p,~] = ranksum(CTRL_FLS(:,1),FLS_byDay(:,1));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.1,.05,pp,'Units','normalized','FontSize',12,'FontWeight','bold');
title('FLS task retention scores','FontSize',15);
[p,~] = ranksum(CTRL_FLS(:,15),FLS_finalFLS);
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.65,.7,pp,'Units','normalized','FontSize',12,'FontWeight','bold');
[p,~] = ranksum(CTRL_FLS(:,15),VBLAST_finalFLS(:,15));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.8,.7,pp,'Units','normalized','FontSize',12,'FontWeight','bold');

c = [0,0,1;1,0,0;0,0.500000000000000,0;1,1,1;0,0.500000000000000,0;0,0,1;1,0,0];
group2 = {'','Day 1','','','','Final',''};
figure;
t1 = boxplot([CTRL_VBLAST(:,1),VBLAST_byDay(:,1),BUFFER3,BUFFER3,FLS_finalVBLAST(:,15),CTRL_VBLAST(:,15),VBLAST_finalVBLAST(:,15)],'colors',c, 'labels', group2);
xhandle=get(gca,'Xlabel');
set(xhandle,'Fontsize',15);
ylabel('VBLAST Pattern cutting scores','fontsize',14);
legend([t1(3),t1(20),t1(12)],'Control','FLS','VBLAST','Location','northwest');
[p,~] = ranksum(CTRL_VBLAST(:,1),VBLAST_byDay(:,1));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.1,.05,pp,'Units','normalized','FontSize',12,'FontWeight','bold');
title('VBLAST task retention scores','FontSize',15);
[p,~] = ranksum(CTRL_VBLAST(:,15),FLS_finalVBLAST(:,15));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.65,.2,pp,'Units','normalized','FontSize',12,'FontWeight','bold');
[p,~] = ranksum(CTRL_VBLAST(:,15),VBLAST_finalVBLAST(:,15));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.85,.2,pp,'Units','normalized','FontSize',12,'FontWeight','bold');

c = [0,0.500000000000000,0;0,0,1;1,0,0;0,0.500000000000000,0;0,0,1;1,0,0;0,0.500000000000000,0;0,0,1;1,0,0];
group3 = {'','PC Time','','','Removal Time','','','Total',''};
figure;
tr1 = boxplot([FLS_finalReal(:,1),CTRL_finalReal(:,1),VBLAST_finalReal(:,1),FLS_finalReal(:,2),CTRL_finalReal(:,2),VBLAST_finalReal(:,2),FLS_finalReal(:,3),CTRL_finalReal(:,3),VBLAST_finalReal(:,3)]/60,'colors',c, 'labels', group3);
xhandle=get(gca,'Xlabel');
set(xhandle,'Fontsize',15);
ylabel('Time (min)','fontsize',14);
legend([tr1(12),tr1(3),tr1(20)],'Control','FLS','VBLAST','Location','northwest');
title('Transfer task completion time','FontSize',15);
[p,~] = ranksum(FLS_finalReal(:,1),CTRL_finalReal(:,1));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.05,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

[p,~] = ranksum(VBLAST_finalReal(:,1),CTRL_finalReal(:,1));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.2,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

[p,~] = ranksum(FLS_finalReal(:,2),CTRL_finalReal(:,2));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.4,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

[p,~] = ranksum(VBLAST_finalReal(:,2),CTRL_finalReal(:,2));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.53,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

[p,~] = ranksum(FLS_finalReal(:,3),CTRL_finalReal(:,3));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.73,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

[p,~] = ranksum(VBLAST_finalReal(:,3),CTRL_finalReal(:,3));
p = floor(p*1000)/1000;
pp = strcat('p = ',{' '},num2str(p));
t = text(.88,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');
