load('Hb_Extinction.mat')
close all

HbO2 = Hb_Extinction(:,2);
HbR = Hb_Extinction(:,3);
Lambda = Hb_Extinction(:,1);
[~, idx1] = min(abs(Lambda - 650));
[~, idx2] = min(abs(Lambda - 950));

plot(Lambda(idx1:idx2), HbO2(idx1:idx2),'LineWidth',2, 'Color','r')
hold on
plot(Lambda(idx1:idx2), HbR(idx1:idx2), 'LineWidth',2, 'Color','b')
hold off
legend({'HbO_{2}','HbR'})
xlabel('Wavelength (nm)')
ylabel('Molar extinction coefficient (cm^{-1} / M)');
set(gca,'FontSize',14)