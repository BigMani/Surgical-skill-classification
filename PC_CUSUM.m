% Define parameters
close all
load('Scores.mat');
FLS_THRESH = 76; %Junior: 41, Intermediate: 65, Senior: 76
VBLAST_THRESH = 68; %Junior: 59, Intermediate: 64, Senior: 68
p0 = 0.05;
p1 = 2*p0;
alpha = 0.05;
beta = 0.20;

P = log(p1/p0);
Q = log((1-p0)/(1-p1));
s = Q/(P+Q);
s1 = 1-s;
a = log((1-beta)/alpha);
b = log((1-alpha)/beta);
h0 = -b/(P+Q);
h1 = a/(P+Q);

[t1,~,~,cs1]=CUSUM(FLS_bySub(1:120,1),FLS_THRESH,s,s1);
[t2,~,~,cs2]=CUSUM(FLS_bySub(1:124,2),FLS_THRESH,s,s1);
[t3,~,~,cs3]=CUSUM(FLS_bySub(1:73,3),FLS_THRESH,s,s1);
[t4,~,~,cs4]=CUSUM(FLS_bySub(1:129,4),FLS_THRESH,s,s1);
[t5,~,~,cs5]=CUSUM(FLS_bySub(1:125,5),FLS_THRESH,s,s1);
[t6,~,~,cs6]=CUSUM(FLS_bySub(1:121,6),FLS_THRESH,s,s1);
[t7,~,~,cs7]=CUSUM(FLS_bySub(1:116,7),FLS_THRESH,s,s1);
[t8,~,~,cs8]=CUSUM(FLS_bySub(1:120,8),FLS_THRESH,s,s1);

[t9,~,~,cs9]=CUSUM(VBLAST_bySub(1:68,1),VBLAST_THRESH,s,s1);
[t10,~,~,cs10]=CUSUM(VBLAST_bySub(1:56,2),VBLAST_THRESH,s,s1);
[t11,~,~,cs11]=CUSUM(VBLAST_bySub(1:37,3),VBLAST_THRESH,s,s1);
[t12,~,~,cs12]=CUSUM(VBLAST_bySub(1:61,4),VBLAST_THRESH,s,s1);
[t13,~,~,cs13]=CUSUM(VBLAST_bySub(1:93,5),VBLAST_THRESH,s,s1);
[t14,~,~,cs14]=CUSUM(VBLAST_bySub(1:68,6),VBLAST_THRESH,s,s1);
[t15,~,~,cs15] = CUSUM(VBLAST_bySub(1:58,7),VBLAST_THRESH,s,s1);


%plot the learning curve 
UL(1:length(t4))=h1;
LL(1:length(t4))=h0;

plot(t1,cs1,t2,cs2,t3,cs3,t4,cs4,t5,cs5,t6,cs6,t7,cs7,t8,cs8, 'Marker', '*');
ylabel('CUSUM SCORE','fontsize',16)
xlabel('Trial','fontsize',16);
title('FLS group CUSUM score (Senior, 76)', 'fontsize', 16);
legend('FLS1','FLS2', 'FLS3', 'FLS4','FLS5','FLS6', 'FLS7', 'FLS8');
hold on;
plot(t4,UL, 'Color',[0,0,0], 'LineWidth', 2);
plot(t4,LL, 'Color',[0,0,0], 'LineWidth', 2);
hold off;
figure;
%plot the learning curve 
clear UL
clear LL
UL(1:length(t13))=h1;
LL(1:length(t13))=h0;
plot(t15,cs15,t10,cs10,t11,cs11,t12,cs12,t13,cs13,t14,cs14,t15,cs15,'Marker', '*');
ylabel('CUSUM SCORE','fontsize',16)
xlabel('Trial','fontsize',16);
title('VBLAST group CUSUM score (Senior, 68)', 'fontsize', 16);
legend('VBLAST1','VBLAST2', 'VBLAST3', 'VBLAST4','VBLAST5','VBLAST6','VBLAST7');
hold on;
plot(t13,UL, 'Color',[0,0,0], 'LineWidth', 2);
plot(t13,LL, 'Color',[0,0,0], 'LineWidth', 2);