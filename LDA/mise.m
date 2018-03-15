function lossfun = mise(h,z,mv,bs)

% To select smoothing parameter for the empirical density function.
% by cross validation method based on least square algorithm,
% the loss function will be the integrated squared errors introduced 
% by Adrian W Bowman.

pi2     = 6.2831853071795864;
hh      = sqrt(2)*h;
lossfun = 1.0/(hh^mv)/(pi2^(mv/2))/(bs-1);        % N(0,2h^2)
dd      = 0.0;
cc      = 0.0;
for jb = 1:bs
   zj = z(:,jb);
   for ib = 1:bs
      if ib ~= jb
         zi = z(:,ib);
         zz=(zi-zj)'*(zi-zj);
         ex=exp(-zz/(hh*hh*2));
         dd=dd+ex;
         cc=cc+ex^2;
%     exp(-zz/(h*h*2)) = (exp(-zz/(hh*hh*2)))^2
      end
   end
end
dd = dd*(bs-2)/(bs*((bs-1)^2)*(pi2^(mv/2))*hh^mv);
cc = cc*2/(bs*(bs-1)*(pi2^(mv/2))*h^mv);
lossfun = lossfun + dd - cc;
