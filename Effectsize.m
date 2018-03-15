function d = Effectsize(novice, expert)

load(novice)
time = group.procResult.tHRF;
index = knnsearch(time,0);
Novice_HbO = 1E6*reshape(group.procResult.dcAvg(:,1,:),length(time),33);
load(expert)
Expert_HbO = 1E6*reshape(group.procResult.dcAvg(:,1,:),length(time),33);
std_N = std(Novice_HbO(index:end,:));
std_E = std(Expert_HbO(index:end,:));
mean_N = mean(Novice_HbO);
mean_E = mean(Expert_HbO);

d = abs((mean_N - mean_E)./(sqrt((std_N.^2 + std_N.^2)/2)));
d = d';