% Define parameters
close all
load('FLSLearningNIRS_byTrial_2.mat');
titles_2 = {'Left Lateral PFC';
'Medial PFC';
'Right Lateral PFC';
'Left Lateral M1';
'Left Medial M1';
'Right Medial M1';
'Right Lateral M1';
'SMA'};

PFC_THRESH = -.2; %Junior: 41, Intermediate: 65, Senior: 76
M_THRESH = 0; %Junior: 59, Intermediate: 64, Senior: 68
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

% Plot learning curves for left, medial, and right PFC
for i = 1:3
[t1,~,~,cs1]=CUSUM_PFC(FLSLearningNIRS_byTrial.one(1:end,i),PFC_THRESH,s,s1);
[t2,~,~,cs2]=CUSUM_PFC(FLSLearningNIRS_byTrial.two(1:end,i),PFC_THRESH,s,s1);
[t3,~,~,cs3]=CUSUM_PFC(FLSLearningNIRS_byTrial.three(1:end,i),PFC_THRESH,s,s1);
[t4,~,~,cs4]=CUSUM_PFC(FLSLearningNIRS_byTrial.four(1:end,i),PFC_THRESH,s,s1);
[t5,~,~,cs5]=CUSUM_PFC(FLSLearningNIRS_byTrial.five(1:end,i),PFC_THRESH,s,s1);
[t6,~,~,cs6]=CUSUM_PFC(FLSLearningNIRS_byTrial.six(1:end,i),PFC_THRESH,s,s1);
[t7,~,~,cs7]=CUSUM_PFC(FLSLearningNIRS_byTrial.seven(1:end,i),PFC_THRESH,s,s1);
[t8,~,~,cs8]=CUSUM_PFC(FLSLearningNIRS_byTrial.eight(1:end,i),PFC_THRESH,s,s1);

figure
%plot the learning curve 
UL(1:length(t8))=h1;
LL(1:length(t8))=h0;

plot(t1,cs1,t2,cs2,t3,cs3,t4,cs4,t5,cs5,t6,cs6,t7,cs7,t8,cs8,'Marker', '*');
ylabel('CUSUM SCORE','fontsize',16)
xlabel('Trial','fontsize',16);
title(titles_2(i), 'FontSize', 16);
legend('FLS-1','FLS-2', 'FLS-3', 'FLS-4','FLS-5','FLS-6','FLS-7','FLS-8');
hold on;
plot(t8,UL, 'Color',[0,0,0], 'LineWidth', 2);
plot(t8,LL, 'Color',[0,0,0], 'LineWidth', 2);
hold off;
clear UL;
clear LL;
end

% Plot learning curves for left lateral, left medial, right medial, right lateral M1, and SMA
for i = 4:8
[t1,~,~,cs1]=CUSUM(FLSLearningNIRS_byTrial.one(1:end,i),M_THRESH,s,s1);
[t2,~,~,cs2]=CUSUM(FLSLearningNIRS_byTrial.two(1:end,i),M_THRESH,s,s1);
[t3,~,~,cs3]=CUSUM(FLSLearningNIRS_byTrial.three(1:end,i),M_THRESH,s,s1);
[t4,~,~,cs4]=CUSUM(FLSLearningNIRS_byTrial.four(1:end,i),M_THRESH,s,s1);
%[t5,~,~,cs5]=CUSUM(FLSLearningNIRS_byTrial.five(1:end,i),M_THRESH,s,s1);
[t6,~,~,cs6]=CUSUM(FLSLearningNIRS_byTrial.six(1:end,i),M_THRESH,s,s1);
[t7,~,~,cs7]=CUSUM(FLSLearningNIRS_byTrial.seven(1:end,i),M_THRESH,s,s1);
[t8,~,~,cs8]=CUSUM(FLSLearningNIRS_byTrial.eight(1:end,i),M_THRESH,s,s1);

figure;
%plot the learning curve 
UL(1:length(t8))=h1;
LL(1:length(t8))=h0;

plot(t1,cs1,t2,cs2,t3,cs3,t4,cs4,t6,cs6,t7,cs7,t8,cs8,'Marker', '*');
ylabel('CUSUM SCORE','fontsize',16)
xlabel('Trial','fontsize',16);
title(titles_2(i), 'FontSize', 16);
legend('FLS-1','FLS-2', 'FLS-3', 'FLS-4','FLS-6','FLS-7','FLS-8');
hold on;
plot(t8,UL, 'Color',[0,0,0], 'LineWidth', 2);
plot(t8,LL, 'Color',[0,0,0], 'LineWidth', 2);
hold off;
clear UL;
clear LL;
end