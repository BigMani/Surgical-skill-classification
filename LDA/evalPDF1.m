function evdf = evalPDF1(znew,zbase,icv,dcov,h)
% zbase stores the training data set to form the basis of kernel functions.
% z contains the observations at which the PDF is evaluated.
pi2   = 6.2831853071795864;
nbase = length(zbase);
nnew  = length(znew);
evdf  = zeros(1,nnew);
for k = 1:nnew
   zi = znew(k);
   df = 0.0;
   for j=1:nbase
      zj=zbase(j);
      ss=(zi-zj)'*icv*(zi-zj);
      df = df + exp(-ss*0.5*h^(-2))/h;
   end
   evdf(k) = df/(nbase*pi2^(0.5)*sqrt(dcov));
end