close all
clear

load('MGH_VBLAST_Novice_Coherence.mat');
load('MGH_VBLAST_Expert_Coherence.mat');
load('MGH_FLS_Novice_Coherence.mat');
load('MGH_FLS_Expert_Coherence.mat');
load('MGH_FLS_Training_Coherence.mat');
load('MGH_VBLAST_Training_Coherence.mat');
E_VBLAST = fields(MGH_VBLAST_Expert_Coherence);
N_VBLAST = fields(MGH_VBLAST_Novice_Coherence);
E_FLS = fields(MGH_FLS_Expert_Coherence);
N_FLS = fields(MGH_FLS_Novice_Coherence);
FLS = fields(MGH_FLS_Training_Coherence);
VBLAST = fields(MGH_VBLAST_Training_Coherence);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUG ZONE
flipcolormap = 0;
colortype = 'jet';
LearningSubjects = 'FLS2|FLS4|FLS6';

%END DEBUG ZONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot VBLAST Novices vs Experts
    for i = 1:size(E_VBLAST,1)
        WCO_NA_E(:,i) = MGH_VBLAST_Expert_Coherence.(char(E_VBLAST(i))).WCO_NA;
        WPCO_NA_E(:,i) = MGH_VBLAST_Expert_Coherence.(char(E_VBLAST(i))).WPCO_NA;
        WCO_Task_E(:,i) = MGH_VBLAST_Expert_Coherence.(char(E_VBLAST(i))).WCO_Task;
        WPCO_Task_E(:,i) = MGH_VBLAST_Expert_Coherence.(char(E_VBLAST(i))).WPCO_Task;
        WCO_CA_E(:,i) = MGH_VBLAST_Expert_Coherence.(char(E_VBLAST(i))).WCO_CA;
        WPCO_CA_E(:,i) = MGH_VBLAST_Expert_Coherence.(char(E_VBLAST(i))).WPCO_CA;
    end

    for i = 1:size(N_VBLAST,1)
        WCO_NA_N(:,i) = MGH_VBLAST_Novice_Coherence.(char(N_VBLAST(i))).WCO_NA;
        WPCO_NA_N(:,i) = MGH_VBLAST_Novice_Coherence.(char(N_VBLAST(i))).WPCO_NA;
        WCO_Task_N(:,i) = MGH_VBLAST_Novice_Coherence.(char(N_VBLAST(i))).WCO_Task;
        WPCO_Task_N(:,i) = MGH_VBLAST_Novice_Coherence.(char(N_VBLAST(i))).WPCO_Task;
        WCO_CA_N(:,i) = MGH_VBLAST_Novice_Coherence.(char(N_VBLAST(i))).WCO_CA;
        WPCO_CA_N(:,i) = MGH_VBLAST_Novice_Coherence.(char(N_VBLAST(i))).WPCO_CA;
    end
    
    subplot(2,3,1)
    plotConnectivity(WCO_CA_E, WCO_CA_N,'Wavelet Coherence (Cardiac activity)');
    title('VBLAST')
    subplot(2,3,2)
    plotConnectivity(WCO_NA_E, WCO_NA_N,'Wavelet Coherence (Neurogenic activity)');
    subplot(2,3,3)
    plotConnectivity(WCO_Task_E, WCO_Task_N,'Wavelet Coherence (Task)');
    subplot(2,3,4)
    plotConnectivity(WPCO_CA_E, WPCO_CA_N,'Wavelet Phase coherence (Cardiac activity)');
    subplot(2,3,5)
    plotConnectivity(WPCO_NA_E, WPCO_NA_N,'Wavelet Phase coherence (Neurogenic activity)');
    subplot(2,3,6)
    plotConnectivity(WPCO_Task_E, WPCO_Task_N,'Wavelet Phase coherence (Task)');
    
    figure
    subplot(2,3,1)
    plotBrainConnectivity(nanmean(WCO_Task_E,2), colortype, flipcolormap, 'Task WCO (f:[0.005, 0.02]) of Experts', 'Wavelet Coherence Magnitiude');
    subplot(2,3,2)
    plotBrainConnectivity(nanmean(WCO_NA_E,2), colortype, flipcolormap, 'Neurogenic activity WCO (f:[0.02, 0.05]) of Experts', 'Wavelet Coherence Magnitiude');
    subplot(2,3,3)
    plotBrainConnectivity(nanmean(WCO_CA_E,2), colortype, flipcolormap, 'Cardiac activity WCO (f:[0.6, 2]) of Experts', 'Wavelet Coherence Magnitiude');
    subplot(2,3,4)
    plotBrainConnectivity(nanmean(WCO_Task_N,2), colortype, flipcolormap, 'Task WCO (f:[0.005, 0.02]) of Novices', 'Wavelet Coherence Magnitiude');
    subplot(2,3,5)
    plotBrainConnectivity(nanmean(WCO_NA_N,2), colortype, flipcolormap, 'Neurogenic activity WCO (f:[0.02, 0.05]) of Novices', 'Wavelet Coherence Magnitiude');
    subplot(2,3,6)
    plotBrainConnectivity(nanmean(WCO_CA_N,2), colortype, flipcolormap, 'Cardiac activity WCO (f:[0.6, 2]) of Novices', 'Wavelet Coherence Magnitiude');

    figure
    subplot(2,3,1)
    plotBrainConnectivity(nanmean(WPCO_Task_E,2), colortype, flipcolormap, 'Task WPCO (f:[0.005, 0.02]) of Experts', 'Wavelet Phase Coherence Magnitiude');
    subplot(2,3,2)
    plotBrainConnectivity(nanmean(WPCO_NA_E,2), colortype, flipcolormap, 'Neurogenic activity WPCO (f:[0.02, 0.05]) of Experts', 'Wavelet Phase Coherence Magnitiude');
    subplot(2,3,3)
    plotBrainConnectivity(nanmean(WPCO_CA_E,2), colortype, flipcolormap, 'Cardiac activity WPCO (f:[0.6, 2]) of Experts', 'Wavelet Phase Coherence Magnitiude');
    subplot(2,3,4)
    plotBrainConnectivity(nanmean(WPCO_Task_N,2), colortype, flipcolormap, 'Task WPCO (f:[0.005, 0.02]) of Novices', 'Wavelet Phase Coherence Magnitiude');
    subplot(2,3,5)
    plotBrainConnectivity(nanmean(WPCO_NA_N,2), colortype, flipcolormap, 'Neurogenic activity WPCO (f:[0.02, 0.05]) of Novices', 'Wavelet Phase Coherence Magnitiude');
    subplot(2,3,6)
    plotBrainConnectivity(nanmean(WPCO_CA_N,2), colortype, flipcolormap, 'Cardiac activity WPCO (f:[0.6, 2]) of Novices', 'Wavelet Phase Coherence Magnitiude');

% Plot FLS Novices vs Experts
    for i = 1:size(E_FLS,1)
        WCO_NA_E(:,i) = MGH_FLS_Expert_Coherence.(char(E_FLS(i))).WCO_NA;
        WPCO_NA_E(:,i) = MGH_FLS_Expert_Coherence.(char(E_FLS(i))).WPCO_NA;
        WCO_Task_E(:,i) = MGH_FLS_Expert_Coherence.(char(E_FLS(i))).WCO_Task;
        WPCO_Task_E(:,i) = MGH_FLS_Expert_Coherence.(char(E_FLS(i))).WPCO_Task;
        WCO_CA_E(:,i) = MGH_FLS_Expert_Coherence.(char(E_FLS(i))).WCO_CA;
        WPCO_CA_E(:,i) = MGH_FLS_Expert_Coherence.(char(E_FLS(i))).WPCO_CA;
    end

    for i = 1:size(N_FLS,1)
        WCO_NA_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WCO_NA;
        WPCO_NA_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WPCO_NA;
        WCO_Task_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WCO_Task;
        WPCO_Task_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WPCO_Task;
        WCO_CA_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WCO_CA;
        WPCO_CA_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WPCO_CA;
    end
    
    figure
    subplot(2,3,1)
    plotConnectivity(WCO_CA_E, WCO_CA_N,'Wavelet Coherence (Cardiac activity)');
    title ('FLS')
    subplot(2,3,2)
    plotConnectivity(WCO_NA_E, WCO_NA_N,'Wavelet Coherence (Neurogenic activity)');
    subplot(2,3,3)
    plotConnectivity(WCO_Task_E, WCO_Task_N,'Wavelet Coherence (Task)');
    subplot(2,3,4)
    plotConnectivity(WPCO_CA_E, WPCO_CA_N,'Wavelet Phase coherence (Cardiac activity)');
    subplot(2,3,5)
    plotConnectivity(WPCO_NA_E, WPCO_NA_N,'Wavelet Phase coherence (Neurogenic activity)');
    subplot(2,3,6)
    plotConnectivity(WPCO_Task_E, WPCO_Task_N,'Wavelet Phase coherence (Task)');
    
    figure
    subplot(2,3,1)
    plotBrainConnectivity(nanmean(WCO_Task_E,2), colortype, flipcolormap, 'Task WCO (f:[0.005, 0.02]) of Experts', 'Wavelet Coherence Magnitiude');
    subplot(2,3,2)
    plotBrainConnectivity(nanmean(WCO_NA_E,2), colortype, flipcolormap, 'Neurogenic activity WCO (f:[0.02, 0.05]) of Experts', 'Wavelet Coherence Magnitiude');
    subplot(2,3,3)
    plotBrainConnectivity(nanmean(WCO_CA_E,2), colortype, flipcolormap, 'Cardiac activity WCO (f:[0.6, 2]) of Experts', 'Wavelet Coherence Magnitiude');
    subplot(2,3,4)
    plotBrainConnectivity(nanmean(WCO_Task_N,2), colortype, flipcolormap, 'Task WCO (f:[0.005, 0.02]) of Novices', 'Wavelet Coherence Magnitiude');
    subplot(2,3,5)
    plotBrainConnectivity(nanmean(WCO_NA_N,2), colortype, flipcolormap, 'Neurogenic activity WCO (f:[0.02, 0.05]) of Novices', 'Wavelet Coherence Magnitiude');
    subplot(2,3,6)
    plotBrainConnectivity(nanmean(WCO_CA_N,2), colortype, flipcolormap, 'Cardiac activity WCO (f:[0.6, 2]) of Novices', 'Wavelet Coherence Magnitiude');

    figure
    subplot(2,3,1)
    plotBrainConnectivity(nanmean(WPCO_Task_E,2), colortype, flipcolormap, 'Task WPCO (f:[0.005, 0.02]) of Experts', 'Wavelet Phase Coherence Magnitiude');
    subplot(2,3,2)
    plotBrainConnectivity(nanmean(WPCO_NA_E,2), colortype, flipcolormap, 'Neurogenic activity WPCO (f:[0.02, 0.05]) of Experts', 'Wavelet Phase Coherence Magnitiude');
    subplot(2,3,3)
    plotBrainConnectivity(nanmean(WPCO_CA_E,2), colortype, flipcolormap, 'Cardiac activity WPCO (f:[0.6, 2]) of Experts', 'Wavelet Phase Coherence Magnitiude');
    subplot(2,3,4)
    plotBrainConnectivity(nanmean(WPCO_Task_N,2), colortype, flipcolormap, 'Task WPCO (f:[0.005, 0.02]) of Novices', 'Wavelet Phase Coherence Magnitiude');
    subplot(2,3,5)
    plotBrainConnectivity(nanmean(WPCO_NA_N,2), colortype, flipcolormap, 'Neurogenic activity WPCO (f:[0.02, 0.05]) of Novices', 'Wavelet Phase Coherence Magnitiude');
    subplot(2,3,6)
    plotBrainConnectivity(nanmean(WPCO_CA_N,2), colortype, flipcolormap, 'Cardiac activity WPCO (f:[0.6, 2]) of Novices', 'Wavelet Phase Coherence Magnitiude');

    % Plot VBLAST Learning students
    for i = 1:size(VBLAST,1)
        WCO_NA_E(:,i) = MGH_FLS_Expert_Coherence.(char(VBLAST(i))).WCO_NA;
        WPCO_NA_E(:,i) = MGH_FLS_Expert_Coherence.(char(VBLAST(i))).WPCO_NA;
        WCO_Task_E(:,i) = MGH_FLS_Expert_Coherence.(char(VBLAST(i))).WCO_Task;
        WPCO_Task_E(:,i) = MGH_FLS_Expert_Coherence.(char(VBLAST(i))).WPCO_Task;
        WCO_CA_E(:,i) = MGH_FLS_Expert_Coherence.(char(VBLAST(i))).WCO_CA;
        WPCO_CA_E(:,i) = MGH_FLS_Expert_Coherence.(char(VBLAST(i))).WPCO_CA;
    end

    for i = 1:size(N_FLS,1)
        WCO_NA_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WCO_NA;
        WPCO_NA_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WPCO_NA;
        WCO_Task_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WCO_Task;
        WPCO_Task_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WPCO_Task;
        WCO_CA_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WCO_CA;
        WPCO_CA_N(:,i) = MGH_FLS_Novice_Coherence.(char(N_FLS(i))).WPCO_CA;
    end
function plotConnectivity(Data_E, Data_N,Label)
    Data_E = Data_E';
    Data_N = Data_N';
    Data_E(Data_E==0) = NaN;
    Data_N(Data_E==0) = NaN;
    Data = [];
    Group = [];
    ColorGroup = [];
    idx = 0;
    for i = 1:10
        Data = [Data;Data_E(:,i);Data_N(:,i);NaN;];
        ColorGroup = [ColorGroup; repmat('E',size(Data_E,1),1);repmat('N',size(Data_N,1),1);'C'];
        idx = idx+1;
        Group = [Group;repmat(idx,size(Data_E,1),1)];
        idx = idx+1;
        Group = [Group;repmat(idx,size(Data_N,1),1)];
        idx = idx+1;
        Group = [Group;repmat(idx,1,1)];
    end
    boxplot(Data,Group,'colorgroup',ColorGroup,'colors',[1 0 0; 0 0 1;0 0 0],'medianstyle', 'line');
    set(gca,'XTickLabel',{'','LPFC-CPFC','','','LPFC-RPFC','','','LPFC-SMA','','','LPFC-LMM1','','','CPFC-RPFC','','','CPFC-SMA','','','CPFC-LMM1','','','RPFC-SMA','','','RPFC-LMM1','','','SMA-LMM1','',},'FontSize',16)
    xtickangle(gca,90)
    for i = 1:10
        [~,ptext] = sigStar(Data_E(:,i),Data_N(:,i),'ranksum');
        text((i*.1)-0.05,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    end
    ylabel(Label,'FontSize',18,'Rotation',90);
    ylim([0 1.2])
end

function plotBrainConnectivity(data, Type, flipmap,Plottitle, Colorlabel)
    thresh = 0; % full spectrum
    if (strcmpi(Type,'jet'))
        if flipmap
            colors = flipud(jet(256-thresh));
        else
            colors = jet(256-thresh);
        end
    elseif (strcmpi(Type,'gray'))
        if flipmap
            colors = flipud(gray(256-thresh));
        else
            colors = gray(256-thresh);
        end
    elseif (strcmpi(Type,'summer'))
        if flipmap
            colors = flipud(summer(256-thresh));
        else
            colors = summer(256-thresh);
        end
    elseif (strcmpi(Type,'hot'))
        if flipmap
            colors = flipud(hot(256-thresh));
        else
            colors = hot(256-thresh);
        end
    elseif (strcmpi(Type,'cool'))
        if flipmap
            colors = flipud(cool(256-thresh));
        else
            colors = cool(256-thresh);
        end
    elseif (strcmpi(Type,'parula'))
        if flipmap
            colors = flipud(parula(256-thresh));
        else
            colors = parula(256-thresh);
        end
    else
        disp('invalid color scheme')
        return
    end

    colors = [ones(thresh,3);colors];
    colormap(colors)
    
    
    MCEcolors = round(data*256);
    MCEcolors(~MCEcolors) = 1;
    Brain = imread('BrainTopView.jpg');
    imshow(Brain)
    radius = 40;
    CPFCcentroid = [470 70];
    LPFCcentroid = [240 120];
    RPFCcentroid = [700 120];
    LMM1centroid = [300 640];
    SMAcentroid = [470 520];
    Linethickness = 4;
    
    hold on
    plot([LPFCcentroid(1) CPFCcentroid(1)], [LPFCcentroid(2) CPFCcentroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(1),:))
    plot([LPFCcentroid(1) RPFCcentroid(1)], [LPFCcentroid(2) RPFCcentroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(2),:))
    plot([LPFCcentroid(1) SMAcentroid(1)],  [LPFCcentroid(2) SMAcentroid(2)], 'LineWidth', Linethickness, 'Color', colors(MCEcolors(3),:))
    plot([LPFCcentroid(1) LMM1centroid(1)], [LPFCcentroid(2) LMM1centroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(4),:))
  
    plot([CPFCcentroid(1) RPFCcentroid(1)], [CPFCcentroid(2) RPFCcentroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(5),:))
    plot([CPFCcentroid(1) SMAcentroid(1)],  [CPFCcentroid(2) SMAcentroid(2)], 'LineWidth', Linethickness, 'Color', colors(MCEcolors(6),:))
    plot([CPFCcentroid(1) LMM1centroid(1)], [CPFCcentroid(2) LMM1centroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(7),:))
    
    plot([RPFCcentroid(1) SMAcentroid(1)],  [RPFCcentroid(2) SMAcentroid(2)], 'LineWidth', Linethickness, 'Color', colors(MCEcolors(8),:))
    plot([RPFCcentroid(1) LMM1centroid(1)], [RPFCcentroid(2) LMM1centroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(9),:))
    
    plot([SMAcentroid(1)  LMM1centroid(1)], [SMAcentroid(2)  LMM1centroid(2)],'LineWidth', Linethickness, 'Color', colors(MCEcolors(10),:))
    

    rectangle('Position',[LPFCcentroid(1)-radius LPFCcentroid(2)-radius 2*radius 2*radius],'Curvature',[1 1],'FaceColor',[1 1 1]) 
    rectangle('Position',[CPFCcentroid(1)-radius CPFCcentroid(2)-radius 2*radius 2*radius],'Curvature',[1 1],'FaceColor',[1 1 1])
    rectangle('Position',[RPFCcentroid(1)-radius RPFCcentroid(2)-radius 2*radius 2*radius],'Curvature',[1 1],'FaceColor',[1 1 1])
    rectangle('Position',[LMM1centroid(1)-radius LMM1centroid(2)-radius 2*radius 2*radius],'Curvature',[1 1],'FaceColor',[1 1 1])
    rectangle('Position',[SMAcentroid(1)-radius SMAcentroid(2)-radius 2*radius 2*radius],'Curvature',[1 1],'FaceColor',[1 1 1])
    text(LPFCcentroid(1),LPFCcentroid(2),'LPFC','HorizontalAlignment','center','FontSize',7,'FontWeight','bold')
    text(CPFCcentroid(1),CPFCcentroid(2),'CPFC','HorizontalAlignment','center','FontSize',7,'FontWeight','bold')
    text(RPFCcentroid(1),RPFCcentroid(2),'RPFC','HorizontalAlignment','center','FontSize',7,'FontWeight','bold')
    text(LMM1centroid(1),LMM1centroid(2),'LMM1','HorizontalAlignment','center','FontSize',7,'FontWeight','bold')
    text(SMAcentroid(1), SMAcentroid(2),'SMA','HorizontalAlignment','center','FontSize',7,'FontWeight','bold')
    

    title(Plottitle, 'FontSize', 14);
    h = colorbar;
    ylabel(h, Colorlabel, 'Rotation', 90, 'FontSize', 12)
    hold off
end

function plotCoherence(freq, Waveletout, Ylabel, AxisType)
    figure
    semilogx(freq,Waveletout,'LineWidth',2);
     if(AxisType == 1)
        New_XTickLabel = get(gca,'xtick');
        set(gca,'XTickLabel',New_XTickLabel);
        set(gca,'FontSize',12)
        xlabel('Frequency (Hz)')
        ylabel(Ylabel);
     elseif(AxisType == 2)
        min_x = min(freq);
        max_x = max(freq);
        most_sig_position_min = 10^floor((log10(min_x)));
        most_sig_digit_min = floor(min_x / most_sig_position_min);
        min_xaxis = most_sig_digit_min * most_sig_position_min;
        most_sig_position_max = 10^floor((log10(max_x)));
        most_sig_digit_max = ceil(max_x / most_sig_position_max);
        max_xaxis = most_sig_digit_max * most_sig_position_max;
        p(1) = ceil(log10(min_xaxis));
        p(2) = ceil(log10(max_xaxis));
        ticks = [];
        for k=p(1):p(2)
            if k==p(1)
                ticks = [ticks min_xaxis:10^(k-1):10^k];
            elseif k==p(2)
                ticks = [ticks 10^(k-1)+10^(k-1):10^(k-1):max_xaxis];
            else
                ticks = [ticks 10^(k-1)+10^(k-1):10^(k-1):10^k];
            end
        end
        set(gca,'xtick',ticks())
        set(gca,'FontSize',10)
        xtickangle(90);
        axis([min_xaxis max_xaxis -inf inf])
        xlabel('Frequency (Hz)')
        ylabel(Ylabel);
     end
end
