function void = plotTransferTask(method)
load('CTRL_Learning_HRF.mat');
load('FLS_FINAL_HRF.mat');
load('VBLAST_FINAL_HRF.mat');

%close all
%method = 1;
group = {'Pre', 'Final'};

Fnames = fields(FLS_FINAL_HRF);
Fnames2 = fields(CTRL_Learning_HRF);
Fnames3 = fields(VBLAST_FINAL_HRF);
titles = {'Local Maxima Activation in HRF - Left Lateral PFC','Local Maxima Activation in HRF - Medial PFC','Local Maxima Activation in HRF - Right Lateral PFC','Local Maxima Activation in HRF - Left Lateral M1','Local Maxima Activation in HRF - Left Medial M1','Local Maxima Activation in HRF - Right Medial M1','Local Maxima Activation in HRF - Right Lateral M1','Local Maxima Activation in HRF - SMA';
          'HRF Integral - Left Lateral PFC','HRF Integral - Medial PFC','HRF Integral - Right Lateral PFC','HRF Integral - Left Lateral M1','HRF Integral - Left Medial M1','HRF Integral - Right Medial M1','HRF Integral - Right Lateral M1','HRF Integral - SMA';
          'Mean Activation in HRF - Left Lateral PFC','Mean Activation in HRF - Medial PFC','Mean Activation in HRF - Right Lateral PFC','Mean Activation in HRF - Left Lateral M1','Mean Activation in HRF - Left Medial M1','Mean Activation in HRF - Right Medial M1','Mean Activation in HRF - Right Lateral M1','Mean Activation in HRF - SMA'};

finaldata = zeros(length(Fnames),8);
for i=1:length(Fnames) 
    name = char(Fnames(i));
    Temp = zeros(31,1);
    for j = 1:32
        if method == 1
            [aa,~] = HRF_LocalMaxima(FLS_FINAL_HRF.(name).data(:,j));
            Temp(j,1) = max(aa);
        elseif method ==2
            Temp(j,1) = HRF_Integral(FLS_FINAL_HRF.(name).time(:,j),FLS_FINAL_HRF.(name).data(:,j));
        else
            Temp(j,1) = HRF_Avg(FLS_FINAL_HRF.(name).data(:,j));
        end
    end
    g(1,1) = nanmean(Temp(1:2,:));
    g(1,2) = nanmean(Temp(4:5,:));
    g(1,3) = nanmean(Temp(7:8,:));
    g(1,4) = nanmean(Temp(10:13,:));
    g(1,5) = nanmean(Temp(15:18,:));
    g(1,6) = nanmean(Temp(20:23,:));
    g(1,7) = nanmean(Temp(25:28,:));
    g(1,8) = nanmean(Temp(29:31,:));
    finaldata(i,:) = g;
end

for i=1:length(Fnames2) 
    name = char(Fnames2(i));
    Temp2 = zeros(31,1);
    for j = 1:32
        if method == 1
            [aa,~] = HRF_LocalMaxima(CTRL_Learning_HRF.(name).data(:,j));
            Temp2(j,1) = max(aa);
        elseif method ==2
            Temp2(j,1) = HRF_Integral(CTRL_Learning_HRF.(name).time(:,j),CTRL_Learning_HRF.(name).data(:,j));
        else
            Temp2(j,1) = HRF_Avg(CTRL_Learning_HRF.(name).data(:,j));
        end
    end
    g2(1,1) = nanmean(Temp2(1:2,:));
    g2(1,2) = nanmean(Temp2(4:5,:));
    g2(1,3) = nanmean(Temp2(7:8,:));
    g2(1,4) = nanmean(Temp2(10:13,:));
    g2(1,5) = nanmean(Temp2(15:18,:));
    g2(1,6) = nanmean(Temp2(20:23,:));
    g2(1,7) = nanmean(Temp2(25:28,:));
    g2(1,8) = nanmean(Temp2(29:31,:));
    finaldata2(i,:) = g2;
end

for i=1:length(Fnames3) 
    name = char(Fnames3(i));
    Temp3 = zeros(31,1);
    for j = 1:32
        if method == 1
            [aa,~] = HRF_LocalMaxima(VBLAST_FINAL_HRF.(name).data(:,j));
            Temp3(j,1) = max(aa);
        elseif method ==2
            Temp3(j,1) = HRF_Integral(VBLAST_FINAL_HRF.(name).time(:,j),VBLAST_FINAL_HRF.(name).data(:,j));
        else
            Temp3(j,1) = HRF_Avg(VBLAST_FINAL_HRF.(name).data(:,j));
        end
    end
    g3(1,1) = nanmean(Temp3(1:2,:));
    g3(1,2) = nanmean(Temp3(4:5,:));
    g3(1,3) = nanmean(Temp3(7:8,:));
    g3(1,4) = nanmean(Temp3(10:13,:));
    g3(1,5) = nanmean(Temp3(15:18,:));
    g3(1,6) = nanmean(Temp3(20:23,:));
    g3(1,7) = nanmean(Temp3(25:28,:));
    g3(1,8) = nanmean(Temp3(29:31,:));
    finaldata3(i,:) = g3;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualize results
FLS.FinalFLS = finaldata([1,4,6,9,13,15,18],:);
FLS.FinalReal = finaldata([2,5,7,10,11,14,16,19],:);
FLS.FinalVBLAST = finaldata([3,8,12,17,20],:);
FLS.FinalFLS(8,:) = NaN;
FLS.FinalVBLAST(6:8,:) = NaN;

VBLAST.FinalFLS = finaldata3([1,4,7,10,13,16],:);
VBLAST.FinalReal = finaldata3([2,5,8,11,14,17],:);
VBLAST.FinalVBLAST = finaldata3([3,6,9,12,15,18],:);
VBLAST.FinalFLS(7:8,:) = NaN;
VBLAST.FinalReal(7:8,:) = NaN;
VBLAST.FinalVBLAST(7:8,:) = NaN;

CTRL.FinalFLS = finaldata2([1,8,13,18],:);
CTRL.FinalReal = finaldata2([2,9,14,19],:);
CTRL.FinalVBLAST = finaldata2([3,10,15,20],:);
CTRL.FinalFLS(5:8,:) = NaN;
CTRL.FinalReal(5:8,:) = NaN;
CTRL.FinalVBLAST(5:8,:) = NaN;

c = [0,0.500000000000000,0;0,0,1;1,0,0;0,0.500000000000000,0;0,0,1;1,0,0;0,0.500000000000000,0;0,0,1;1,0,0];
group = {'','FLS','','','VBLAST','','','Real',''};
titles2 = {'Left lateral PFC - Cortical activation for task retention and transfer','Medial PFC - Cortical activation for task retention and transfer','Right lateral PFC - Cortical activation for task retention and transfer','Left lateral M1 - Cortical activation for task retention and transfer','Left medial M1 - Cortical activation for task retention and transfer','Right medial M1 - Cortical activation for task retention and transfer','Right lateral M1 - Cortical activation for task retention and transfer','SMA - Cortical activation for task retention and transfer'};
for i = 1:8
    figure;
    tr1 = boxplot([FLS.FinalFLS(:,i),CTRL.FinalFLS(:,i),VBLAST.FinalFLS(:,i),FLS.FinalVBLAST(:,i),CTRL.FinalVBLAST(:,i),VBLAST.FinalVBLAST(:,i),FLS.FinalReal(:,i),CTRL.FinalReal(:,i),VBLAST.FinalReal(:,i)],'colors',c, 'labels', group);
    xhandle=get(gca,'Xlabel');
    set(xhandle,'Fontsize',15);
    ylabel('Delta HbO2 conc (mM*cm)','fontsize',14);
    legend([tr1(12),tr1(3),tr1(20)],'Control','FLS','VBLAST','Location','northwest');
    title(titles(method,i),'FontSize',15);
    
    [p,~] = ranksum(FLS.FinalFLS(:,i),CTRL.FinalFLS(:,i));
    p = floor(p*1000)/1000;
    pp = strcat('p = ',{' '},num2str(p));
    t = text(.05,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

    [p,~] = ranksum(VBLAST.FinalFLS(:,i),CTRL.FinalFLS(:,i));
    p = floor(p*1000)/1000;
    pp = strcat('p = ',{' '},num2str(p));
    t = text(.2,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

    [p,~] = ranksum(FLS.FinalVBLAST(:,i),CTRL.FinalVBLAST(:,i));
    p = floor(p*1000)/1000;
    pp = strcat('p = ',{' '},num2str(p));
    t = text(.4,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

    [p,~] = ranksum(VBLAST.FinalVBLAST(:,i),CTRL.FinalVBLAST(:,i));
    p = floor(p*1000)/1000;
    pp = strcat('p = ',{' '},num2str(p));
    t = text(.53,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

    [p,~] = ranksum(FLS.FinalReal(:,i),CTRL.FinalReal(:,i));
    p = floor(p*1000)/1000;
    pp = strcat('p = ',{' '},num2str(p));
    t = text(.73,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

    [p,~] = ranksum(VBLAST.FinalReal(:,i),CTRL.FinalReal(:,i));
    p = floor(p*1000)/1000;
    pp = strcat('p = ',{' '},num2str(p));
    t = text(.88,.05,pp,'Units','normalized','FontSize',8,'FontWeight','bold');

end