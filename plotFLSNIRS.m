load('FLSLearningNIRS_2.mat');
load('CTRLLearningNIRS.mat');
close all
group = {'Day1', 'Day2', 'Day3', 'Day4', 'Day5', 'Day6', 'Day7', 'Day8', 'Day9', 'Day10', 'Day11', 'Day12', 'Break 1', 'Break 2','Final'};

hold on
boxplot([CTRLLearningNIRS.preFLS(:,1),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postFLS(:,1)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([FLSLearningNIRS.Day1(:,1),FLSLearningNIRS.Day2(:,1),FLSLearningNIRS.Day3(:,1),FLSLearningNIRS.Day4(:,1),FLSLearningNIRS.Day5(:,1),FLSLearningNIRS.Day6(:,1),FLSLearningNIRS.Day7(:,1),FLSLearningNIRS.Day8(:,1),FLSLearningNIRS.Day9(:,1),FLSLearningNIRS.Day10(:,1),FLSLearningNIRS.Day11(:,1),FLSLearningNIRS.Day12(:,1),BUFFER,BUFFER,FLSLearningNIRS.FinalFLS(:,1)],group);
title('Left Lateral PFC');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preFLS(:,2),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postFLS(:,2)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([FLSLearningNIRS.Day1(:,2),FLSLearningNIRS.Day2(:,2),FLSLearningNIRS.Day3(:,2),FLSLearningNIRS.Day4(:,2),FLSLearningNIRS.Day5(:,2),FLSLearningNIRS.Day6(:,2),FLSLearningNIRS.Day7(:,2),FLSLearningNIRS.Day8(:,2),FLSLearningNIRS.Day9(:,2),FLSLearningNIRS.Day10(:,2),FLSLearningNIRS.Day11(:,2),FLSLearningNIRS.Day12(:,2),BUFFER,BUFFER,FLSLearningNIRS.FinalFLS(:,2)],group);
title('Medial PFC');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preFLS(:,3),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postFLS(:,3)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([FLSLearningNIRS.Day1(:,3),FLSLearningNIRS.Day2(:,3),FLSLearningNIRS.Day3(:,3),FLSLearningNIRS.Day4(:,3),FLSLearningNIRS.Day5(:,3),FLSLearningNIRS.Day6(:,3),FLSLearningNIRS.Day7(:,3),FLSLearningNIRS.Day8(:,3),FLSLearningNIRS.Day9(:,3),FLSLearningNIRS.Day10(:,3),FLSLearningNIRS.Day11(:,3),FLSLearningNIRS.Day12(:,3),BUFFER,BUFFER,FLSLearningNIRS.FinalFLS(:,3)],group);
title('Right Lateral PFC');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preFLS(:,4),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postFLS(:,4)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([FLSLearningNIRS.Day1(:,4),FLSLearningNIRS.Day2(:,4),FLSLearningNIRS.Day3(:,4),FLSLearningNIRS.Day4(:,4),FLSLearningNIRS.Day5(:,4),FLSLearningNIRS.Day6(:,4),FLSLearningNIRS.Day7(:,4),FLSLearningNIRS.Day8(:,4),FLSLearningNIRS.Day9(:,4),FLSLearningNIRS.Day10(:,4),FLSLearningNIRS.Day11(:,4),FLSLearningNIRS.Day12(:,4),BUFFER,BUFFER,FLSLearningNIRS.FinalFLS(:,4)],group);
title('Left Lateral M1');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preFLS(:,5),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postFLS(:,5)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([FLSLearningNIRS.Day1(:,5),FLSLearningNIRS.Day2(:,5),FLSLearningNIRS.Day3(:,5),FLSLearningNIRS.Day4(:,5),FLSLearningNIRS.Day5(:,5),FLSLearningNIRS.Day6(:,5),FLSLearningNIRS.Day7(:,5),FLSLearningNIRS.Day8(:,5),FLSLearningNIRS.Day9(:,5),FLSLearningNIRS.Day10(:,5),FLSLearningNIRS.Day11(:,5),FLSLearningNIRS.Day12(:,5),BUFFER,BUFFER,FLSLearningNIRS.FinalFLS(:,5)],group);
title('Left Medial M1');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preFLS(:,6),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postFLS(:,6)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([FLSLearningNIRS.Day1(:,6),FLSLearningNIRS.Day2(:,6),FLSLearningNIRS.Day3(:,6),FLSLearningNIRS.Day4(:,6),FLSLearningNIRS.Day5(:,6),FLSLearningNIRS.Day6(:,6),FLSLearningNIRS.Day7(:,6),FLSLearningNIRS.Day8(:,6),FLSLearningNIRS.Day9(:,6),FLSLearningNIRS.Day10(:,6),FLSLearningNIRS.Day11(:,6),FLSLearningNIRS.Day12(:,6),BUFFER,BUFFER,FLSLearningNIRS.FinalFLS(:,6)],group);
title('Right Medial M1');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preFLS(:,7),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postFLS(:,7)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([FLSLearningNIRS.Day1(:,7),FLSLearningNIRS.Day2(:,7),FLSLearningNIRS.Day3(:,7),FLSLearningNIRS.Day4(:,7),FLSLearningNIRS.Day5(:,7),FLSLearningNIRS.Day6(:,7),FLSLearningNIRS.Day7(:,7),FLSLearningNIRS.Day8(:,7),FLSLearningNIRS.Day9(:,7),FLSLearningNIRS.Day10(:,7),FLSLearningNIRS.Day11(:,7),FLSLearningNIRS.Day12(:,7),BUFFER,BUFFER,FLSLearningNIRS.FinalFLS(:,7)],group);
title('Right Lateral M1');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');

figure;
hold on
boxplot([CTRLLearningNIRS.preFLS(:,8),BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,BUFFER,CTRLLearningNIRS.postFLS(:,8)],group,'color','r');
set(gca, 'xticklabel', {''});
boxplot([FLSLearningNIRS.Day1(:,8),FLSLearningNIRS.Day2(:,8),FLSLearningNIRS.Day3(:,8),FLSLearningNIRS.Day4(:,8),FLSLearningNIRS.Day5(:,8),FLSLearningNIRS.Day6(:,8),FLSLearningNIRS.Day7(:,8),FLSLearningNIRS.Day8(:,8),FLSLearningNIRS.Day9(:,8),FLSLearningNIRS.Day10(:,5),FLSLearningNIRS.Day11(:,8),FLSLearningNIRS.Day12(:,8),BUFFER,BUFFER,FLSLearningNIRS.FinalFLS(:,8)],group);
title('SMA');
xlabel('Day');
ylabel('Delta HbO2 conc (mM*cm)');