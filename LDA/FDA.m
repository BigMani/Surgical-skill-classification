function Model = FDA(X,K,n,option)
global LDAcov;
if strcmp(option,'standardlinearFDA')
    J        = zeros(1,n);
    [m,N]    = size(X);
    T        = zeros(m,n);
    xmean    = mean(X);
    xmeank   = zeros(length(K),N);
    Sb       = zeros(N,N);
    Sw       = zeros(N,N);
    for i=1:length(K)
        if i==1
            i0    = 1;
            i1    = K(1);
        else
            i0    = i0+K(i);
            i1    = i1+K(i);
        end
        xmeank(i,:) = mean(X(i0:i1,:));
        Sb          = Sb + K(i)*(xmeank(i,:)' - xmean')*(xmeank(i,:) - xmean);
        Sw          = Sw + K(i)*cov(X(i0:i1,:));
        LDAcov = cov(X(i0:i1,:)); %Display covariance matrix
    end
    M        = pinv(Sw)*Sb;
    P        = zeros(N,n);
    for i=1:n
        p = M(:,1)/norm(M(:,1));
        error = 100;
        while error > 1e-10
            pk    = M*p;
            if i > 1
                pk    = (eye(N) - (P(:,1:i-1)/(P(:,1:i-1)'*P(:,1:i-1)))*P(:,1:i-1)')*pk;
            end
            s     = norm(pk);
            pk    = pk/s;
            error = norm(pk - p);
            p     = pk;
        end
        P(:,i) = p;
        t      = X*p;
        T(:,i) = t;
        J(i)   = p'*Sb*p/(p'*Sw*p);
    end
    Model.P  = P;
    Model.t  = T;
    Model.J  = J;
elseif strcmp(option,'cross_validation')
    [Ktotal,N]          =  size(X);
    pValueTypeI         =  zeros(1,Ktotal);
    pValueTypeII        =  zeros(1,Ktotal);
    for i=1:Ktotal
        if i==1
            Xtrain      =  X(2:Ktotal,:);
            N1          =  K(1) - 1;
            N2          =  K(2);
        elseif i==Ktotal
            N1          =  K(1);
            N2          =  K(2)-1;
            Xtrain      =  X(1:Ktotal-1,:);
        else
            Xtrain      =  [X(1:i-1,:);X(i+1:Ktotal,:)];
            if i <= K(1)
                N1      =  K(1) - 1;
                N2      =  K(2);
            else
                N1      =  K(1);
                N2      =  K(2) - 1;
            end
        end
        xtest           =  X(i,:);
        xmean           =  mean(Xtrain);
        xstd            =  std(Xtrain);
        Xtrain          =  (Xtrain - ones(Ktotal-1,1)*xmean)/diag(xstd);
        xtest           =  (xtest - xmean)/diag(xstd);
        xmean           =  mean(X);
        xmeank1         =  mean(Xtrain(1:N1,:));
        xmeank2         =  mean(Xtrain(N1+1:N1+N2,:));
        Sx1             =  cov(Xtrain(1:N1,:));
        Sx2             =  cov(Xtrain(N1+1:N1+N2,:));
        Sb              =  N1 * (xmeank1' - xmean')*(xmeank1 - xmean) + ...
                           N2 * (xmeank2' - xmean')*(xmeank2 - xmean);
        Sw              =  N1*Sx1 + N2*Sx2;
        M               = pinv(Sw)*Sb;
        P               = zeros(N,n);
        for j=1:n
            p = M(:,1)/norm(M(:,1));
            error = 100;
            while error > 1e-10
                pk    = M*p;
                if i > 1
                    pk    = (eye(N) - (P(:,1:j-1)/(P(:,1:j-1)'*P(:,1:j-1)))*P(:,1:j-1)')*pk;
                end
                s     = norm(pk);
                pk    = pk/s;
                error = norm(pk - p);
                p     = pk;
            end
            P(:,j) = p;
        end
        T          = Xtrain*P;
        Tmin       = min(T);
        Tmax       = max(T);
        Tran       = Tmax - Tmin;
        x          = (Tmin - 0.5*Tran):0.01:(Tmax + 0.5*Tran);
        TScaled    = (T - ones(sum(K)-1,1)*mean(T))/std(T);        
        t          = xtest*P;
        t          = (t - mean(T))/std(T);
        if i <= K(1)   
            T1      = TScaled(1:K(1)-1,1);
            T2      = TScaled(K(1):K(1)+K(2)-1,1);
            f1      = EstimatePDF(x,T1);
            f2      = EstimatePDF(x,T2);
            [F1,tf] = EstimateCDF(f1,x,0.01);
            [F2,~]  = EstimateCDF(f2,x,0.01);
            for j=1:length(tf)
                if t < tf(j)
                    fprintf('%d \t %5.4f \t %5.4f \t %5.4f \t %5.4f \n',i,t,tf(j),F1(j),F2(j));
                    pValueTypeI(i)  = F1(j);
                    pValueTypeII(i) = F2(j);
                    break
                end
            end
        else
            T1      = TScaled(K(1)+1:K(1)+K(2)-1,1);
            T2      = TScaled(1:K(1),1);
            f1      = EstimatePDF(x,T1);
            f2      = EstimatePDF(x,T2);
            [F1,tf] = EstimateCDF(f1,x,0.01);
            [F2,~]  = EstimateCDF(f2,x,0.01);
            for j=1:length(tf)
                if t < tf(j)
                    fprintf('%d \t %5.4f \t %5.4f \t %5.4f \t %5.4f \n',i,t,tf(j),F1(j),1-F2(j));
                    pValueTypeI(i)  = F1(j);
                    pValueTypeII(i) = 1 - F2(j);
                    break
                end
            end
        end
    end
    Model.pValueTypeI  = pValueTypeI;
    Model.pValueTypeII = pValueTypeII;
end