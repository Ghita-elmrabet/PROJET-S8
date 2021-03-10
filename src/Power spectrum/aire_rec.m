function [A]=aire_rec(axe_x,signal,f1,f2)

if find(round(axe_x,4)==f1,1)
k1=find(round(axe_x,4)==f1,1);
A1=0;
else
post_f1=find((axe_x-f1)>0,1);
before_f1=find((axe_x-f1)<0,1,'last');
A1=signal(before_f1)*(axe_x(post_f1)-f1);
k1=post_f1;
end

if find(round(axe_x,4)==f2,1)
k2=find(round(axe_x,4)==f2,1);
A2=0;
else
before_f2=find((axe_x-f2)<0,1,'last');
A2=signal(before_f2)*(f2-axe_x(before_f2));
k2=before_f2;
end

S=0;
while(k1<k2)
S=S+(signal(k1)*(axe_x(k1+1)-axe_x(k1)));
k1=k1+1;
end
A=A1+A2+S;

end