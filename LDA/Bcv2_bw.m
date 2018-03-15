function h = bcv2_bw(z,mv,bs)

% To select smoothing parameter for the empirical density function,
% Biased asymptotic cross validation method.

pi2=6.2831853071795864;
h0 = (4.0/(2.0*mv+1.0))^(1.0/(mv+4.0))*(bs^(-1.0/(mv+4.0)));
       opt(1) = 1;
       opt(2) = 1.e-3;
       hlow = 0.25*h0; hup = 1.5*h0;
       spr = sprintf('\n***Optimal Bandwidth range = [ %g , %g ]\n', hlow,hup);
       disp(spr);
       [h, opt] = fmin('bcv2mise',hlow,hup,opt,z,mv,bs);
       spr = sprintf('\n*** Bandwidth H = %g by BMISE CV \n', h);
       disp(spr);

