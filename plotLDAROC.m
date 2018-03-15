function AUCsvm = plotLDAROC(truelabel, model1, metric)
%
% Author: Arun Nemani


% Calculate and plot ROC curve
% Compute posterior probabilities
[~,score_svm] = resubPredict(model1);
[Xsvm,Ysvm,~,AUCsvm] = perfcurve(truelabel,score_svm(:,model1.ClassNames),'true');

AUCsvm = floor(AUCsvm*1000)/1000;

plot(Xsvm,Ysvm)
hold on
plot([0:0.01:1],[0:0.01:1],'--r','LineWidth',2)
hold off

pp = strcat(metric,{' '},'+ NIRS AOC = ',{' '},num2str(AUCsvm));
text(.95,.25,pp,'Units','normalized','FontSize',14,'FontWeight','bold','HorizontalAlignment','right');