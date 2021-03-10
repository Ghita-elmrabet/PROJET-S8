function [A]=aire_trapeze(axe_x,signal,f1,f2)


post_f1=find((axe_x-f1)>0,1);
before_f1=find((axe_x-f1)<0,1,'last');
img_f1=(signal(post_f1)*(f1-axe_x(before_f1))+signal(before_f1)*(axe_x(post_f1)-f1))/(axe_x(post_f1)-axe_x(before_f1));
A1=(axe_x(post_f1)-f1)*(img_f1+signal(post_f1))/2;

post_f2=find((axe_x-f2)>0,1);
before_f2=find((axe_x-f2)<0,1,'last');
img_f2=(signal(post_f2)*(f2-axe_x(before_f2))+signal(before_f2)*(axe_x(post_f2)-f2))/(axe_x(post_f2)-axe_x(before_f2));
A2=(f2-axe_x(before_f2))*(img_f2+signal(before_f2))/2;

k1=post_f1;
S=0;
while(k1<=before_f2)
S=S+(signal(k1+1)+signal(k1))*(axe_x(k1+1)-axe_x(k1))/2;
k1=k1+1;
end
A=A1+A2+S;
end