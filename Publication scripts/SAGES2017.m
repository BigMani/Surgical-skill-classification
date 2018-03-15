close all
clear all

SeniorThresh = .63*117;

titles_2 = {'Left Lateral PFC';
'Medial PFC';
'Right Lateral PFC';
'Left Lateral M1';
'Left Medial M1';
'Right Medial M1';
'Right Lateral M1';
'SMA'};
% Initializations

load('SAGES2017.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot by day (FLS)
%%%%%%%%%%%%%%%%%%%%%%%%%
dayGroup = [];

%Strucutre CTRL pre test scores
CTRLpretestscore = [38;84;44;34;57;79;55;30;54;0;10;85;0;0;0;0];
dayGroup = [dayGroup;repmat({'Control'},size(CTRLpretestscore,1),1)];

%Strucutre FLS learning
for i = 1:12
    structdayname = ['Day',num2str(i)];
    dayGroup = [dayGroup;repmat({structdayname},length(FLS_byDayScore.(structdayname)),1)];
end

%Structure break
BREAK = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN];
dayGroup = [dayGroup;{'Break week 1';'Break week 2'}];

%Structure FLS final
FLSposttestscore = [192;194;187;219;227;206;191;236;237;211;228;230;222;229;237;222;223;229;235;244;246;222;245;250];
dayGroup = [dayGroup;repmat({'Trained FLS'},size(FLSposttestscore,1),1)];

%Structure CTL final
CTRLposttestscore = [87;94;60;57;99;128;54;67;106;63];
dayGroup = [dayGroup;repmat({'Control '},size(CTRLposttestscore,1),1)];

%Structure VBLAST final
V_FLSposttestscore = [105;85;130;78;80;84;138;108;158;109;131];
dayGroup = [dayGroup;repmat({'Trained VBLaST'},size(V_FLSposttestscore,1),1)];


for k = 1:1
    figure
    boxplot([CTRLpretestscore(:,k);NaN(size(dayGroup,1)-(size(CTRLpretestscore,1))-(size(CTRLposttestscore,1))-(size(FLSposttestscore,1)) - (size(V_FLSposttestscore,1)),1);NaN(size(FLSposttestscore,1),1);CTRLposttestscore(:,k);NaN(size(V_FLSposttestscore,1),1)],dayGroup,'Colors','g');
    hold on
    boxplot([NaN(size(CTRLpretestscore,1),1);FLS_byDayScore.Day1(:,k);FLS_byDayScore.Day2(:,k);FLS_byDayScore.Day3(:,k);FLS_byDayScore.Day4(:,k);FLS_byDayScore.Day5(:,k);FLS_byDayScore.Day6(:,k);FLS_byDayScore.Day7(:,k);FLS_byDayScore.Day8(:,k);FLS_byDayScore.Day9(:,k);FLS_byDayScore.Day10(:,k);FLS_byDayScore.Day11(:,k);FLS_byDayScore.Day12(:,k);BREAK(1,k);BREAK(1,k);FLSposttestscore(:,k);NaN(size(CTRLposttestscore,1),1);NaN(size(V_FLSposttestscore,1),1)],dayGroup,'Colors','m');
    boxplot([NaN(size(dayGroup,1)-(size(CTRLposttestscore,1))-(size(FLSposttestscore,1))-(size(V_FLSposttestscore,1)),1);NaN(size(FLSposttestscore,1),1);NaN(size(CTRLposttestscore,1),1);V_FLSposttestscore(:,k)],dayGroup,'Colors','b');
    hold off
    set(gca,'FontSize',14,'XTickLabelRotation',45)
    ylim([-50 300]);
    ylabel('FLS pattern cutting score','FontName','Times New Roman','FontSize',18,'interpreter','tex')
    %title('FLS pattern cutting learning curve', 'FontSize', 16);
    p = ranksum(CTRLpretestscore,FLS_byDayScore.Day1);
    p = floor(p*1000)/1000;
    if p<0.05
        pp = '*';
    else
        pp = 'n.s.';
    end
    text(.06,.08,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    
    p = ranksum(CTRLposttestscore,FLSposttestscore);
    p = floor(p*1000)/1000;
    if p<0.05
        pp = '*';
    else
        pp = 'n.s.';
    end
    text(.89,.08,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    
    p = ranksum(CTRLposttestscore,V_FLSposttestscore);
    p = floor(p*1000)/1000;
    if p<0.05
        pp = '*';
    else
        pp = 'n.s.';
    end
    text(.95,.08,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
end

%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot by day (VBLAST)
%%%%%%%%%%%%%%%%%%%%%%%%%
dayGroup = [];

%Strucutre CTRL pre test scores
VBLASTCTRLpretestscore = [116;115;103;112;120;0;0;121;122;154;140;98];
dayGroup = [dayGroup;repmat({'Control'},size(VBLASTCTRLpretestscore,1),1)];

%Strucutre FLS learning
for i = 1:12
    structdayname = ['Day',num2str(i)];
    dayGroup = [dayGroup;repmat({structdayname},length(VBLAST_byDayScore.(structdayname)),1)];
end

%Structure break
BREAK = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN];
dayGroup = [dayGroup;{'Break week 1';'Break week 2'}];

%Structure VBLAST final
VBLASTposttestscore = [193;186;180;188;199;207;183;229;223;196;195;212;216;217;217;236;242;250];
dayGroup = [dayGroup;repmat({'Trained VBLaST'},size(VBLASTposttestscore,1),1)];

%Structure CTL final
VBLASTCTRLposttestscore = [133;163;180;132;163;175;134;123;146;159;163;189];
dayGroup = [dayGroup;repmat({'Control '},size(VBLASTCTRLposttestscore,1),1)];

%Structure FLS final
F_VBLASTposttestscore = [137;145;185;159;213;213;187;167;192;177;164;159;149;187;168;161;195;221;119;184;198];
dayGroup = [dayGroup;repmat({'Trained FLS'},size(F_VBLASTposttestscore,1),1)];

for k = 1:1
    figure
    boxplot([VBLASTCTRLpretestscore(:,k);NaN(size(dayGroup,1)-(size(VBLASTCTRLpretestscore,1))-(size(VBLASTCTRLposttestscore,1))-(size(VBLASTposttestscore,1)) - (size(F_VBLASTposttestscore,1)),1);NaN(size(VBLASTposttestscore,1),1);VBLASTCTRLposttestscore(:,k);NaN(size(F_VBLASTposttestscore,1),1)],dayGroup,'Colors','g');
    hold on
    boxplot([NaN(size(VBLASTCTRLpretestscore,1),1);VBLAST_byDayScore.Day1(:,k);VBLAST_byDayScore.Day2(:,k);VBLAST_byDayScore.Day3(:,k);VBLAST_byDayScore.Day4(:,k);VBLAST_byDayScore.Day5(:,k);VBLAST_byDayScore.Day6(:,k);VBLAST_byDayScore.Day7(:,k);VBLAST_byDayScore.Day8(:,k);VBLAST_byDayScore.Day9(:,k);VBLAST_byDayScore.Day10(:,k);VBLAST_byDayScore.Day11(:,k);VBLAST_byDayScore.Day12(:,k);BREAK(1,k);BREAK(1,k);VBLASTposttestscore(:,k);NaN(size(VBLASTCTRLposttestscore,1),1);NaN(size(F_VBLASTposttestscore,1),1)],dayGroup,'Colors','b');
    boxplot([NaN(size(dayGroup,1)-(size(VBLASTCTRLposttestscore,1))-(size(VBLASTposttestscore,1))-(size(F_VBLASTposttestscore,1)),1);NaN(size(VBLASTposttestscore,1),1);NaN(size(VBLASTCTRLposttestscore,1),1);F_VBLASTposttestscore(:,k)],dayGroup,'Colors','m');
    hold off
    set(gca,'FontSize',14,'XTickLabelRotation',45)
    ylim([-50 300]);
    ylabel('VBLaST pattern cutting score','FontName','Times New Roman','FontSize',18,'interpreter','tex')
    %title('VBLAST pattern cutting learning curve', 'FontSize', 16);
    
    p = ranksum(VBLASTCTRLpretestscore,VBLAST_byDayScore.Day1);
    p = floor(p*1000)/1000;
    if p<0.05
        pp = '*';
    else
        pp = 'n.s.';
    end
    text(.06,.08,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    
    p = ranksum(VBLASTCTRLposttestscore,VBLASTposttestscore);
    p = floor(p*1000)/1000;
    if p<0.05
        pp = '*';
    else
        pp = 'n.s.';
    end
    text(.89,.08,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    
    p = ranksum(VBLASTCTRLposttestscore,F_VBLASTposttestscore);
    p = floor(p*1000)/1000;
    if p<0.05
        pp = '*';
    else
        pp = 'n.s.';
    end
    text(.95,.08,pp,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
end

%% Descriptive statistics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p0 = 0.05;
p1 = .1;
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
    
[t1,~,~,cs1]=CUSUM(FLSscorebySub.Sub1,SeniorThresh,s,s1);
[t2,~,~,cs2]=CUSUM(FLSscorebySub.Sub2,SeniorThresh,s,s1);
[t3,~,~,cs3]=CUSUM(FLSscorebySub.Sub3,SeniorThresh,s,s1);
[t4,~,~,cs4]=CUSUM(FLSscorebySub.Sub4,SeniorThresh,s,s1);
[t6,~,~,cs6]=CUSUM(FLSscorebySub.Sub6,SeniorThresh,s,s1);
[t7,~,~,cs7]=CUSUM(FLSscorebySub.Sub7,SeniorThresh,s,s1);
[t8,~,~,cs8]=CUSUM(FLSscorebySub.Sub8,SeniorThresh,s,s1);


figure
%plot the learning curve 
UL(1:101)=h1;
LL(1:101)=h0;

%plot(t1,cs1,t2,cs2,t3,cs3,t4,cs4,t6,cs6,t7,cs7,t8,cs8,'Marker', '.');
colormap hsv
plot(t1,cs1,t2,cs2,t3,cs3,t4,cs4,t6,cs6,t7,cs7,t8,cs8,'Marker', '*');


ylabel('CUSUM score','fontsize',14)
xlabel('Trial','fontsize',14);
%title('FLS PC score learning curve', 'FontSize', 16);

hold on;
plot(0:100,UL, 'Color',[0,0,0], 'LineWidth', 2,'LineStyle','--');
plot(0:100,LL, 'Color',[0,0,0], 'LineWidth', 2);
%text(.93,.40,'H_1','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
%text(.93,.17,'H_0','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
hold off;
legend('FLS-1','FLS-2', 'FLS-3', 'FLS-4','FLS-5','FLS-6','FLS-7','H_1','H_0');
clear UL;
clear LL;

[t1,~,~,cs1]=CUSUM(VBLASTscorebySub.Sub1,SeniorThresh,s,s1);
[t2,~,~,cs2]=CUSUM(VBLASTscorebySub.Sub2,SeniorThresh,s,s1);
[t3,~,~,cs3]=CUSUM(VBLASTscorebySub.Sub3,SeniorThresh,s,s1);
[t4,~,~,cs4]=CUSUM(VBLASTscorebySub.Sub4,SeniorThresh,s,s1);
[t5,~,~,cs5]=CUSUM(VBLASTscorebySub.Sub5,SeniorThresh,s,s1);
[t6,~,~,cs6]=CUSUM(VBLASTscorebySub.Sub6,SeniorThresh,s,s1);

figure
%plot the learning curve 
UL(1:121)=h1;
LL(1:121)=h0;

plot(t1,cs1,t2,cs2,t3,cs3,t4,cs4,t5,cs5,t6,cs6,'Marker', '*');

ylabel('CUSUM score','fontsize',16)
xlabel('Trial','fontsize',16);
%title('VBLaST PC score learning curve', 'FontSize', 16);
hold on;
plot(0:120,UL, 'Color',[0,0,0], 'LineWidth', 2);
plot(0:120,LL, 'Color',[0,0,0], 'LineWidth', 2);
text(.93,.60,'H_1','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
text(.93,.26,'H_0','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
hold off;
legend('VBLaST-1','VBLaST-2', 'VBLaST-3', 'VBLaST-4','VBLaST-5','VBLaST-6','H_1','H_0');

clear UL;
clear LL;