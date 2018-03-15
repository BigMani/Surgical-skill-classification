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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MCE1_VBLAST = [0.816469294795815;0.652988425512419;0.799333550583512;0.998767105240416;0.874281768056647;0.713620504170642;0.980263461408871;0.220859106165523;0.397737728591023;0.0909739305921191];
MCE2_VBLAST = [0.746712930361937;0.895487404160321;0.664237081944926;0.640692171442919;0.846527858976948;0.845731264295725;0.737511126415526;0.796347200672057;0.583354989914541;0.0781190954941725];
CVMCEpercent_VBLAST = [21.0526315789474;17.8571428571429;19.6428571428571;14.5454545454545;13.7254901960784;22.6415094339623;6.12244897959184;40.4255319148936;43.1372549019608;86.6666666666667];
drawMCEerrors(MCE1_VBLAST, MCE2_VBLAST)
drawCVMCE(CVMCEpercent_VBLAST);

function drawCVMCE(CVMCEpercent)
figure
t = 1:10;
index = t<2;
hold on
plot(t, CVMCEpercent,'color','k','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','k','LineWidth', 2)
plot(t(index), CVMCEpercent(index),'color','r','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','r','LineWidth', 2)
set(gca,'FontSize',14);
ylabel('% samples with MCE < 0.05','fontsize',20)
xlabel('Cross-validated LDA projected scores','fontsize',20)
set(gca,'XTickLabel',{'VBLaST score','Right tool PL','VBLaST score + PL','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'})
xtickangle(45)
ylim([0 100]);
hold off
end

function drawMCEerrors(MCE1, MCE2)
figure
t = 1:10;
index = t<2;
hold on
h1 = plot(t, 100*MCE1,'color','k','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','k','LineWidth', 2);
h2 = plot(t(index), 100*MCE1(index),'color','r','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','r','LineWidth', 2);
h3 = plot(t, 100*MCE2,'color',[.25 .25 .25],'MarkerSize',7,'Marker', 'o', 'MarkerFaceColor',[.25 .25 .25],'LineWidth', 2, 'LineStyle','--');
h4 = plot(t(index), 100*MCE2(index),'color','r','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','r','LineWidth', 2,'LineStyle','--');
set(gca,'FontSize',12);
ylabel('Misclassificaiton error','fontsize',20)
xlabel('LDA projected scores','fontsize',20)
set(gca,'XTickLabel',{'VBLaST score','Right tool PL','VBLaST score + PL','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'})
xtickangle(45)
legend([h1,h3], {'MCE_1','MCE_2'});
ylim([0 100]);
hold off
end