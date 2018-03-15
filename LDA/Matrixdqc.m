function md = Matrixd(z,ns,mv,zpd,h,icov,dcov)
%z    = values of process data (n-dimensional vector)
%ns   = number of data points
%mv   = number of variables (principal components, latent variables etc.)
%zpc  = Gridpoints raster on each axis
%h    = standard deviation
%icov = inverse of the covariance matrix
%dcov = determinant of the covariance matrix

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

