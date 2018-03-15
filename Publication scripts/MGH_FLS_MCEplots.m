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
MCE1_FLS = 100*[0.631523086394846;0.989070835200441;0.357276368033208;0.186635387727678;0.372750589449515;0.105306500606375;0.179897699233614;0.0550465232428562];
MCE2_FLS = 100*[0.564550009626415;0.599899991475873;0.582790090093425;0.254848017730662;0.571404522442315;0.119395409411427;0.196365323895441;0.0595139053106734];
CVMCEpercent_FLS = [36.0655737704918;13.7254901960784;55.3191489361702;73.6842105263158;54.3478260869565;86.3636363636364;79.1666666666667;100];
drawMCEerrors(MCE1_FLS, MCE2_FLS)
drawCVMCE(CVMCEpercent_FLS);

% MCE1_FLS_noSS = 100*[0.631523086394846;0.954606269934221;0.896544134040404;0.896544134040404;0.893471701895985;0.680943523923324;0.466126669667442;0.477300862946095];
% MCE2_FLS_noSS = 100*[0.564550009626415;0.932166569231998;0.710860030140563;0.627077549004918;0.761179789661880;0.480608194710354;0.507186269105266;0.522721311765171];
% CVMCEpercent_FLS_noSS = [36.0655737704918;6.25000000000000;18.3673469387755;49.1803278688525;14.8936170212766;42.8571428571429;43.7500000000000;42.5531914893617];
% drawMCEerrors(MCE1_FLS_noSS, MCE2_FLS_noSS);
% drawCVMCE(CVMCEpercent_FLS_noSS);


function drawCVMCE(CVMCEpercent)
figure
t = 1:8;
index = t<2;
hold on
plot(t, CVMCEpercent,'color','k','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','k','LineWidth', 2)
plot(t(index), CVMCEpercent(index),'color','r','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','r','LineWidth', 2)
set(gca,'FontSize',14);
ylabel('ratio of samples\newlinewith MCE<0.05 (%)','fontsize',20)
xlabel('Cross-validated LDA projected scores','fontsize',20)
set(gca,'XTickLabel',{'FLS score','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'})
xtickangle(45)
ylim([0 100]);
hold off
end

function drawMCEerrors(MCE1, MCE2)
figure
t = 1:8;
index = t<2;
hold on
h1 = plot(t, MCE1,'color','k','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','k','LineWidth', 2);
h2 = plot(t(index), MCE1(index),'color','r','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','r','LineWidth', 2);
h3 = plot(t, MCE2,'color',[.25 .25 .25],'MarkerSize',7,'Marker', 'o', 'MarkerFaceColor',[.25 .25 .25],'LineWidth', 2, 'LineStyle','--');
h4 = plot(t(index), MCE2(index),'color','r','MarkerSize',7,'Marker', 'o', 'MarkerFaceColor','r','LineWidth', 2,'LineStyle','--');
set(gca,'FontSize',12);
ylabel('MCE (%)','fontsize',20)
xlabel('LDA projected scores','fontsize',20)
set(gca,'XTickLabel',{'FLS score','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'})
xtickangle(45)
legend([h1,h3],{'MCE_{12}','MCE_{21}'});
ylim([0 100]);
hold off
end