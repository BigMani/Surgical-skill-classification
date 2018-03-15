% Perform HRF analysis on BU transfer task study
%
% Author: Arun Nemani

close all
clear variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEBUG ZONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
method = 3; %1 - report maximum peak value of HRFs
            %2 - report integral of HRFs
            %3 - report average value across entire HRF
            
control = 'Transfer_CTRL.mat';
FLS = 'Transfer_FLS.mat';
VBLAST = 'Transfer_VBLAST.mat';
Display = [{'1'} {'2'} {'1'} {'2'} {'1'} {'0'}];
crossVDisplay = [{'0'} {'0'} {'0'} {'0'} {'0'} {'1'}];
BrainRegions = [1,2,3,5,8];
withScore = 0;
drawBoxplots = 1;
habituationPlots = 0;
changeDirection = 0;
%%%%%%%%%%%%%%%%

% Initializations
C = load(control);
F = load(FLS);
V = load(VBLAST);
C_fields = fields(C);
F_fields = fields(F);
V_fields = fields(V);

switch (isstruct(C.(char(C_fields(1)))))
    case 1
        Control_HRFs = C.(char(C_fields(1)));
        TransferControl_score = C.(char(C_fields(2)));
        
    otherwise
        TransferControl_score = C.(char(C_fields(1)));
        Control_HRFs = C.(char(C_fields(2)));
end

switch (isstruct(F.(char(F_fields(1)))))
    case 1
        FLS_HRFs = F.(char(F_fields(1)));
        TransferFLS_score = F.(char(F_fields(2)));
        
    otherwise
        TransferFLS_score = F.(char(F_fields(1)));
        FLS_HRFs = F.(char(F_fields(2)));
end

switch (isstruct(V.(char(V_fields(1)))))
    case 1
        VBLAST_HRFs = V.(char(V_fields(1)));
        TransferVBLAST_score = V.(char(V_fields(2)));
        
    otherwise
        TransferVBLAST_score = V.(char(V_fields(1)));
        VBLAST_HRFs = V.(char(V_fields(2)));
end

C_subjects = fields(Control_HRFs);
F_subjects = fields(FLS_HRFs);
V_subjects = fields(VBLAST_HRFs);

Controldata = zeros(length(C_subjects),8);
for i=1:length(C_subjects) 
    name = char(C_subjects(i));
    Temp = zeros(31,1);
    for j = 1:32
        if method == 1
            [aa,~] = HRF_LocalMaxima(Control_HRFs.(name).data(:,j));
            Temp(j,1) = max(aa);
        elseif method ==2
            Temp(j,1) = HRF_Integral(Control_HRFs.(name).time,Control_HRFs.(name).data(:,j));
        else
            Temp(j,1) = HRF_Avg(Control_HRFs.(name).data(:,j));
        end
    end
    g(1,1) = nanmean(Temp(1:2,:));
    g(1,2) = nanmean(Temp(4:5,:));
    g(1,3) = nanmean(Temp(7:8,:));
    g(1,4) = nanmean(Temp(10:13,:));
    g(1,5) = nanmean(Temp(15:18,:));
    g(1,6) = nanmean(Temp(20:23,:));
    g(1,7) = nanmean(Temp(25:28,:));
    g(1,8) = nanmean(Temp(30:32,:));
    Controldata(i,:) = g;
end

FLSdata = zeros(length(F_subjects),8);
for i=1:length(F_subjects) 
    name = char(F_subjects(i));
    Temp2 = zeros(31,1);
    for j = 1:32
        if method == 1
            [aa,~] = HRF_LocalMaxima(FLS_HRFs.(name).data(:,j));
            Temp2(j,1) = max(aa);
        elseif method ==2
            Temp2(j,1) = HRF_Integral(FLS_HRFs.(name).time,FLS_HRFs.(name).data(:,j));
        else
            Temp2(j,1) = HRF_Avg(FLS_HRFs.(name).data(:,j));
        end
    end
    g2(1,1) = nanmean(Temp2(1:2,:));
    g2(1,2) = nanmean(Temp2(4:5,:));
    g2(1,3) = nanmean(Temp2(7:8,:));
    g2(1,4) = nanmean(Temp2(10:13,:));
    g2(1,5) = nanmean(Temp2(15:18,:));
    g2(1,6) = nanmean(Temp2(20:23,:));
    g2(1,7) = nanmean(Temp2(25:28,:));
    g2(1,8) = nanmean(Temp2(30:32,:));
    FLSdata(i,:) = g2;
    
end

VBLASTdata = zeros(length(V_subjects),8);
for i=1:length(V_subjects) 
    name = char(V_subjects(i));
    Temp3 = zeros(31,1);
    for j = 1:32
        if method == 1
            [aa,~] = HRF_LocalMaxima(VBLAST_HRFs.(name).data(:,j));
            Temp3(j,1) = max(aa);
        elseif method ==2
            Temp3(j,1) = HRF_Integral(VBLAST_HRFs.(name).time,FLS_HRFs.(name).data(:,j));
        else
            Temp3(j,1) = HRF_Avg(VBLAST_HRFs.(name).data(:,j));
        end
    end
    g3(1,1) = nanmean(Temp3(1:2,:));
    g3(1,2) = nanmean(Temp3(4:5,:));
    g3(1,3) = nanmean(Temp3(7:8,:));
    g3(1,4) = nanmean(Temp3(10:13,:));
    g3(1,5) = nanmean(Temp3(15:18,:));
    g3(1,6) = nanmean(Temp3(20:23,:));
    g3(1,7) = nanmean(Temp3(25:28,:));
    g3(1,8) = nanmean(Temp3(30:32,:));
    VBLASTdata(i,:) = g3;
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove large outliers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:8
   %Controldata(:,i) = deleteoutliers(Controldata(:,i),.05,1);
   %FLSdata(:,i) = deleteoutliers(FLSdata(:,i),.05,1);
   %VBLASTdata(:,i) = deleteoutliers(VBLASTdata(:,i),.05,1);
end

titles_2 = {'Left Lateral PFC';
'Medial PFC';
'Right Lateral PFC';
'Left Lateral M1';
'Left Medial M1';
'Right Medial M1';
'Right Lateral M1';
'SMA'};

group = [repmat({'Control'}, size(Controldata,1), 1); repmat({'FLS'}, size(FLSdata,1), 1)];%;repmat({'VBLAST'}, size(VBLASTdata,1), 1)];
for i = 1:9
    h1 = subplot(3,3,i);
    switch (i==9)
        case 0
            [p,~] = ttest2(Controldata(:,i),FLSdata(:,i));
            p = floor(p*1000)/1000;
            if p<0.05
                pp = '*';
            else
                pp = 'n.s.';
            end
            boxplot([Controldata(:,i);FLSdata(:,i)],group);%;VBLASTdata(:,i)],group)
            a = get(get(gca,'children'),'children');   % Get the handles of all the objects
            t = get(a,'tag');   % List the names of all the objects 
            box1 = a(6);   % Control median line
            set(box1,'LineWidth',2, 'Color', 'k');
            box2 = a(5);   % FLS median line
            set(box2,'LineWidth',2, 'Color', 'k');
            box3 = a(4);   % VBLAST median line
            set(box3,'LineWidth',2, 'Color', 'k');
            box4 = a(9);   % Control box
            set(box4,'LineWidth',2, 'Color', 'b');
            box5 = a(8);   % FLS box
            set(box5,'LineWidth',2, 'Color', 'r');
            box6 = a(7);   % VBLAST box
            set(box6,'LineWidth',2, 'Color', 'm');
            
            ppos = get(h1,'pos');
            ppos(3) = ppos(3) + 0.01;
            set(h1,'pos',ppos);
            set(gca,'XTickLabel',{' '});
            set(gca,'FontSize',18)
            text(.5,.9,pp,'Units','normalized','FontName','Times New Roman','FontSize',22,'HorizontalAlignment','center');
            title(titles_2(i),'FontName','Times New Roman','FontSize', 20);
            if (i==1)
                ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',22)
                set(gca,'XTickLabel',{'Control','FLS','VBLAST'});
            end
%             if i>6
%                 ylim([-3 2]);
%             else
%             ylim([-3 2]);
%             end
        otherwise
            figure
            ylim auto

            group = [repmat({'FLS'}, size(TransferFLS_score(:,1),1), 1);repmat({'Control'}, size(TransferControl_score(:,1),1), 1); repmat({'VBLaST'}, size(TransferVBLAST_score(:,1),1), 1)];
            boxplot([TransferFLS_score(:,3)/60;TransferControl_score(:,3)/60;TransferVBLAST_score(:,3)/60],group)
            a = get(get(gca,'children'),'children');   % Get the handles of all the objects
            t = get(a,'tag');   % List the names of all the objects 
            box1 = a(6);   % Control median line
            set(box1,'LineWidth',2, 'Color', 'k');
            box2 = a(5);   % FLS median line
            set(box2,'LineWidth',2, 'Color', 'k');
            box3 = a(4);   % VBLAST median line
            set(box3,'LineWidth',2, 'Color', 'k');
            box4 = a(8);   % Control box
            set(box4,'LineWidth',2, 'Color', 'g');
            box5 = a(9);   % FLS box
            set(box5,'LineWidth',2, 'Color', 'm');
            box6 = a(7);   % VBLAST box
            set(box6,'LineWidth',2, 'Color', 'b');
            ppos = get(h1,'pos');
            ppos(3) = ppos(3) + 0.01;
            set(h1,'pos',ppos);
            set(gca,'FontSize',18)
            
            p = ranksum(TransferControl_score(:,3)/60,TransferFLS_score(:,3)/60);
            p = floor(p*1000)/1000;
            if p<0.05
                pp = '*';
            else
                pp = 'n.s.';
            end
            text(.33,.9,pp,'Units','normalized','FontName','Times New Roman','FontSize',22,'HorizontalAlignment','center');
            ylabel('Transfer task completion (min)','FontName','Times New Roman','FontSize',22)
            
            P = ranksum(TransferControl_score(:,3),TransferVBLAST_score(:,3));
            P = floor(P*1000)/1000;
            if P<0.05
                PP = '*';
            else
                PP = 'n.s.';
            end
            text(.66,.9,PP,'Units','normalized','FontName','Times New Roman','FontSize',22,'HorizontalAlignment','center');
            end
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Classification
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Control vs FLS

LDAData    = ReadDatabyRegion(Controldata,FLSdata,TransferControl_score(:,3), TransferFLS_score(:,3),BrainRegions,withScore);
LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
PlotResults(LDAModel,LDAData,Display,changeDirection);
LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);

% Control vs VBLAST

LDAData    = ReadDatabyRegion(Controldata,VBLASTdata,TransferControl_score(:,3), TransferVBLAST_score(:,3),BrainRegions,withScore);
LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
PlotResults(LDAModel,LDAData,Display,changeDirection);
LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);