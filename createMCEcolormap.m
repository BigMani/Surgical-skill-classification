function createMCEcolormap(MCE, day)
% Data structure for MCE1 and MCE2
% MCE = [PreC_C; PreC_J; PreC_S; PreJ_C; PreJ_J; PreJ_S; PreS_C; PreS_J; PreS_S]
%thresh = 26; % 0.1 MCE
thresh = 13; % 0.05 MCE
figure
%colors = [ones(256, 1), [linspace(1,0,256);linspace(1,0,256)]';];
%colors = flipud(jet(256));

colors = flipud(gray(256-thresh));
colors = [ones(thresh,3);colors];
%colors(1:thresh,:) = ones(thresh,3);
colormap(colors)

MCEcolors = round(MCE*256);
MCEcolors(~MCEcolors) = 1;
v = [0 4; 0 6; 2 4; 
     2 4; 2 6; 0 6;
     2 4; 2 6; 4 4;
     4 4; 4 6; 2 6;
     4 4; 4 6; 6 4;
     6 4; 4 6; 6 6;
     0 2; 0 4; 2 2;
     2 2; 0 4; 2 4;
     2 2; 2 4; 4 2;
     4 2; 2 4; 4 4;
     4 2; 4 4; 6 2;
     6 2; 4 4; 6 4;
     0 0; 0 2; 2 0; 
     2 0; 2 2; 0 2;
     2 0; 2 2; 4 0;
     4 0; 2 2; 4 2;
     4 0; 4 2; 6 0;
     6 0; 4 2; 6 2];
 
f = reshape(1:54,[3,18])';
%col = [0; .25; .4; .5; 0.1; .9;1;.4];

axis([0 6 0 6])
patch('Faces',f,'Vertices',v,'FaceVertexCData',colors(MCEcolors,:),'FaceColor','flat');
xticklabels({'','Control','','Unskilled\newlinetrainee','','Skilled\newlinetrainee',''})
yticklabels({'','Skilled\newlinetrainee','','Unskilled\newlinetrainee','','Control',''})
set(gca,'FontSize',14)
title(day, 'FontSize',16)
%set(get(gca,'title'),'Position',[4 6.07 0])
% h = xlabel(day);
% pos = get(h,'pos') + [(2/3), 0, 0];
% set(get(gca,'xlabel'),'position',pos)

ylabel('Final training day','FontSize',16)
ytickangle(90);
%text(0.2, 4.5, 'MCE_1','FontSize',14,'color','k');
%text(1, 5.4, 'MCE_2','FontSize',14,'color','k');
colorbar
end