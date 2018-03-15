function [C_trials, CTRLdata, CTRLscore, F_trials, FLSdata, FLSscore] = ReadData_LearningCurve(FLS, CTRL, method)

F = load(FLS);
F_trials = fields(F.(char(fields(F))));

C = load(CTRL);
C_trials = fields(C.(char(fields(C))));

FLSdata = zeros(length(F_trials),8);
FLSscore = zeros(length(F_trials),1);
for i=1:length(F_trials) 
    name = char(F_trials(i));
    FLSscore(i,1) = F.(char(fields(F))).(name).score;
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
    g2(1,8) = nanmean(Temp2(30:32,:));
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
    g2(1,8) = nanmean(Temp2(30:32,:));
    CTRLdata(i,:) = g2;
end
