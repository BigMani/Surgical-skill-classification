function void = VBLAST_metrics()
% This function analysizes various metrics derived from the VBLAST software
% Metrics are: Tool economy of motion, Force output, Jerk, Acceleration,
% RMS velocity
% Initialize data
load('VBLAST_data.mat');
calcForceMetrics();

function void = calcScores()
% Calculate VBLAST and FLS pattern cutting performance scores
VBLAST_N = [79;79;133;129;163;185;143;159;187;193;80;126;131;179;180;132;111;105;112;123;153;145;144;126;129;143;151;129;165;158;189;188;197];
VBLAST_E = [176;173;146;176;207;112;160;180;192;185;160;195;194;169;186;116;151;168;142;154;122;157;184;211;176;124;165;160;174;185;174;198;215;203;203;174;195;209;179;195;173];

FLS_N = [166.6;184.1;173.8;122.6;127.6;124;158.3];
FLS_E = [186.4;222;198.9;167.4;184.6;150.6;181.2;235.6];

%VBLAST
[p,~] = ranksum(VBLAST_N,VBLAST_E);
p = floor(p*1000)/1000;
pp = ['p =',' ',num2str(p)];
group = [repmat({'Novice'}, length(VBLAST_N), 1); repmat({'Expert'}, length(VBLAST_E), 1)];
figure;
boxplot([VBLAST_N;VBLAST_E], group)
ylim([70 240])
t = text(.85,.96,pp,'Units','normalized','FontSize',10,'FontWeight','bold');
ylabel('VBLAST Pattern Cutting Score','FontSize',12,'FontWeight','bold')

%FLS
[p,~] = ranksum(FLS_N,FLS_E);
p = floor(p*1000)/1000;
pp = ['p =',' ',num2str(p)];
group = [repmat({'Novice'}, length(FLS_N), 1); repmat({'Expert'}, length(FLS_E), 1)];
figure;
boxplot([FLS_N;FLS_E], group)
ylim([70 240])
t = text(.85,.96,pp,'Units','normalized','FontSize',10,'FontWeight','bold');
ylabel('FLS Pattern Cutting Score','FontSize',12,'FontWeight','bold')
function [N_EOM, E_EOM] = calcEOM()

function void = calcForceMetrics()
% Visualize Forces
s = 1;
p = 20;
Fx_le = []; Fy_le = []; Fz_le = []; FRMS_le = [];
Fx_re = []; Fy_re = []; Fz_re = []; FRMS_re = [];
Fx_ln = []; Fy_ln = []; Fz_ln = []; FRMS_ln = [];
Fx_rn = []; Fy_rn = []; Fz_rn = []; FRMS_rn = [];

N_E = char(fieldnames(VBLAST_Expert));
N_N = char(fieldnames(VBLAST_Novice));
for kk = 1:size(N_E)
    Fx_le = [Fx_le;VBLAST_Expert.(N_E(kk,:)).Toolone(:,27)];
    Fy_le = [Fy_le;VBLAST_Expert.(N_E(kk,:)).Toolone(:,28)];
    Fz_le = [Fz_le;VBLAST_Expert.(N_E(kk,:)).Toolone(:,29)];
    FRMS_le = [FRMS_le; sqrt((VBLAST_Expert.(N_E(kk,:)).Toolone(:,27)).^0.5 + (VBLAST_Expert.(N_E(kk,:)).Toolone(:,28)).^0.5 + (VBLAST_Expert.(N_E(kk,:)).Toolone(:,29)).^.5)];
    Fx_re = [Fx_re;VBLAST_Expert.(N_E(kk,:)).Tooltwo(:,27)];
    Fy_re = [Fy_re;VBLAST_Expert.(N_E(kk,:)).Tooltwo(:,28)];
    Fz_re = [Fz_re;VBLAST_Expert.(N_E(kk,:)).Tooltwo(:,29)];
end

Fx_le = resample(Fx_le,s,p);
Fy_le = resample(Fy_le,s,p);
Fz_le = resample(Fz_le,s,p);
Fx_re = resample(Fx_re,s,p);
Fy_re = resample(Fy_re,s,p);
Fz_re = resample(Fz_re,s,p);

for kk = 1:size(N_N)
    Fx_ln = [Fx_ln;VBLAST_Novice.(N_N(kk,:)).Toolone(:,27)];
    Fy_ln = [Fy_ln;VBLAST_Novice.(N_N(kk,:)).Toolone(:,28)];
    Fz_ln = [Fz_ln;VBLAST_Novice.(N_N(kk,:)).Toolone(:,29)];
    Fx_rn = [Fx_rn;VBLAST_Novice.(N_N(kk,:)).Tooltwo(:,27)];
    Fy_rn = [Fy_rn;VBLAST_Novice.(N_N(kk,:)).Tooltwo(:,28)];
    Fz_rn = [Fz_rn;VBLAST_Novice.(N_N(kk,:)).Tooltwo(:,29)];
end
Fx_ln = resample(Fx_ln,s,p);
Fy_ln = resample(Fy_ln,s,p);
Fz_ln = resample(Fz_ln,s,p);
Fx_rn = resample(Fx_rn,s,p);
Fy_rn = resample(Fy_rn,s,p);
Fz_rn = resample(Fz_rn,s,p);

subplot(2,2,1)
scatter(Fx_le,Fy_le,'.','r');
hold on
scatter(Fx_ln,Fy_ln,'.','b');
title('Left Tool forces (Fx-Fy)', 'FontSize', 14,'FontWeight','bold')
xlabel('Fx'); ylabel('Fy');
subplot(2,2,2)
scatter(Fx_le,Fz_le,'.','r');
hold on
scatter(Fx_ln,Fz_ln,'.','b');
title('Left Tool forces (Fx-Fz)', 'FontSize', 14,'FontWeight','bold')
xlabel('Fx'); ylabel('Fz');
subplot(2,2,3)
scatter(Fy_le,Fz_le,'.','r');
hold on
scatter(Fy_ln,Fz_ln,'.','b');
title('Left Tool forces (Fy-Fz)', 'FontSize', 14,'FontWeight','bold')
xlabel('Fy'); ylabel('Fz');

figure;
subplot(2,2,1)
scatter(Fx_re,Fy_re,'.','r');
hold on
scatter(Fx_rn,Fy_rn,'.','b');
title('Right Tool forces (Fx-Fy)', 'FontSize', 14,'FontWeight','bold')
xlabel('Fx'); ylabel('Fy');
subplot(2,2,2)
scatter(Fx_re,Fz_re,'.','r');
hold on
scatter(Fx_rn,Fz_rn,'.','b');
title('Right Tool forces (Fx-Fz)', 'FontSize', 14,'FontWeight','bold')
xlabel('Fx'); ylabel('Fz');
subplot(2,2,3)
scatter(Fy_re,Fz_re,'.','r');
hold on
scatter(Fy_rn,Fz_rn,'.','b');
title('Right Tool forces (Fy-Fz)', 'FontSize', 14,'FontWeight','bold')
xlabel('Fy'); ylabel('Fz');