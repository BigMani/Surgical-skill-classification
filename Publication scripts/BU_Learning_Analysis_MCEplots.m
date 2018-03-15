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
% 
% MCE1 = [MCE1;Type_II_E];
% MCE2 = [MCE2;Type_II_N];
% CVMCEpercent = [CVMCEpercent;CVMCE];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SvC_pretest_MCE1 = [0.777249556631427;0.838856556234477;0.959267392453207;0.959267392453207;0.869151424662123;0.869151424662123;0.566051326981118;0.512121134297771];
SvC_pretest_MCE2 = [0.965348419496746;0.753470349927261;0.510205768343368;0.869493739921432;0.450441121904038;0.668904681451295;0.960273531604533;0.972633632557588];
SvC_pretest_CVMCEpercent = [11.5384615384615;18.1818181818182;23.8095238095238;15.3846153846154;26.3157894736842;36.3636363636364;9.52380952380952;26.3157894736842];

SvC_posttest_MCE1 = [0;0.550972321520334;0.344172800386602;0.306426610935353;0.376563454059538;0.208342448754031;0.347082141872559;0.161128161956814];
SvC_postest_MCE2 = [0;0.850821198926710;0.480740806688354;0.510161195709289;0.390698404625269;0.118997772906031;0.456026699340548;0.0952221347028999];
SvC_posttest_CVMCEpercent = [100;23.8095238095238;52.3809523809524;38.0952380952381;42.8571428571429;76.1904761904762;33.3333333333333;85.7142857142857];

JvC_pretest_MCE1 =[0.252756659457446;0.995460201179677;0.974888383568942;0.974888383568942;0.999999999818698;0.999999999818698;0.999999999818698;0.872950842826654];
JvC_pretest_MCE2 =[0.819358159874309;0.836074514691336;0.601168178761889;0.797810229622989;0.838019822709169;0.973273946999214;0.900224651974156;0.709179108288138];
JvC_pretest_CVMCEpercent =[32.1428571428571;10.3448275862069;21.4285714285714;20;15.3846153846154;25.9259259259259;10.7142857142857;8];

JvC_posttest_MCE1 = [0;0.349467249366412;0.887978731991147;0.938215313889844;0.445644806032903;0.998218343695485;0.756648923552242;0.458495325962605];
JvC_posttest_MCE2 = [0;0.983419277960418;0.819881157863921;0.759051728845605;0.696535991476007;0.625763788197100;0.439182427851231;0.501117810499301];
JvC_posttest_CVMCEpercent = [100;33.3333333333333;12.5000000000000;12.5000000000000;41.6666666666667;20.8333333333333;33.3333333333333;45.8333333333333];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Draw plots for seniors
drawMCEerrors(SvC_pretest_MCE1, SvC_pretest_MCE2, 'b', 'LDA model of Seniors vs control during pre-test')
drawCVMCE(SvC_pretest_CVMCEpercent, 'b');

drawMCEerrors(SvC_posttest_MCE1, SvC_postest_MCE2, 'b', 'LDA model of Seniors vs control during post-test')
drawCVMCE(SvC_posttest_CVMCEpercent,'b');

%Draw plots for juniors
drawMCEerrors(JvC_pretest_MCE1, JvC_pretest_MCE2, 'g', 'LDA model of Juniors vs control during pre-test')
drawMCEerrors(JvC_posttest_MCE1, JvC_posttest_MCE2, 'g', 'LDA model of Juniors vs control during post-test')

drawCVMCE(JvC_pretest_CVMCEpercent,'g');
hold on
drawCVMCE(JvC_posttest_CVMCEpercent,'g');

function drawCVMCE(CVMCEpercent,color)
figure
t = 1:8;
index = t<2;
hold on
plot(t, CVMCEpercent,'color',color,'MarkerSize',7,'Marker', 'o', 'MarkerFaceColor',color,'LineWidth', 2)
plot(t(index), CVMCEpercent(index),'color','m','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','m','LineWidth', 2)
set(gca,'FontSize',20);
ylabel('% samples with MCE < 0.05','fontsize',20)
xlabel('Cross-validated LDA projected scores','fontsize',20)
set(gca,'XTickLabel',{'FLS score','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'})
xtickangle(45)
ylim([0 100]);
hold off
end

function drawMCEerrors(MCE1, MCE2, color, Xlabel)
figure
t = 1:8;
index = t<2;
hold on
h1 = plot(t, 100*MCE1,'color',color,'MarkerSize',7,'Marker', 'o', 'MarkerFaceColor',color,'LineWidth', 2);
h2 = plot(t(index), 100*MCE1(index),'color','m','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','m','LineWidth', 2);
h3 = plot(t, 100*MCE2,'color',color,'MarkerSize',7,'Marker', 'o', 'MarkerFaceColor',color,'LineWidth', 2, 'LineStyle','--');
h3.Color(4) = 0.5;
h4 = plot(t(index), 100*MCE2(index),'color','m','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','m','LineWidth', 2,'LineStyle','--');
set(gca,'FontSize',20);
ylabel('Misclassificaiton error %','fontsize',20)
xlabel(Xlabel,'fontsize',20)
set(gca,'XTickLabel',{'FLS score','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'})
xtickangle(45)
ylim([0 100]);
legend([h1, h3],{'MCE_1','MCE_2'})
hold off
end