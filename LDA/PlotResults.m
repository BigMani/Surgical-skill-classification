function PlotResults(Model,Data,Display,changeDirection)
global PDFxlabel; %dynamically changed per application script for the PDF xlabels
global PDFdist; %Euclidean distance of .50 of CDF for each class.
global tf;
global Type_II_E;
global Type_II_N;
global CVplottitle;
fighandle = gcf;
n = fighandle.Number;
if strcmp(Display(1),'1')
    n = n + 1;
    figure(n)
    if strcmp(Display(2),'2')
        m0 = 1;
        for i=1:length(Data.K)
            t = Model.t(m0:m0+Data.K(i)-1,1);
            if i==1
                plot(m0:m0+Data.K(i)-1,t,'mo','Markersize',18,'LineWidth',2.0), hold on
            elseif i==2
                plot(m0:m0+Data.K(i)-1,t,'c+','Markersize',18,'LineWidth',2.0), hold on
            elseif i==3
                plot(m0:m0+Data.K(i)-1,t,'kx','Markersize',18,'LineWidth',2.0), hold on
            elseif i==4
                plot(m0:m0+Data.K(i)-1,t,'k*','Markersize',18,'LineWidth',2.0), hold on
            end
            if i < length(Data.K)
                m0 = m0+Data.K(i);
            end
        end
        hold off
        axis tight
        set(gca,'box','off','FontName','Times New Roman','FontSize',24);
        xlabel('Sample','FontName','Times New Roman','FontSize',30);
        ylabel('Score','FontName','Times New Roman','FontSize',30);
    elseif strcmp(Display(2),'3')
        m0 = 1;
        for i=1:length(Data.K)
            t1 = Model.t(m0:m0+Data.K(i)-1,1);
            t2 = Model.t(m0:m0+Data.K(i)-1,2);
            if i==1
                plot(t1,t2,'ko','Markersize',18,'LineWidth',2.0), hold on
            elseif i==2
                plot(t1,t2,'k+','Markersize',18,'LineWidth',2.0), hold on
            elseif i==3
                plot(t1,t2,'kx','Markersize',18,'LineWidth',2.0), hold on
            elseif i==4
                plot(t1,t2,'k*','Markersize',18,'LineWidth',2.0), hold on
            end
            if i < length(Data.K)
                m0 = m0+Data.K(i);
            end
        end
        hold off
        axis tight
        set(gca,'box','off','FontName','Times New Roman','FontSize',24);
        xlabel('Score 1','FontName','Times New Roman','FontSize',30);
        ylabel('Score 2','FontName','Times New Roman','FontSize',30);
        n  = n + 1;
        m0 = 1;
        figure(n)
        for i=1:length(Data.K)
            t1 = Model.t(m0:m0+Data.K(i)-1,1);
            t2 = Model.t(m0:m0+Data.K(i)-1,2);
            if i==1
                subplot(211), 
                plot(m0:m0+Data.K(i)-1,t1,'ko','Markersize',18,'LineWidth',2.0), hold on
                subplot(212),
                plot(m0:m0+Data.K(i)-1,t2,'ko','Markersize',18,'LineWidth',2.0), hold on
            elseif i==2
                subplot(211), 
                plot(m0:m0+Data.K(i)-1,t1,'k+','Markersize',18,'LineWidth',2.0), hold on
                subplot(212),
                plot(m0:m0+Data.K(i)-1,t2,'k+','Markersize',18,'LineWidth',2.0), hold on
            elseif i==3
                subplot(211), 
                plot(m0:m0+Data.K(i)-1,t1,'kx','Markersize',18,'LineWidth',2.0), hold on
                subplot(212),
                plot(m0:m0+Data.K(i)-1,t2,'kx','Markersize',18,'LineWidth',2.0), hold on
            elseif i==4
                subplot(211), 
                plot(m0:m0+Data.K(i)-1,t1,'k*','Markersize',18,'LineWidth',2.0), hold on
                subplot(212),
                plot(m0:m0+Data.K(i)-1,t2,'k*','Markersize',18,'LineWidth',2.0), hold on 
            end
            if i < length(Data.K)
                m0 = m0+Data.K(i);
            end
        end        
        hold off
        subplot(211),
        axis tight
        set(gca,'box','off','FontName','Times New Roman','FontSize',24,'XTick',[]);
        ylabel('Score 1','FontName','Times New Roman','FontSize',30);
        subplot(212),
        axis tight
        set(gca,'box','off','FontName','Times New Roman','FontSize',24); 
        ylabel('Score 2','FontName','Times New Roman','FontSize',30);
        xlabel('Sample','FontName','Times New Roman','FontSize',30);
    elseif strcmp(Display(2),'4')
    end
end
if strcmp(Display(3),'1')
    n = n + 1;
    figure(n)
    if strcmp(Display(4),'2')
%         Labelcolor(1,:) = [0,1,1];
%         Labelcolor(2,:) = [0,0,.5];
%         Labelcolor(3,:) = [1,0,1];
%         Labelcolor(4,:) = [0,1,0];
%         Labelcolor(5,:) = [1,1,0];
% 
%         for ii = 1:length(Model.P)
%             hh = bar(ii,Model.P(ii,1),'w','LineWidth',5.0);
%             set(hh, 'FaceColor', Labelcolor(ii,:));
%             hold on
%         end
%         hold off
        bar(Model.P(:,1),'w','LineWidth',5.0)
        axis tight
        set(gca,'box','off','FontName','Times New Roman','FontSize',30,...
            'XTick',1:1:Data.N,'XTickLabel',Data.Index(1:1:Data.N));
        for i=1:Data.N
            fprintf('%d \t %6.5f \n',i,Model.P(i,1));
        end
        ylabel('Correlation with discriminant function','FontName','Times New Roman','FontSize',30)
        set(gca,'XTickLabelRotation',45);
    elseif strcmp(Display(4),'3')
        subplot(211), bar(Model.P(:,1),'w','LineWidth',2.0)
        axis tight
        set(gca,'box','off','FontName','Times New Roman','FontSize',24,...
            'XTick',[]);
        ylabel('Loading 1','FontName','Times New Roman','FontSize',30)
        subplot(212), bar(Model.P(:,2),'w','LineWidth',2.0)
        axis tight
        set(gca,'box','off','FontName','Times New Roman','FontSize',24,...
            'XTick',1:3:Data.N,'XTickLabel',Data.Index(1:3:Data.N));
        ylabel('Loading 2','FontName','Times New Roman','FontSize',30)
        n = n + 1;
        figure(n)
        plot(Model.P(:,1),Model.P(:,2),'k*','MarkerSize',18,'LineWidth',2.0)
        axis tight
        set(gca,'box','off','FontName','Times New Roman','FontSize',24);
        xlabel('Loading 1','FontName','Times New Roman','FontSize',30)
        ylabel('Loading 2','FontName','Times New Roman','FontSize',30)
        for i=1:Data.N
            fprintf('%d \t %6.5f \t %6.5f \n',i,Model.P(i,1),Model.P(i,2));
        end
    end
end
if strcmp(Display(5),'1')
    n = n + 1;
    figure(n)
    n = n + 1;
    figure(n)
    tmin       = min(Model.t);
    tmax       = max(Model.t);
    tran       = tmax - tmin;
    x          = (tmin - 0.25*tran):0.01:(tmax + 0.25*tran);
    f          = zeros(length(Data.K),length(x));
    F          = zeros(length(Data.K),round(length(x)/2));
    m0         = 1;
    tScaled    = (Model.t - ones(sum(Data.K),1)*mean(Model.t))/(std(Model.t));
    for i=1:length(Data.K)    
        t      = tScaled(m0:m0+Data.K(i)-1,1);
        if i<length(Data.K)
            m0 = m0 + Data.K(i);
        end
        f(i,:)      = EstimatePDF(x,t);
        [F(i,:),tf] = EstimateCDF(f(i,:),x,0.01);
        if i==1
            figure(n-1), plot(x,f(i,:),'color',[192 0 0]/256,'LineWidth',2.0), hold on
            figure(n-1), histogram(t,15,'Normalization','probability','FaceColor',[192 0 0]/256), hold on
            %figure(n-1), plot(t,ones(1,length(t))*0.01,'ro','MarkerSize',12,'LineWidth',1.0), hold on
            figure(n), plot(tf,F(i,:),'m','LineWidth',2.0), hold on
        elseif i==2
            figure(n-1), plot(x,f(i,:),'color',[0 176 80]/256,'LineWidth',2.0), hold on
            figure(n-1), histogram(t,15,'Normalization','probability','FaceColor',[0 176 80]/256), hold on
            %figure(n-1), plot(t,ones(1,length(t))*0.02,'bx','MarkerSize',15,'LineWidth',2.0), hold on
            figure(n), plot(tf,F(i,:),'c','LineWidth',2.0), hold on
        elseif i==3
            figure(n-1), plot(x,f(i,:),'m','LineWidth',2.0), hold on
            figure(n-1), plot(t,ones(1,length(t))*0.03,'m+','MarkerSize',15,'LineWidth',2.0), hold on
            figure(n), plot(tf,F(i,:),'m','LineWidth',2.0), hold on
        elseif i==4
            figure(n-1), plot(x,f(i,:),'c','LineWidth',2.0), hold on
            figure(n-1), plot(t,ones(1,length(t))*0.04,'g*','MarkerSize',12,'LineWidth',1.0), hold on
            figure(n), plot(tf,F(i,:),'c','LineWidth',2.0), hold on
        end
    end
    figure(n-1)
    hold off
    axis tight
    set(gca,'box','off','FontName','Times New Roman','FontSize',14)
    
    xlabel(PDFxlabel,'FontName','Times New Roman','FontSize',26)
    ylabel('PDF value','FontName','Times New Roman','FontSize',26)
    
    figure(n)
    plot(tf,ones(1,length(tf))*0.95,'k','LineWidth',2.0)
    hold off
    axis tight
    set(gca,'box','off','FontName','Times New Roman','FontSize',14)
    xlabel('Normalized projected score','FontName','Times New Roman','FontSize',20)
    ylabel('CDF','FontName','Times New Roman','FontSize',20)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Change direction of Type II error calculation
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    switch (changeDirection==1)
        case 1
            [~,idx1] = min(abs(F(2,:)-0.5));
            [~,idx2] = min(abs(F(1,:)-0.5));
            PDFdist = pdist([tf(idx1); tf(idx2)]);
            %Type_I = input('Type I error : ');
            Type_I = 0.05;
            Type_I = 1 - Type_I;
            for i=1:length(F(2,:))
                if F(2,i) > Type_I
                    Type_II_E = F(1,i);
                    t_crit  = tf(i);
                    break
                end
            end
            
            Type_I = 0.05;
            for i=1:length(F(1,:))
                if F(1,i) > Type_I
                    Type_II_N = 1 - F(2,i);
                    t_crit  = tf(i);
                    break
                end
            end
            
        
        otherwise
            [~,idx1] = min(abs(F(2,:)-0.5));
            [~,idx2] = min(abs(F(1,:)-0.5));
            PDFdist = pdist([tf(idx1); tf(idx2)]);
            %Type_I = input('Type I error : ');
            Type_I = 0.05;
            Type_I = 1 - Type_I;
            for i=1:length(F(1,:))
                if F(1,i) > Type_I
                    Type_II_E = F(2,i);
                    t_crit  = tf(i);
                    break
                end
            end
            
            Type_I = 0.05;
            for i=1:length(F(2,:))
                if F(2,i) > Type_I
                    Type_II_N = 1 - F(1,i-1);
                    t_crit  = tf(i);
                    break
                end
            end
    end
    %fprintf('The Type I error, was defined is : %5.4f and the critical value is : %5.4f\n',1-Type_I,t_crit);
    %fprintf('The corresponding Type II error is : %5.4f\n',Type_II_E);
    
    figure(n-1)
    if Type_II_E < 1e-2
        Type_II_E = 0;
    end
    if Type_II_N < 1e-2
        Type_II_N = 0;
    end
    
    text(.98,.95,['MCE_{12} = ',num2str(Type_II_E,2)],'Interpreter', 'tex','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','right');
    text(.98,.85,['MCE_{21} = ',num2str(Type_II_N,2)],'Interpreter', 'tex','Units','normalized','FontName','Times New Roman','FontSize',16,'HorizontalAlignment','right');
end

if strcmp(Display(6),'1')
    n = n + 1;
    figure(n)
    plot(1:Data.K(1),Model.pValueTypeI(1:Data.K(1)),'xm','MarkerSize',12,'LineWidth',2.0), hold on
    plot(Data.K(1)+1:sum(Data.K),Model.pValueTypeI(Data.K(1)+1:sum(Data.K)),'oc','MarkerSize',12,'LineWidth',2.0), hold on
    x = 0.5:0.01:(sum(Data.K)+0.5);
    plot(x,ones(size(x))*0.950,'--k','LineWidth',3.0), hold on
    plot(x,ones(size(x))*0.05,'--k','LineWidth',3.0), hold off
    axis tight
    set(gca,'box','off','FontName','Times New Roman','FontSize',14)
    xlabel('Sample','FontName','Times New Roman','FontSize',26)
    ylabel('p Value - H_0','FontName','Times New Roman','FontSize',26)
    n = n + 1;
    figure(n)
    plot(1:Data.K(1),Model.pValueTypeII(1:Data.K(1)),'xm','MarkerSize',12,'LineWidth',2.0), hold on
    plot(Data.K(1)+1:sum(Data.K),Model.pValueTypeII(Data.K(1)+1:sum(Data.K)),'oc','MarkerSize',12,'LineWidth',2.0), hold on
    x = 0.5:0.01:(sum(Data.K)+0.5);
    %plot(x,ones(size(x))*0.05,'--k','LineWidth',3.0), hold off
    axis tight
    set(gca,'box','off','FontName','Times New Roman','FontSize',14)
    xlabel('Sample','FontName','Times New Roman','FontSize',26)
    ylabel('MC error','FontName','Times New Roman','FontSize',26)
    title(CVplottitle, 'FontName','Times New Roman','FontSize',20);
    %ylim([0 .2]);
    %legend('Expert trials','Novice trials','Maximum MC error (0.05)','Location','southeast','FontName','Times New Roman','FontSize', 12);

end