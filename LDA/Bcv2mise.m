function lossfun = Bcv2mise(h,z,mv,bs)

%  Loss function of asymptotic MISE for Biased Cross Validation

pi2=6.2831853071795864;

cc=0.0;
for jb = 1:bs
   zj = z(:,jb);
   for ib = 1:bs
      if ib ~= jb
         zi = z(:,ib);
         zz=(zi-zj)'*(zi-zj);
         const=zz/h^2-(2*mv+4)*zz/h^2+(mv*mv+2*mv);
         cc=cc+const*exp(-zz/(h*h*2))/(pi2^(mv/2));
      end
   end
end

lossfun=1.0/(h^mv)/(pi2^(mv/2))/bs+cc/(4*bs*(bs-1))/(h^mv);

