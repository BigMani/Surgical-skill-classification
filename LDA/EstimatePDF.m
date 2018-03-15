function f = EstimatePDF(x,t)
K     = length(x);
cov_x = cov(x);
%h     = mise_bw(x,1,K);
h     = .1;
icov  = inv(cov_x);
dcov  = det(cov_x);
f     = evalPDF1(x,t,icov,dcov,h);