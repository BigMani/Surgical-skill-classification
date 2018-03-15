function evdf = evaldfqc(zb0,zb,icv,dcov,h)
pi2=6.2831853071795864;
[mv,ns]=size(zb);
[mv,bs]=size(zb0);
%w0 = zeros([mv,bs]);
%w0(npc1,:) = zb0(npc1,:);
%w0(npc2,:) = zb0(npc2,:);
   for k = 1:bs
       zi = zb0(:,k);
       df = 0.0;
       for j=1:ns
          zj=zb(:,j);
          ss=(zi-zj)'*icv*(zi-zj);
          df = df + exp(-ss*0.5*h(j)^(-2))*h(j)^(-mv);
       end
       evdf(k) = df/(ns*pi2^(0.5*mv)*sqrt(dcov));
    end
   
      
    






