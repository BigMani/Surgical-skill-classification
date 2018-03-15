function h = mise_bw(z,mv,bs)

% To select smoothing parameter for the empirical density function.
% by cross validation method based on least square algorithm,
% the loss function will be the integrated squared errors introduced 
% by Adrian W Bowman.

pi2=6.2831853071795864;
h0 = (4.0/(2.0*mv+1.0))^(1.0/(mv+4.0))*(bs^(-1.0/(mv+4.0)));

hlow = 0.1*h0; hup = 5*h0;
disp('   ');
spr = sprintf('***Optimal Bandwidth range = [ %g , %g ]', hlow,hup);
disp(spr);
disp('   ');
h  = fmincon('mise',h0,[],[],[],[],hlow,hup,[],...
    optimset('MaxFunEvals',500,'TolFun',10^-4,'TolX',10^-4,'Display','off'),z,mv,bs);

disp('   ');
spr = sprintf('***  Bandwidth H = %g  by MISE Cross Validation', h);
disp(spr);
disp('   ');

