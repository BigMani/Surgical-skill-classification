function md = Matrixd(z,ns,mv,zpd,h,icov,dcov,npc1,npc2)
pi2 = 6.2831853071795864;
zi = zeros([mv,1]);
[nn,nd]=size(zpd);
for ii=1:nd
   zi(npc1) = zpd(npc1,ii);
   for jj=1:nd
      zi(npc2) = zpd(npc2,jj);
      dd = 0.0;
      for kk = 1:ns
         zk = z(:,kk);
         ss = (zi-zk)'*icov*(zi-zk);
         dd = dd+exp(-ss*0.5*h(kk)^(-2))*h(kk)^(-mv);
      end
      md(ii,jj) = dd/(sqrt(dcov)*ns*pi2^(0.5*mv));
   end
end

