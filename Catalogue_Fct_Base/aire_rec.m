function [ s ] = aire_rec( k,x1,x2,x,y )
N=2^k;
x1_axe=(floor(x1*N)+1)/N
x2_axe=(floor(x2*N)+1)/N
k=find([x==x1_axe],1);
s=0;
     while(x(k)~=x2_axe)
         s=s+(x(k+1)-x(k))*y(k);
         k=k+1;
     end
end
 