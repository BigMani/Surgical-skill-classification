function [c,tc] = EstimateCDF(f,tf,h)
n     = length(tf)-1;
m     = floor(n/2);
c     = zeros(1,m);
tc    = zeros(1,m);
tc(1) = tf(1);
for i=1:m
    tc(i+1) = tf(2*i+1);
    c(i+1)  = c(i) + (h/3)*(f(2*i-1) + 4*f(2*i) + f(2*i+1));
end