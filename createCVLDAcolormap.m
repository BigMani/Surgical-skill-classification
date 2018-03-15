function createCVLDAcolormap(LDAData, LDACVModel, MCEthresh, case1color, case2color, colormode, swapClasses)
set(0,'defaultfigurecolor',[1 1 1])
figure
hold on
% Set colormap
switch colormode
    case 'jet'
        colors = jet(100);
    case 'gray'
        colors = gray(100);
    case 'summer'
        colors = summer(100);
    case 'hot'
        colors = hot(100);
end
colors = flipud(colors);
colormap(colors)

% Size and box constants

index = [round(100*LDACVModel.pValueTypeII(1:LDAData.K(1))),round(100*LDACVModel.pValueTypeII(LDAData.K(1)+1:end))];
index(~index)=1;
colorFace1 = colors(index,:);

index = [round(100*LDACVModel.pValueTypeII(LDAData.K(1)+1:end)),round(100*LDACVModel.pValueTypeII(1:LDAData.K(1)))];
index(~index)=1;
colorFace2 = colors(index,:);

SquareX = 0;
SquareY = .5;

% Display number of boxes  number boxes below MCEthresh
Total = size(LDACVModel.pValueTypeII,2);
Sig = sum(LDACVModel.pValueTypeII<MCEthresh);
output = [num2str(Sig), '/', num2str(Total)];
switch swapClasses
    case 0
        for i = 1:sum(LDAData.K)
            if (i<LDAData.K(1)+1)
                SquareX = SquareX + .07;
                rectangle('Position',[SquareX SquareY,  .07 .07],'EdgeColor',case1color,'LineWidth',3,'FaceColor',colorFace1(i,:))
                text(SquareX - 0.02,SquareY - 0.05,num2str(i),'FontSize',12);
            else
                SquareX = SquareX + .07;
                rectangle('Position',[SquareX, SquareY  .07 .07],'EdgeColor',case2color,'LineWidth',3,'FaceColor',colorFace1(i,:))
                text(SquareX - 0.02,SquareY - 0.05,num2str(i),'FontSize',12);
            end
        end
    case 1
        for i = 1:sum(LDAData.K)
            if (i<LDAData.K(2)+1)
                SquareX = SquareX + .07;
                rectangle('Position',[SquareX SquareY,  .07 .07],'EdgeColor',case2color,'LineWidth',3,'FaceColor',colorFace2(i,:))
                text(SquareX - 0.02,SquareY - 0.05,num2str(i),'FontSize',12);
            else
                SquareX = SquareX + .07;
                rectangle('Position',[SquareX, SquareY  .07 .07],'EdgeColor',case1color,'LineWidth',3,'FaceColor',colorFace2(i,:))
                text(SquareX - 0.02,SquareY - 0.05,num2str(i),'FontSize',12);
            end
        end
end
text(1,1, output,'FontSize',12);
axis([0 5 0 2])
set(gca,'LooseInset',get(gca,'TightInset'))

axis off
hold off
colorbar
    
end