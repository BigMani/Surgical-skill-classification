function Regression(X,y,Index,Type)
X     = X(Index,:);
y     = y(Index,:);
K     = size(X,1);
e     = zeros(1,K);
y_    = zeros(1,K);
j     = 0;
Kernel.type = 'RBF_kernel';
if strcmp(Type,'CrossValidation')
    a = 4.5;
    b = 0.0001;
    c = 7;
    R_2   = zeros(1,length(a:b:c));
    for i=a:b:c
        Kernel.para = i;    
        for k=1:K
            if k == 1
                Xtrain = X(2:K,:);
                ytrain = y(2:K,:);
            elseif k == K
                Xtrain = X(1:K-1,:);
                ytrain = y(1:K-1,:);
            else
                Xtrain = [X(1:k-1,:);X(k+1:K,:)];
                ytrain = [y(1:k-1,:);y(k+1:K,:)];
            end
            xtest = X(k,:);
            ytest = y(k,:);
            xmean = mean(Xtrain,1);
            ymean = mean(ytrain,1);
            xstd  = std(Xtrain,0,1);
            ystd  = std(ytrain,0,1);
            X0    = (Xtrain - ones(K-1,1)*xmean)/diag(xstd);
            Y0    = (ytrain - ones(K-1,1)*ymean)/diag(ystd);
            x0    = (xtest  - xmean)/diag(xstd);
            y0    = (ytest  - ymean)/diag(ystd);
            Model = KPLS(X0,Y0,5,Kernel);
            ypred = ApplyKPLSModel(X0,x0,Kernel,Model);
            e(k)  = y0 - ypred;
            y_(k) = y0;
        end
        j        = j + 1;
        R_2(j) = 1 - sum(e.^2)/sum(y_.^2);
        fprintf('%f \t %f\n',i,R_2(j));
    end
    plot(a:b:c,R_2,'k')
    set(gca,'box','off','FontName','Times New Roman','FontSize',20)
elseif strcmp(Type,'RegressionModel')
    Kernel.para = 5.3165;
    xmean = mean(X,1);
    ymean = mean(y,1);
    xstd  = std(X,0,1);
    ystd  = std(y,0,1);
    X0    = (X - ones(K,1)*xmean)/diag(xstd);
    y0    = (y - ones(K,1)*ymean)/diag(ystd);
    Model = KPLS(X0,y0,5,Kernel);
    ypred = ApplyKPLSModel(X0,X0,Kernel,Model);
    ypred = ypred*diag(ystd) + ones(K,1)*ymean;
    e     = y - ypred;
    figure(1)
    fprintf('sigma = %f, R^2 = %f\n',Kernel.para,(1-(e'*e)/(y0'*y0)));
    subplot(211), plot(y,'k-+','LineWidth',3.0,'MarkerSize',18), hold on, 
    plot(ypred,'r-.','LineWidth',3.0,'MarkerSize',18), hold off
    set(gca,'box','off','FontName','Times New Roman','FontSize',36,'XTick',[])
    title('Measured and predicted values','FontName','Times New Roman','FontSize',48)
    axis tight
    subplot(212), plot(e,'k-x','LineWidth',3.0,'MarkerSize',18)
    set(gca,'box','off','FontName','Times New Roman','FontSize',36)
    xlabel('Sample number','FontName','Times New Roman','FontSize',48)
    ylabel('Prediction error','FontName','Times New Roman','FontSize',48)
    axis tight
    figure(2)
    plot(y,ypred,'k+','MarkerSize',24,'LineWidth',3)
    set(gca,'box','off','FontName','Times New Roman','FontSize',36)
    xlabel('Measured value','FontName','Times New Roman','FontSize',48)
    ylabel('Predicted value','FontName','Times New Roman','FontSize',48)
    
end