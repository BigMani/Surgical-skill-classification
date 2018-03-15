function beta = Pcounter(ed,ns,cd)

%  Count the number of the points in matrix X in the contour CR.

outer_points=0;

for kk=1:ns
   if ed(kk) <= cd 
      outer_points=outer_points+1;
   end
end
beta=(ns-outer_points)/ns;
