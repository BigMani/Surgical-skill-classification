function void = plotROCThreshold(idx, nirsdata, scoredata, truelabel, metric)

nirs_thresh = linspace(min(nirsdata),max(nirsdata),10);
score_thresh = linspace(min(scoredata),max(scoredata),10);
X_s = zeros(12,1);
Y_s = zeros(12,1);

X_n = zeros(12,1);
Y_n = zeros(12,1);
for i = 1:10
    predicted_label_s = scoredata > score_thresh(i);
    switch idx
        case {1,2,3}
            predicted_label_n = nirsdata < nirs_thresh(i);
        case {4,5,6,7,8}
            predicted_label_n = nirsdata > nirs_thresh(i);
    end
    
    [X_s(i+1), Y_s(i+1)] = contingency_table(truelabel,predicted_label_s);
    [X_n(i+1), Y_n(i+1)] = contingency_table(truelabel,predicted_label_n);
end
X_s(12) = 1;
Y_s(12) = 1;
X_n(12) = 1;
Y_n(12) = 1;
[XROC_s, sort_idx] = sort(X_s);
YROC_s = Y_s;
YROC_s = YROC_s(sort_idx);

[XROC_n, sort_idx] = sort(X_n);
YROC_n = Y_n;
YROC_n = YROC_n(sort_idx);

plot(XROC_s, YROC_s,'m');
hold on
plot(XROC_n, YROC_n,'g');
plot([0:0.01:1],[0:0.01:1],'--r','LineWidth',2)
hold off

AOC_s = trapz(XROC_s, YROC_s);
AOC_s = floor(AOC_s*1000)/1000;
AOC_n = trapz(XROC_n', YROC_n');  
AOC_n = floor(AOC_n*1000)/1000;
tempstr = strcat(metric,' Threshold');
legend(tempstr, 'NIRS Threshold','Location','SouthEast')
xlabel('False positive rate (1 - specificity)'); ylabel('True positive rate (sensitivity)');

pp = strcat(metric,{' '},'+ NIRS AOC = ',{' '},num2str(AOC_s));
t = text(.65,.42,pp,'Units','normalized','FontSize',10,'FontWeight','bold');

pp = strcat('NIRS AOC = ',{' '},num2str(AOC_n));
t = text(.65,.35,pp,'Units','normalized','FontSize',10,'FontWeight','bold');