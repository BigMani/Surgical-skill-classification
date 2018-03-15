% function BU_Transfer_Analysis_v2()
% Perform differentiation and classification on UB transfer data
% Author: Arun Nemani

    % DEBUG ZONE
    % ---------------------------------------------------------------------
    %clear
    close all
    CTRL = 'Transfer_CTRL_2.mat';
    FLS = 'Transfer_FLS_2.mat';
    VBLAST = 'Transfer_VBLAST_2.mat';
    Display = [{'1'} {'1'} {'0'} {'1'} {'1'} {'2'}];
    crossVDisplay = [{'0'} {'0'} {'0'} {'0'} {'0'} {'1'}];
    global PDFxlabel;
    BrainRegions = [];
    withScore = 1;
    method = 3;
    changeDirection = 0;
    PDFxlabel = 'LDA projected scores of fNIRS metrics';
    MCEPlotsLabel = {'FLS score','SMA only','LMM1 only','PFC only','LMM1 + SMA','PFC + LMM1','PFC + SMA','PFC + LMM1 + SMA'};
    % END DEBUG ZONE
    % ---------------------------------------------------------------------
    
    [CTRLdata, CTRLscore, FLSdata, FLSscore, VBLASTdata, VBLASTscore] = ReadData_Transfer(CTRL, FLS, VBLAST, method);
    %[FLSscores, FLSlabel, VBLASTscores, VBLASTlabel] = plotFinalScores();
    drawTransferScore(CTRLscore, FLSscore, VBLASTscore);
    drawTransferNIRS(CTRLdata, FLSdata, VBLASTdata);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % LDA on transfer task
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    LDAData = ReadDatabyRegion(CTRLdata, FLSdata, CTRLscore, FLSscore, BrainRegions, withScore);
    LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
    PlotResults(LDAModel,LDAData,Display,changeDirection);
    legend('FLS group distribution','FLS group trials','Control group distribution','Control group trials');
    LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
    PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
    
    if (changeDirection==1)
        CVMCE = 100*sum((1-LDACVModel.pValueTypeII)<0.10)/size(LDACVModel.pValueTypeII,2);
    else
        CVMCE = 100*sum(LDACVModel.pValueTypeII<0.10)/size(LDACVModel.pValueTypeII,2);
    end
%             
    ylim ([0 1])
    LDAData = ReadDatabyRegion(CTRLdata, VBLASTdata,CTRLscore, VBLASTscore, BrainRegions, withScore);
    LDAModel   = FDA(LDAData.X,LDAData.K,1,'standardlinearFDA');
    PlotResults(LDAModel,LDAData,Display,changeDirection);
    legend('VBLAST transfer PDF','VBLAST transfer trials','Control transfer PDF','Control transfer trials');
    LDACVModel   = FDA(LDAData.X,LDAData.K,1,'cross_validation');
    PlotResults(LDACVModel,LDAData, crossVDisplay,changeDirection);
    if (changeDirection==1)
        CVMCE = 100*sum((1-LDACVModel.pValueTypeII)<0.1)/size(LDACVModel.pValueTypeII,2);
    else
        CVMCE = 100*sum(LDACVModel.pValueTypeII<0.1)/size(LDACVModel.pValueTypeII,2);
    end
    ylim ([0 1])

function [FLSscores, FLSlabel, VBLASTscores, VBLASTlabel] = plotFinalScores()
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot by day (FLS)
    %%%%%%%%%%%%%%%%%%%%%%%%%
    FLSscore = [];
    LabelGroup = [];
    ColorGroup = [];

    %Strucutre CTRL pre test scores
    s = [38;84;44;34;57;79;55;30;54;0;10;85;0;0;0;0];
    LabelGroup = [LabelGroup;repmat({'Control pre-test'},size(s,1),1)];
    ColorGroup = [ColorGroup;repmat({'C'},size(s,1),1)];
    FLSscore = [FLSscore;s];
    
    %Strucutre FLS learning
    s = [0;0;0;0;0;0;110;122;71;0;3;38;68;0;20;0;0;0;0;40;116;70;44;0;20;0;0;0;0;0;0;0;0];
    LabelGroup = [LabelGroup;repmat({'FLS pre-test'},size(s,1),1)];
    ColorGroup = [ColorGroup;repmat({'F'},size(s,1),1)];
    FLSscore = [FLSscore;s];
    
    %Structure break
    s = NaN;
    LabelGroup = [LabelGroup;' '];
    ColorGroup = [ColorGroup;repmat({'C'},size(s,1),1)];
    FLSscore = [FLSscore;s];

    %Structure FLS final
    s = [192;194;187;219;227;206;191;236;237;211;228;230;222;229;237;222;223;229;235;244;246;222;245;250];
    LabelGroup = [LabelGroup;repmat({'FLS post-test'},size(s,1),1)];
    ColorGroup = [ColorGroup;repmat({'F'},size(s,1),1)];
    FLSscore = [FLSscore;s];

    %Structure CTRL final
    s = [87;94;60;57;99;128;54;67;106;63];
    LabelGroup = [LabelGroup;repmat({'Control post-test'},size(s,1),1)];
    ColorGroup = [ColorGroup;repmat({'C'},size(s,1),1)];
    FLSscore = [FLSscore;s];

    %Structure VBLAST final
    s = [105;85;130;78;80;84;138;108;158;109;131];
    LabelGroup = [LabelGroup;repmat({'VBLaST post-test'},size(s,1),1)];
    ColorGroup = [ColorGroup;repmat({'V'},size(s,1),1)];
    FLSscore = [FLSscore;s];
    FLSscores = FLSscore;
    FLSlabel = LabelGroup;
    
    figure
    boxplot(FLSscore,LabelGroup,'colorgroup',ColorGroup,'colors',[[0 176 80]/256; [91 155 213]/256; [237 125 49]/256],'medianstyle', 'line', 'Symbol', 'ro');
    ylim([-20 275]);
    set(gca,'xtick',[mean((1:2)) mean((5)) ])
    set(gca,'xticklabel',{'Pre-test','Post-test'})
    set(gca,'FontSize',14)
    set(findobj('Tag','Box'),'LineWidth',2);
    set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
    set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
    ylabel('FLS performance scores','FontName','Times New Roman','FontSize',18,'interpreter','tex')
    [~,ptext] = sigStar(FLSscore(strcmpi(LabelGroup,'Control pre-test')),FLSscore(strcmpi(LabelGroup,'FLS pre-test')),'ranksum');
    text(.17,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',20,'HorizontalAlignment','center');
    [~,ptext] = sigStar(FLSscore(strcmpi(LabelGroup,'Control post-test')),FLSscore(strcmpi(LabelGroup,'FLS post-test')),'ranksum');
    text(.67,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',20,'HorizontalAlignment','center');
    [~,ptext] = sigStar(FLSscore(strcmpi(LabelGroup,'Control post-test')),FLSscore(strcmpi(LabelGroup,'VBLAST post-test')),'ranksum');
    text(.83,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',20,'HorizontalAlignment','center');
    L = findall(gca,'Tag','Box');
    
    legend([L([2,3]);L(1)], {'Untrained Control','Trained FLS','Trained VBLaST'},'Location','Southeast');
    %set(gca, 'XTickLabelRotation', 45)

    %%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot by day (VBLAST)
    %%%%%%%%%%%%%%%%%%%%%%%%%
    FLSscore = [];
    LabelGroup = [];
    ColorGroup = [];

    %Strucutre CTRL pre test scores
    s = [116;115;103;112;120;0;0;121;122;154;140;98];
    LabelGroup = [LabelGroup;repmat({'Control pre-test'},size(s,1),1)];
    ColorGroup = [ColorGroup;repmat({'C'},size(s,1),1)];
    FLSscore = [FLSscore;s];
    
    %Strucutre VBLAST
    s = [43;81;56;135;12;89;136;116;111;135;157;175;188;198;199;70;118;129;109;116;118;149;183;195;258;222];
    LabelGroup = [LabelGroup;repmat({'VBLAST pre-test'},size(s,1),1)];
    ColorGroup = [ColorGroup;repmat({'V'},size(s,1),1)];
    FLSscore = [FLSscore;s];
    
    %Structure break
    s = NaN;
    LabelGroup = [LabelGroup;' '];
    ColorGroup = [ColorGroup;repmat({'C'},size(s,1),1)];
    FLSscore = [FLSscore;s];

    %Structure FLS final
    s = [137;145;185;159;213;213;187;167;192;177;164;159;149;187;168;161;195;221;119;184;198];
    LabelGroup = [LabelGroup;repmat({'FLS post-test'},size(s,1),1)];
    ColorGroup = [ColorGroup;repmat({'F'},size(s,1),1)];
    FLSscore = [FLSscore;s];

    %Structure CTRL final
    s = [133;163;180;132;163;175;134;123;146;159;163;189];
    LabelGroup = [LabelGroup;repmat({'Control post-test'},size(s,1),1)];
    ColorGroup = [ColorGroup;repmat({'C'},size(s,1),1)];
    FLSscore = [FLSscore;s];

    %Structure VBLAST final
    s = [193;186;180;188;199;207;183;229;223;196;195;212;216;217;217;236;242;250];
    LabelGroup = [LabelGroup;repmat({'VBLaST post-test'},size(s,1),1)];
    ColorGroup = [ColorGroup;repmat({'V'},size(s,1),1)];
    FLSscore = [FLSscore;s];
    VBLASTscores = FLSscore;
    VBLASTlabel = LabelGroup;

    figure
    boxplot(FLSscore,LabelGroup,'colorgroup',ColorGroup,'colors',[[0 176 80]/256; [237 125 49]/256; [91 155 213]/256;  ],'medianstyle', 'line','Symbol', 'ro');
    ylim([-20 275]);
    set(gca,'xtick',[mean((1:2)) mean((5)) ])
    set(gca,'xticklabel',{'Pre-test','Post-test'})
    set(gca,'FontSize',14)
    set(findobj('Tag','Box'),'LineWidth',2);
    set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
    set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
    ylabel('VBLaST performance scores','FontName','Times New Roman','FontSize',18,'interpreter','tex')
    [~,ptext] = sigStar(FLSscore(strcmpi(LabelGroup,'Control pre-test')),FLSscore(strcmpi(LabelGroup,'VBLAST pre-test')),'ranksum');
    text(.17,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',20,'HorizontalAlignment','center');
    [~,ptext] = sigStar(FLSscore(strcmpi(LabelGroup,'Control post-test')),FLSscore(strcmpi(LabelGroup,'FLS post-test')),'ranksum');
    text(.67,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',20,'HorizontalAlignment','center');
    [~,ptext] = sigStar(FLSscore(strcmpi(LabelGroup,'Control post-test')),FLSscore(strcmpi(LabelGroup,'VBLAST post-test')),'ranksum');
    text(.83,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',20,'HorizontalAlignment','center');
    L = findall(gca,'Tag','Box');
    
    legend([L([2,3]);L(1)], {'Untrained Control','Trained FLS','Trained VBLaST'},'Location','Southeast');
    %set(gca, 'XTickLabelRotation', 45)
    
end
function [CTRLdata, CTRLscore, FLSdata, FLSscore, VBLASTdata, VBLASTscore] = ReadData_Transfer(CTRL, FLS, VBLAST, method)

    F = load(FLS);
    F_trials = fields(F.(char(fields(F))));

    C = load(CTRL);
    C_trials = fields(C.(char(fields(C))));
    
    V = load(VBLAST);
    V_trials = fields(V.(char(fields(V))));

    FLSdata = zeros(length(F_trials),8);
    FLSscore = zeros(length(F_trials),1);
    for i=1:length(F_trials) 
        name = char(F_trials(i));
        FLSscore(i,1) = F.(char(fields(F))).(name).score(3);
        Temp2 = zeros(31,1);
        for j = 1:32
            if method == 1
                [aa,~] = HRF_LocalMaxima(F.(char(fields(F))).(name).data(:,j));
                Temp2(j,1) = max(aa);
            elseif method ==2
                Temp2(j,1) = HRF_Integral(F.(char(fields(F))).(name).data(:,j));
            else
                Temp2(j,1) = HRF_Avg(F.(char(fields(F))).(name).data(:,j));
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
        FLSdata(i,:) = g2;
    end

    CTRLdata = zeros(length(C_trials),8);
    CTRLscore = zeros(length(C_trials),1);
    for i=1:length(C_trials) 
        name = char(C_trials(i));
        CTRLscore(i,1) = C.(char(fields(C))).(name).score;
        Temp2 = zeros(31,1);
        for j = 1:32
            if method == 1
                [aa,~] = HRF_LocalMaxima(C.(char(fields(C))).(name).data(:,j));
                Temp2(j,1) = max(aa);
            elseif method ==2
                Temp2(j,1) = HRF_Integral(C.(char(fields(C))).(name).data(:,j));
            else
                Temp2(j,1) = HRF_Avg(C.(char(fields(C))).(name).data(:,j));
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
        CTRLdata(i,:) = g2;
    end
    
    VBLASTdata = zeros(length(V_trials),8);
    VBLASTscore = zeros(length(V_trials),1);
    for i=1:length(V_trials) 
        name = char(V_trials(i));
        VBLASTscore(i,1) = V.(char(fields(V))).(name).score(3);
        Temp2 = zeros(31,1);
        for j = 1:32
            if method == 1
                [aa,~] = HRF_LocalMaxima(V.(char(fields(V))).(name).data(:,j));
                Temp2(j,1) = max(aa);
            elseif method ==2
                Temp2(j,1) = HRF_Integral(V.(char(fields(V))).(name).data(:,j));
            else
                Temp2(j,1) = HRF_Avg(V.(char(fields(V))).(name).data(:,j));
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
        VBLASTdata(i,:) = g2;
    end

end

function drawTransferScore(CTRLscore,FLSscore,VBLASTscore)
    BoxGroup = [];
    BoxData = [];
    BoxColorGroup = [];
    
    %Strucutre FLS score
    BoxData = [BoxData;FLSscore/60];
    BoxGroup = [BoxGroup;repmat({'Trained FLS'},length(FLSscore),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'F'},length(FLSscore),1)];
    
    %Strucutre CTRL score
    BoxData = [BoxData;CTRLscore/60];
    BoxGroup = [BoxGroup;repmat({'Control'},size(CTRLscore,1),1)];
    BoxColorGroup = [BoxColorGroup; repmat({'C'},size(CTRLscore,1),1)];

    %Structure VBLAST score
    BoxData = [BoxData;VBLASTscore/60];
    BoxGroup = [BoxGroup;repmat({'Trained VBLaST'},size(VBLASTscore,1),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'V'},size(VBLASTscore,1),1)];
    
    figure
    %boxplot(BoxData,BoxGroup,'colorgroup',BoxColorGroup,'colors',[[91 155 213]/256; [0 176 80]/256; [237 125 49]/256],'medianstyle', 'line','Symbol', 'ro','Whisker',25);
    boxplot(BoxData,BoxGroup,'colorgroup',BoxColorGroup,'colors',['m','k','c'],'medianstyle', 'line','Symbol', 'ro','Whisker',25);

    set(gca,'FontSize',14)
    set(findobj('Tag','Box'),'LineWidth',2);
    set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
    set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
    ylabel('Transfer task time (min)','FontName','Times New Roman','FontSize',20,'interpreter','tex')
%     [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'Control')),BoxData(strcmpi(BoxGroup,'Trained FLS')),'ttest');
%     text(.33,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',20,'HorizontalAlignment','center');
%     [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'Control')),BoxData(strcmpi(BoxGroup,'Trained VBLaST')),'ttest');
%     text(.66,.90,ptext,'Units','normalized','FontName','Times New Roman','FontSize',20,'HorizontalAlignment','center');
%     
    [ptext,~] = sigStar(BoxData(strcmpi(BoxGroup,'Control')),BoxData(strcmpi(BoxGroup,'Trained FLS')),'ttest');
    text(.33,.90,['p=',num2str(ptext)],'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    [ptext,~] = sigStar(BoxData(strcmpi(BoxGroup,'Control')),BoxData(strcmpi(BoxGroup,'Trained VBLaST')),'ttest');
    text(.66,.90,['p=',num2str(ptext)],'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
    
    
    L = findall(gca,'Tag','Box');
    legend([L([2,3]);L(1)], {'Untrained Control','Trained FLS','Trained VBLaST'},'Location','South');
    set(gca, 'XTickLabel', {''})
end

function drawTransferNIRS(CTRLdata, FLSdata, VBLASTdata)
    titles = {'Left Lateral PFC';'Medial PFC';'Right Lateral PFC';'Left Lateral M1';'Left Medial M1';'Right Medial M1';'Right Lateral M1';'SMA'};
    
    BoxGroup = [];
    BoxData = [];
    BoxColorGroup = [];
    
    %Strucutre FLS score
    BoxData = [BoxData;FLSdata];
    BoxGroup = [BoxGroup;repmat({'FLS'},size(FLSdata,1),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'F'},size(FLSdata,1),1)];
    
    %Strucutre CTRL score
    BoxData = [BoxData;CTRLdata];
    BoxGroup = [BoxGroup;repmat({'Control'},size(CTRLdata,1),1)];
    BoxColorGroup = [BoxColorGroup; repmat({'C'},size(CTRLdata,1),1)];

    %Structure VBLAST score
    BoxData = [BoxData;VBLASTdata];
    BoxGroup = [BoxGroup;repmat({'VBLAST'},size(VBLASTdata,1),1)];
    BoxColorGroup = [BoxColorGroup;repmat({'V'},size(VBLASTdata,1),1)];
    
    figure
    for i=[1,2,3,5,8]
        if(i==5)
            h1 = subplot(2,3,4);
        elseif(i==8)
            h1 = subplot(2,3,5);
        else
            h1 = subplot(2,3,i);
        end
        %h1 = subplot(3,3,i);
        
        %boxplot(BoxData(:,i),BoxGroup,'colorgroup',BoxColorGroup,'colors',[[91 155 213]/256; [0 176 80]/256; [237 125 49]/256],'medianstyle', 'line');
        boxplot(BoxData(:,i),BoxGroup,'colorgroup',BoxColorGroup,'colors',['c','k','m'],'medianstyle', 'line');
        set(findobj('Tag','Box'),'LineWidth',2);
        set(findobj('Tag','Median'),'LineWidth',1,'Color','k');
        set(findobj('-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
        set(gca,'FontSize',14,'XTickLabelRotation',45)
        title(titles(i), 'FontSize', 16);

        [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'Control'),i),BoxData(strcmpi(BoxGroup,'FLS'),i),'ranksum');
        text(.30,.93,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        [~,ptext] = sigStar(BoxData(strcmpi(BoxGroup,'Control'),i),BoxData(strcmpi(BoxGroup,'VBLAST'),i),'ranksum');
        text(.7,.93,ptext,'Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
        title(titles(i));
        set(gca,'XTickLabel',{' '});
        ppos = get(h1,'pos');
        ppos(3) = ppos(3) + 0.00;
        set(h1,'pos',ppos);
        if(i==1)
           ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',18,'interpreter','tex')
           set(gca,'XTickLabel',{' '});
           L = findall(gca,'Tag','Box');
    
           legend([L([2,3]);L(1)], {'Untrained Control','Trained FLS','Trained VBLaST'},'Location','Southeast');
        end
    end
end
