close all
clear
load('MGH_VBLAST_Expert_Data.mat')

A = nanmean(MGH_VBLAST_Expert_Data.Resident_7_VBLAST.data(:,2),2);
B = nanmean(MGH_VBLAST_Expert_Data.Resident_7_VBLAST.data(:,18),2);
Stim = MGH_VBLAST_Expert_Data.Resident_7_VBLAST.Stim;
t = 0:1/25:size(A,1)/25;
t(end) = [];

[~, idxstim1] = min(abs(t - Stim(3)));
[~, idxstim2] = min(abs(t - Stim(4)));
figure
plot(t(idxstim1:idxstim2),A(idxstim1:idxstim2),t(idxstim1:idxstim2),B(idxstim1:idxstim2));
%title('VBLAST expert Channel 2 and 18 (LPFC - LMM1) STIM','FontName','Times New Roman','FontSize', 16);
legend({'LPFC channel','LMM1 channel'})
ylabel('\DeltaHbO_2 conc. (\muM*mm)','FontName','Times New Roman','FontSize',16,'interpreter','tex')
xlabel('Time (sec)','FontName','Times New Roman','FontSize',16,'interpreter','tex')

figure
wcoherence(A(idxstim1:idxstim2),B(idxstim1:idxstim2),25,'PhaseDisplayThreshold',0.999);
colormap jet
[wcoh,wcs,f,coi] = wcoherence(A(idxstim1:idxstim2),B(idxstim1:idxstim2),25,'PhaseDisplayThreshold',0.999);
wcoh(~bsxfun(@gt,repmat(f,1,size(wcoh,2)),coi')) = NaN;
WCO = nanmean(wcoh,2);

theta = angle(wcs);
%theta=reshape(mod(theta,2*pi),size(wcs));
theta(~bsxfun(@gt,repmat(f,1,size(wcs,2)),coi')) = NaN;
Pcos = nanmean(cos(theta),2);
Psin = nanmean(sin(theta),2);
WPCO = sqrt(Pcos.^2 + Psin.^2);   
       
plotCoherence(f, WCO, 'WCO', 1)
hold on
plot ([2 2],[0 1.1],'k--', 'LineWidth', 2)
plot ([0.6 0.6],[0 1.1],'k--', 'LineWidth', 2)
plot ([0.15 0.15],[0 1.1],'k--', 'LineWidth', 2)
plot ([0.05 0.05],[0 1.1],'k--', 'LineWidth', 2)
plot ([0.02 0.02],[0 1.1],'k--', 'LineWidth', 2)
text(.07,.95,'EA','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
text(.19,.95,'NA','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
text(.36,.95,'MA','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
text(.58,.95,'RA','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
text(.79,.95,'CA','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
hold off

xlim([0.01 4])
ylim([0 1.1])
%view([90 270])
plotCoherence(f, WPCO, 'WPCO', 1)
hold on
plot ([2 2],[0 1.1],'k--', 'LineWidth', 2)
plot ([0.6 0.6],[0 1.1],'k--', 'LineWidth', 2)
plot ([0.15 0.15],[0 1.1],'k--', 'LineWidth', 2)
plot ([0.05 0.05],[0 1.1],'k--', 'LineWidth', 2)
plot ([0.02 0.02],[0 1.1],'k--', 'LineWidth', 2)
text(.07,.95,'EA','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
text(.19,.95,'NA','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
text(.36,.95,'MA','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
text(.58,.95,'RA','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
text(.79,.95,'CA','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','center');
hold off
xlim([0.01 4])
ylim([0 1.1])
%view([90 270])

function plotCoherence(freq, Waveletout, Ylabel, AxisType)
    figure
    semilogx(freq,Waveletout,'LineWidth',2);
     if(AxisType == 1)
        New_XTickLabel = get(gca,'xtick');
        set(gca,'XTickLabel',New_XTickLabel);
        set(gca,'FontSize',12)
        xlabel('Frequency (Hz)')
        ylabel(Ylabel);
     elseif(AxisType == 2)
        min_x = min(freq);
        
        max_x = max(freq);
        most_sig_position_min = 10^floor((log10(min_x)));
        most_sig_digit_min = floor(min_x / most_sig_position_min);
        min_xaxis = most_sig_digit_min * most_sig_position_min;
        most_sig_position_max = 10^floor((log10(max_x)));
        most_sig_digit_max = ceil(max_x / most_sig_position_max);
        max_xaxis = most_sig_digit_max * most_sig_position_max;
        p(1) = ceil(log10(min_xaxis));
        p(2) = ceil(log10(max_xaxis));
        ticks = [];
        for k=p(1):p(2)
            if k==p(1)
                ticks = [ticks min_xaxis:10^(k-1):10^k];
            elseif k==p(2)
                ticks = [ticks 10^(k-1)+10^(k-1):10^(k-1):max_xaxis];
            else
                ticks = [ticks 10^(k-1)+10^(k-1):10^(k-1):10^k];
            end
        end
        set(gca,'xtick',ticks())
        set(gca,'FontSize',10)
        xtickangle(90);
        axis([min_xaxis max_xaxis -inf inf])
        xlabel('Frequency (Hz)')
        ylabel(Ylabel);
     end
end