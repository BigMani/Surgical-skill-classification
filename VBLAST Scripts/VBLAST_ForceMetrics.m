load('VBLAST_metrics.mat');

% Visualize Forces
s = 1;
p = 20;
Fx_le = []; Fy_le = []; Fz_le = []; FRMS_le = [];
Fx_re = []; Fy_re = []; Fz_re = []; FRMS_re = [];
Fx_ln = []; Fy_ln = []; Fz_ln = []; FRMS_ln = [];
Fx_rn = []; Fy_rn = []; Fz_rn = []; FRMS_rn = [];

N_E = char(fieldnames(VBLAST_expert));
N_N = char(fieldnames(VBLAST_novice));
for kk = 1:size(N_E)
    Fx_le = [Fx_le;VBLAST_expert.(N_E(kk,:)).Left(:,27)];
    Fy_le = [Fy_le;VBLAST_expert.(N_E(kk,:)).Left(:,28)];
    Fz_le = [Fz_le;VBLAST_expert.(N_E(kk,:)).Left(:,29)];
    FRMS_le = [FRMS_le; sqrt((VBLAST_expert.(N_E(kk,:)).Left(:,27)).^0.5 + (VBLAST_expert.(N_E(kk,:)).Left(:,28)).^0.5 + (VBLAST_expert.(N_E(kk,:)).Left(:,29)).^.5)];
    Fx_re = [Fx_re;VBLAST_expert.(N_E(kk,:)).Right(:,27)];
    Fy_re = [Fy_re;VBLAST_expert.(N_E(kk,:)).Right(:,28)];
    Fz_re = [Fz_re;VBLAST_expert.(N_E(kk,:)).Right(:,29)];
end

Fx_le = resample(Fx_le,s,p);
Fy_le = resample(Fy_le,s,p);
Fz_le = resample(Fz_le,s,p);
Fx_re = resample(Fx_re,s,p);
Fy_re = resample(Fy_re,s,p);
Fz_re = resample(Fz_re,s,p);

for kk = 1:size(N_N)
    Fx_ln = [Fx_ln;VBLAST_novice.(N_N(kk,:)).Left(:,27)];
    Fy_ln = [Fy_ln;VBLAST_novice.(N_N(kk,:)).Left(:,28)];
    Fz_ln = [Fz_ln;VBLAST_novice.(N_N(kk,:)).Left(:,29)];
    Fx_rn = [Fx_rn;VBLAST_novice.(N_N(kk,:)).Right(:,27)];
    Fy_rn = [Fy_rn;VBLAST_novice.(N_N(kk,:)).Right(:,28)];
    Fz_rn = [Fz_rn;VBLAST_novice.(N_N(kk,:)).Right(:,29)];
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