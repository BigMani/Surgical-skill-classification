load('VBLAST_metrics.mat');
N = fields(VBLAST_novice);
E = fields(VBLAST_expert);
N_E = char(E);
N_N = char(N);

for i = 1:size(N_N,1)
    tic
    disp(['Computing total path length for: ',N_N(i,:)])
    ToolPathlength.Novice_Right_Trial(i,1) = sum(diag(squareform(pdist(VBLAST_novice.(N_N(i,:)).Right(:,3:5)/1000)),-1));
    ToolPathlength.Novice_Left_Trial(i,1) = sum(diag(squareform(pdist(VBLAST_novice.(N_N(i,:)).Left(:,3:5)/1000)),-1));
    toc
end

for i = 1:size(N_E,1)
    tic
    disp(['Computing total path length for: ',char(N_E(i,:))])
    ToolPathlength.Expert_Right_Trial(i,1) = sum(diag(squareform(pdist(VBLAST_expert.(N_E(i,:)).Right(:,3:5)/1000)),-1));
    ToolPathlength.Expert_Left_Trial(i,1) = sum(diag(squareform(pdist(VBLAST_expert.(N_E(i,:)).Left(:,3:5)/1000)),-1));
    toc
end

N_subjects = str2double(cellfun(@(x)x(19:20), N, 'UniformOutput', false));
E_subjects = str2double(cellfun(@(x)x(19:20), E, 'UniformOutput', false));
N_uniquesubs = unique(N_subjects,'stable');
E_uniquesubs = unique(E_subjects,'stable');

for i = 1:size(N_uniquesubs,1)
    ToolPathlength.Novice_Right(i) = nanmean(ToolPathlength.Novice_Right_Trial(N_subjects == N_uniquesubs(i)));
    ToolPathlength.Novice_Left(i) = nanmean(ToolPathlength.Novice_Left_Trial(N_subjects == N_uniquesubs(i)));
end

for k = 1:size(E_uniquesubs,1)
    ToolPathlength.Expert_Right(k) = nanmean(ToolPathlength.Expert_Right_Trial(E_subjects == E_uniquesubs(k)));
    ToolPathlength.Expert_Left(k) = nanmean(ToolPathlength.Expert_Left_Trial(E_subjects == E_uniquesubs(k)));
end