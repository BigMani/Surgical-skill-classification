function [t,sc,bs,cs]=CUSUM(data,score,s,s1)

l=length(data);

cssum=0;
t=1:l;
cs=1:l;
bs=1:l;
sc=1:l;
for i=1:l
    t(i)=i;
    sc(i)=data(i);
    if(data(i)<score)
        bs(i)=1;
        cssum = cssum - s;
    elseif(isnan(data(i)))
        cssum;
    elseif(data(i)>score)
        bs(i)=0;
        cssum = cssum + s1;
    end
    cs(i)=cssum;
end
end

