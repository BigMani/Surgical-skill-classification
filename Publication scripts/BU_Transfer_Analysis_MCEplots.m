close all
% global Type_II_E
% global Type_II_N
% if exist('MCE1','var')
%     
% else
%     MCE1 = [];
% end
% 
% if exist('MCE2','var')
%     
% else
%     MCE2 = [];
% end
% 
% if exist('CVMCEpercent','var')
%     
% else
%     CVMCEpercent = [];
% end
% MCE1 = [MCE1;Type_II_E];
% MCE2 = [MCE2;Type_II_N];
% CVMCEpercent = [CVMCEpercent;CVMCE];

% %%%%%%%%%%%%%%%%%%%%%%
MCE1_FLS = [0.198912853302252;0.687687709885755;0.161390034203688;0.599117266628906;0.214571677401086;0.106796948927170;0.440812061912594;0.0222697677219468];
MCE2_FLS = [0.142573610461172;0.297768981873560;0.627751588364572;0.847014405662352;0.295645928713728;0.0827612446159028;0.286778329168931;0.0273043771349868];
CVMCEpercent_FLS = [83.3333333333333;33.3333333333333;58.3333333333333;25;66.6666666666667;91.6666666666667;58.3333333333333;83.3333333333333];

MCE1_VBLAST = [0.199797085576345;0.249637547957329;0.232521629523862;0.410767441931444;0.0968439576739261;0.0760188104188979;0.185664143958744;0.0886595642540879];
MCE2_VBLAST = [0.407305030727547;0.181611647242387;0.238656056937960;0.710290084752217;0.0810752540657380;0.0627278310451844;0.234707646635075;0.0914726982701163];
CVMCEpercent_VBLAST = [72.7272727272727;72.7272727272727;72.7272727272727;54.5454545454546;90.9090909090909;72.7272727272727;54.5454545454546;72.7272727272727];
% %%%%%%%%%%%%%%%%%%%%%%
% MCE1 = [MCE1;Type_II_E];
% MCE2 = [MCE2;Type_II_N];
% CVMCEpercent = [CVMCEpercent;CVMCE];

drawMCEerrors(MCE1_FLS, MCE2_FLS, [91 155 213]/256, {'Classification metrics','FLS trained vs control subjects'})
drawMCEerrors(MCE1_VBLAST, MCE2_VBLAST, [237 125 49]/256, {'Classification metrics','VBLaST trained vs control subjects'})

drawCVMCE(CVMCEpercent_FLS,CVMCEpercent_VBLAST, [91 155 213]/256, [237 125 49]/256);

function drawCVMCE(CVMCEpercent1,CVMCEpercent2 ,color1, color2)
figure
t = 1:8;
index = t<2;
hold on
h1 = plot(t, CVMCEpercent1,'color',color1,'MarkerSize',7,'Marker', 'o', 'MarkerFaceColor',color1,'LineWidth', 2);
h2 = plot(t(index), CVMCEpercent1(index),'color','r','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','r','LineWidth', 2);
h3 = plot(t, CVMCEpercent2,'color',color2,'MarkerSize',7,'Marker', 'o', 'MarkerFaceColor',color2,'LineWidth', 2);
h4 = plot(t(index), CVMCEpercent2(index),'color','r','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','r','LineWidth', 2);

set(gca,'FontSize',16);
ylabel({'% samples with','MCE < 0.05'},'fontsize',20)
xlabel('Cross-validation of classification models','fontsize',20)
set(gca,'XTickLabel',{'Transfer task time','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'})
xtickangle(45)
legend([h1, h3],{'FLS trained vs control','VBLaST trained vs control'})
ylim([0 100]);
hold off
end

function drawMCEerrors(MCE1, MCE2, color, Xlabel)
figure
t = 1:8;
index = t<2;
hold on
h1 = plot(t, 100*MCE1,'color',color,'MarkerSize',7,'Marker', 'o', 'MarkerFaceColor',color,'LineWidth', 2);
h2 = plot(t(index), 100*MCE1(index),'color','r','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','r','LineWidth', 2);
h3 = plot(t, 100*MCE2,'color',color,'MarkerSize',7,'Marker', 'o', 'MarkerFaceColor',color,'LineWidth', 2, 'LineStyle','--');
h3.Color(4) = 0.8;
h4 = plot(t(index), 100*MCE2(index),'color','r','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','r','LineWidth', 2,'LineStyle','--');
set(gca,'FontSize',16);
ylabel('MCE (%)','fontsize',20)
xlabel(Xlabel,'fontsize',20)
set(gca,'XTickLabel',{'Transfer task time','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'})
xtickangle(45)
ylim([0 100]);
legend([h1, h3],{'MCE_1','MCE_2'})
hold off
end