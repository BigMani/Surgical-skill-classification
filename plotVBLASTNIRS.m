load('VBLASTLearningNIRS.mat');
load('CTRLLearningNIRS.mat');
close all
group = {'Day1', 'Day2', 'Day3', 'Day4', 'Day5', 'Day6', 'Day7', 'Day8', 'Day9', 'Day10', 'Break 1', 'Break 2','Final'};

hold on
boxplot([CTRLLearningNIRS.preVBLAST(:,1),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postVBLAST(:,1)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([VBLASTLearningNIRS.Day1(:,1),VBLASTLearningNIRS.Day2(:,1),VBLASTLearningNIRS.Day3(:,1),VBLASTLearningNIRS.Day4(:,1),VBLASTLearningNIRS.Day5(:,1),VBLASTLearningNIRS.Day6(:,1),VBLASTLearningNIRS.Day7(:,1),VBLASTLearningNIRS.Day8(:,1),VBLASTLearningNIRS.Day9(:,1),VBLASTLearningNIRS.Day10(:,1),BUFFER,BUFFER,VBLASTLearningNIRS.FinalVBLAST(:,1)],group);
title('Left Lateral PFC');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preVBLAST(:,2),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postVBLAST(:,2)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([VBLASTLearningNIRS.Day1(:,2),VBLASTLearningNIRS.Day2(:,2),VBLASTLearningNIRS.Day3(:,2),VBLASTLearningNIRS.Day4(:,2),VBLASTLearningNIRS.Day5(:,2),VBLASTLearningNIRS.Day6(:,2),VBLASTLearningNIRS.Day7(:,2),VBLASTLearningNIRS.Day8(:,2),VBLASTLearningNIRS.Day9(:,2),VBLASTLearningNIRS.Day10(:,2),BUFFER,BUFFER,VBLASTLearningNIRS.FinalVBLAST(:,2)],group);
title('Medial PFC');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preVBLAST(:,3),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postVBLAST(:,3)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([VBLASTLearningNIRS.Day1(:,3),VBLASTLearningNIRS.Day2(:,3),VBLASTLearningNIRS.Day3(:,3),VBLASTLearningNIRS.Day4(:,3),VBLASTLearningNIRS.Day5(:,3),VBLASTLearningNIRS.Day6(:,3),VBLASTLearningNIRS.Day7(:,3),VBLASTLearningNIRS.Day8(:,3),VBLASTLearningNIRS.Day9(:,3),VBLASTLearningNIRS.Day10(:,3),BUFFER,BUFFER,VBLASTLearningNIRS.FinalVBLAST(:,3)],group);
title('Right Lateral PFC');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preVBLAST(:,4),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postVBLAST(:,4)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([VBLASTLearningNIRS.Day1(:,4),VBLASTLearningNIRS.Day2(:,4),VBLASTLearningNIRS.Day3(:,4),VBLASTLearningNIRS.Day4(:,4),VBLASTLearningNIRS.Day5(:,4),VBLASTLearningNIRS.Day6(:,4),VBLASTLearningNIRS.Day7(:,4),VBLASTLearningNIRS.Day8(:,4),VBLASTLearningNIRS.Day9(:,4),VBLASTLearningNIRS.Day10(:,4),BUFFER,BUFFER,VBLASTLearningNIRS.FinalVBLAST(:,4)],group);
title('Left Lateral M1');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preVBLAST(:,5),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postVBLAST(:,5)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([VBLASTLearningNIRS.Day1(:,5),VBLASTLearningNIRS.Day2(:,5),VBLASTLearningNIRS.Day3(:,5),VBLASTLearningNIRS.Day4(:,5),VBLASTLearningNIRS.Day5(:,5),VBLASTLearningNIRS.Day6(:,5),VBLASTLearningNIRS.Day7(:,5),VBLASTLearningNIRS.Day8(:,5),VBLASTLearningNIRS.Day9(:,5),VBLASTLearningNIRS.Day10(:,5),BUFFER,BUFFER,VBLASTLearningNIRS.FinalVBLAST(:,5)],group);
title('Left Medial M1');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preVBLAST(:,6),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postVBLAST(:,6)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([VBLASTLearningNIRS.Day1(:,6),VBLASTLearningNIRS.Day2(:,6),VBLASTLearningNIRS.Day3(:,6),VBLASTLearningNIRS.Day4(:,6),VBLASTLearningNIRS.Day5(:,6),VBLASTLearningNIRS.Day6(:,6),VBLASTLearningNIRS.Day7(:,6),VBLASTLearningNIRS.Day8(:,6),VBLASTLearningNIRS.Day9(:,6),VBLASTLearningNIRS.Day10(:,6),BUFFER,BUFFER,VBLASTLearningNIRS.FinalVBLAST(:,6)],group);
title('Right Medial M1');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preVBLAST(:,7),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postVBLAST(:,7)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([VBLASTLearningNIRS.Day1(:,7),VBLASTLearningNIRS.Day2(:,7),VBLASTLearningNIRS.Day3(:,7),VBLASTLearningNIRS.Day4(:,7),VBLASTLearningNIRS.Day5(:,7),VBLASTLearningNIRS.Day6(:,7),VBLASTLearningNIRS.Day7(:,7),VBLASTLearningNIRS.Day8(:,7),VBLASTLearningNIRS.Day9(:,7),VBLASTLearningNIRS.Day10(:,7),BUFFER,BUFFER,VBLASTLearningNIRS.FinalVBLAST(:,7)],group);
title('Right Lateral M1');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preVBLAST(:,8),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postVBLAST(:,8)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([VBLASTLearningNIRS.Day1(:,8),VBLASTLearningNIRS.Day2(:,8),VBLASTLearningNIRS.Day3(:,8),VBLASTLearningNIRS.Day4(:,8),VBLASTLearningNIRS.Day5(:,8),VBLASTLearningNIRS.Day6(:,8),VBLASTLearningNIRS.Day7(:,8),VBLASTLearningNIRS.Day8(:,8),VBLASTLearningNIRS.Day9(:,8),VBLASTLearningNIRS.Day10(:,5),BUFFER,BUFFER,VBLASTLearningNIRS.FinalVBLAST(:,8)],group);
title('SMA');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');