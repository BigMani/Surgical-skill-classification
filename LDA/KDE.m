function KDE(T1,T2)
T1 = T1';
T2 = T2';
STDG = 1;
npc  = 2;
npc1 = 1;
npc2 = 2;
%  Using smoothed bootstrap sample which is much larger than 
%  the oringinal training sample to find the confidence regions.
%  It is proved not working by numerical results.
%  The reason is because the density function is fitted based on a training
%  sample with a size of Ns. Then the CRs are produced by percentile method 
%  which takes the points as CR boder inside which there are exactly 95% or 99% points 
%  having density vaues smaller than the given values on the boders.

%  Matlab M-file program for constructing confidence region
%  and drawing the contours of the confidence region based 
%  on the maximum likelihood and bootstrap methods. 
%  This program will be called by the main program of PCA or PLS. 

%  ns --- number of samples in data set X;
%  mv --- number of variables in data set X.
%  c1 --- two row matrix storing thhe 95% CR boundary coordinate.
%  nc1 ---  number of points in c1.
%  c2 --- two row matrix storing thhe 99% CR boundary coordinate.
%  nc2 ---  number of points in c2.
%  npc ---  number of the PCs used to fit the density function.
%  npc1, npc2 --- the number of wo PCs of which the CR will be plotted.

%nx = length(Xtes(1,:));
%ny = length(Ytes(1,:));
[ns,mv] = size(T1);
nstep   = 30;
zb0     = T1';

mns = mean(zb0,2)';

for ii = 1:ns
   zboot(:,ii)=zb0(:,ii)-mns;
end
%
%   Using linear transform to Whiten the data set consisting of 
%   original PC and PC's from the bootstrap samples. ZBOOT
%
cov = zboot*zboot'/(ns-1);

[phy, ev] = eig(cov);
um = phy*ev^(-0.5);
zboot = um'*zboot;


% h is the window width (smoothing parameter) of the fitted density functiom.
% h will be evaluated by cross validation based on Integrated Squared 
% Errors Loss Function.

BSM=menu('Bandwidth Selection Methods','Multi-D Normal Bandwidth','MISE Cross Validation');
ho = zeros(1,ns);
if BSM == 1
%
%  Estimate the optimal bandwidth for d-variate normal distribution
%  to be the approximation of the optimal bandwidth based on AMISE.
%  All variances are equal to 1.0 due to the data standarzation.
%
   h = (4.0/(2.0*npc+1.0))^(1.0/(npc+4.0))*(ns^(-1.0/(npc+4.0)));
   spr = sprintf('\n*** Bandwidth H = %g of Multivariate Normal Density\n', h);
   disp(spr);
   Htitle = 'Hnorm';
elseif BSM == 2 
   h = mise_bw(zboot,npc,ns);
   Htitle = 'Hmise';
end
ho(1:ns) = ones(size(ho))*h;

if STDG == 1
   %---------------------------------------------------------------------
   %  Using equal interval to generate the density matrix.
   %  All calculation will be transformed back to original 
   %  PC's, zb0.
   %
   zboot    = zb0;
   minz     = min(zboot');
   maxz     = max(zboot');
   interval = abs(maxz-minz);
   for ii = 1:npc
      minz(ii)=minz(ii)-interval(ii)/5;
      maxz(ii)=maxz(ii)+interval(ii)/5;
   end  % To determine the range of 3-D plot of the fitted density function.
     
   %  calculate the coordinates at which the 
   %  npc-Dimension hyper-surface of the density function is drawn.

   for kv=1:npc
      dz(kv)=abs(maxz(kv)-minz(kv))/nstep;
   end
   npd=nstep+1;
   for kv=1:npc
      zcc(kv,:)=minz(kv):dz(kv):maxz(kv);
   end   
   z1=zcc(npc1,:);
   z2=zcc(npc2,:);

   %  f3d --- a npcxnpd matrix storing the values of density function
   %          calculated at coordinates zpd by MATRIXD().

   %  To plot the 3-D density function and the 2-D CRs, only two PCs can be 
   %  used in a range to calculate the density matrix while other PCs' 
   %  will have fixed values of zero, means cutting planes through the axis.
   [nc,nc] = size(cov);
   icov    = inv(cov);
   dcov    = det(cov);

   f3d     = Matrixd(zboot,ns,npc,zcc,ho,icov,dcov,npc1,npc2);
   f3d     = f3d';     %  Transposing to keep it consistent with the coordinates.
   %
   %  to draw a series of contour and find the one 
   %  which exactly excludes 2*alpha% operation points.
   %
   maxdnsty=max(max(f3d));
   mindnsty=min(min(f3d));
   %============================
   d3d = 0;
   sbs_size = [1];
   maxbs = length(sbs_size);
   zd = zeros([npc,ns]);
   for kbs = 1:maxbs
      clear zd;
      d3d   = d3d+1;
      ksize = sbs_size(kbs);
      nboot = ksize; 
      bs    = nboot*ns; 
      uv    = ones(size([1:ns]))';
      mt    = mean(T);
      tm    = uv*mt;
      if nboot == 1 
         zd = T';
      else
         for nb = 1:nboot
            Tb = resample(T);
            epsilon = randn(size(T));
            for k=1:npc
               Tb(:,k) = tm(:,k)+(Tb(:,k)-tm(:,k)+ho(k)*epsilon(:,k))/(1+ho(k)^2)^(0.5);
            end
            for k=1:ns
               zd(:,ns*(nb-1)+k) = Tb(k,:)';
            end
         end
      end
      %==================================
      %    find the contour which exactly contains (1-2alpha)% 
      %    operation points in the original matrix X by bi-section method.
   
      %   pcounter() --- works out the number of the operation points 
      %   within the contour with value of cd.  beta0=1-2*alpha;
      %   Count the numbers of the points falling in the contours
      %   until a contour containing beta0*ns operation points is found.
      %   mbeta = [0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 0.95, 0.99];
   
      evdf = evaldf(zd,zboot,icov,dcov,ho,npc1,npc2);
      mbeta = [0.9500, 0.9900];
      mcr = length(mbeta);
      sector = 2;
      cd=(maxdnsty+mindnsty)/sector;
      maxd = maxdnsty;
      mind = mindnsty;
      for ncr=1:mcr
         beta0 = mbeta(ncr);
         spr = sprintf('\n  Searching for the CR of %4.1f percent confidence\n', beta0*100);
         disp(spr);
         if ncr > 1 
            maxd = cd; 
            mind = mindnsty; 
            cd = (maxd+mind)/sector;  
         end
         beta = Pcounter(evdf,ns,cd);
         jump=1;
         while abs(beta-beta0)/beta0 > 0.005
            if beta < beta0   % too few points within the current contour of cd.
               maxd=cd;       % so the cd value is reduced.
               cd=(maxd+mind)/sector;    
            end 
            if beta > beta0   % too many points within the current contour of cd.
               mind=cd;    % so the cd value is increased.
               cd=(maxd+mind)/sector;
            end
            beta = Pcounter(evdf,ns,cd);
            spr = sprintf('\n Current BETA = %6.4f at the %gth search for BETA0 = %6.4f.', beta, jump, beta0);
            disp(spr);
            if jump >= 20
               spr = sprintf('\n  !!! The Maximum Number of searches %g Reached !!!',jump);
               disp(spr);
               break; 
            end  % Enough effort has been made.
            jump=jump+1;
         end     % of while loop.
         ch(ncr) = cd;
      end        % end of MCR loop.
   end           % end of for 'kbs = 1:maxbs' loop
end

if STDG == 1
   if d3d == 1 
      PC1 = sprintf('PC - %i',npc1);
      PC2 = sprintf('PC - %i',npc2);   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      figure;
      [x1,x2]=meshgrid(z1,z2);
      CC=del2(f3d);
      mesh(x1,x2,f3d,CC);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      spr = sprintf(' Fitted Density, %s = %g',Htitle,h);
      title(spr);
      xlabel(PC1);
      ylabel(PC2);
      zlabel('F(z)');
         
      figure;
      contour(z1,z2,f3d,35);
      title('Contours of Fitted Density Function');
      xlabel(PC1);
      ylabel(PC2);
      v1=[ch(1),ch(1)];      % Have to do it in this bizarre way.
      c1 = contourc(z1,z2,f3d,v1);
      v2=[ch(2),ch(2)];         
      c2 = contourc(z1,z2,f3d,v2);

      [~,mc2]=size(c2);
      nic=c2(2,1);
      if mc2 > nic+1;
         kc2=0;
         for k=1:mc2
            if c2(1,k) == c2(1,1)
               kc2=kc2+1;
               nc2(kc2) = k;
            end
         end
      else
         kc2=1;
         nc2(1) = 1;
      end
      [~,mc1]=size(c1);
      nic=c1(2,1);
      if mc1 > nic+1;
         kc1=0;
         for k=1:mc1
            if c1(1,k) == c1(1,1)
               kc1=kc1+1;
               nc1(kc1) = k;
            end
         end
      else
         kc1=1;
         nc1(1) = 1;
      end

      figure;
      plot(zboot(npc1,:),zboot(npc2,:),'b+');
      hold on;
   
      for k=1:kc1
         ic = c1(2,nc1(k));
         cp1=c1(:,nc1(k)+1:nc1(k)+ic);
         plot(cp1(1,:),cp1(2,:),'g-');
         hold on;
      end

      for k=1:kc2
         ic = c2(2,nc2(k));
         cp2=c2(:,nc2(k)+1:nc2(k)+ic);
         plot(cp2(1,:),cp2(2,:),'r-');
         hold on;
      end
      spr=sprintf('Training Data on CRs, Ntrain = %d', bs);
      title(spr);
      xlabel(PC1);
      ylabel(PC2);
      hold off;
   end
end
   %---------------------------------------------------------------------------
   %
   %    Test new PCs TN from data block XNEW.
   % 


