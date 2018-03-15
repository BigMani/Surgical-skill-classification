function plotSVMROC(orig_truelabels, truelabel, fls_model, nirs_model, metric)
%
% Author: Arun Nemani


% Calculate and plot ROC curve
% Compute posterior probabilities
Mdl_FLS = fitPosterior(fls_model);
[predict_FLS,score_svm_FLS] = resubPredict(Mdl_FLS);
Mdl_NIRS = fitPosterior(nirs_model);
[predict_NIRS,score_svm_NIRS] = resubPredict(Mdl_NIRS);
[Xsvm_FLS,Ysvm_FLS,~,AUCsvm_FLS] = perfcurve(orig_truelabels,score_svm_FLS(:,Mdl_FLS.ClassNames),'true');
[Xsvm_NIRS,Ysvm_NIRS,~,AUCsvm_NIRS] = perfcurve(truelabel,score_svm_NIRS(:,Mdl_NIRS.ClassNames),'true');

AUCsvm_FLS = floor(AUCsvm_FLS*1000)/1000;
AUCsvm_NIRS = floor(AUCsvm_NIRS*1000)/1000;

figure
plotconfusion(orig_truelabels',predict_FLS','SVM - FLS classification');
xlabel('True class', 'FontSize', 14)
ylabel('Predicted class', 'FontSize', 14)
set(gca,'XTickLabel',{'Skilled\newlinetrainee','Unskilled\newlinetrainee',''}, 'FontSize', 12)
set(gca,'YTickLabel',{'Skilled\newlinetrainee','Unskilled\newlinetrainee',''},'FontSize', 12)
ytickangle(90)

figure
plotconfusion(truelabel',predict_NIRS','SVM - weighted fNIRS classification');
xlabel('True class', 'FontSize', 14)
ylabel('Predicted class', 'FontSize', 14)
set(gca,'XTickLabel',{'Skilled\newlinetrainee','Unskilled\newlinetrainee',''}, 'FontSize', 12)
set(gca,'YTickLabel',{'Skilled\newlinetrainee','Unskilled\newlinetrainee',''},'FontSize', 12)
ytickangle(90)

figure
hold on
plot(Xsvm_FLS,Ysvm_FLS, 'm','LineWidth',2)
plot(Xsvm_NIRS,Ysvm_NIRS, 'c','LineWidth',2)
plot([0:0.01:1],[0:0.01:1],'--r','LineWidth',2)
hold off

pp = strcat(metric,{' '}, 'AOC = ',{' '},num2str(AUCsvm_FLS));
text(.95,.15,pp,'Units','normalized','FontSize',14,'FontWeight','bold','HorizontalAlignment','right');
pp = strcat('NIRS AOC = ',{' '},num2str(AUCsvm_NIRS));
text(.95,.05,pp,'Units','normalized','FontSize',14,'FontWeight','bold','HorizontalAlignment','right');

