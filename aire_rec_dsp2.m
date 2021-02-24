
function [A]=aire_rec_dsp2(f1,f2,pas,N,sigma)
%pas : pas à considerer entre les deux freq f1,f2
% sigma^2 varinace du bruit
% N nombre d'echantillons du bruit
f=f1:pas:f2; % vecteur des freq 

 
%géneration des poles
 theta=[7*pi/9,2*pi/9];
 R=[0.9 0.9 0.98 ];
 p1=R(1)*exp(1j*theta(1));
 p2=R(2)*exp(1j*theta(2));
 P=[p1,p2,conj(p1),conj(p2)];
 % fonction de transfert
 nom=[1,zeros(1,length(P))];
 denom=poly(P);
 n=m+sigma*randn(1,N);% bruit blanc gaussien
 p_ar=filter(nom,denom,n);

 %estimation des parametre Ai
r_x=zeros(p,1);
R_x=zeros(p,p);

 for i=1:p
     r_x(i)=r_xx(i,p_ar);
 end
 for i=1:p
     for j=1:p
     R_x(i,j)=r_xx(i-j,p_ar);
     end
 end
 Ai=-inv(R_x)*r_x;
 modules_Ai=abs(Ai); % on cosidere que le processus est reel
 
 
 %fonction de transfert estimée
 nom_estm=[1,zeros(1,p)];
 denom_estm=poly(roots([1,modules_Ai]));



% densité spectrale de puissance
 H_z=freqz(nom_estm,denom_estm,2*pi*f);
 dsp=(abs(H_z).^2)*sigma^2;
 
A=aire_rec(f(1),f(length(f)),f,dsp); 
 
%estimation de l'aire par la methode des rectangles 
function [s]=aire_rec(x1,x2,x,y) % x le vecteur des abissices , y le vecteur des cordonnées
k=find([x==x1],1);
s=0;
while(x(k)~=x2)
s=s+(x(k+1)-x(k))*y(k);
k=k+1;
end
end
%estmation de la fonction d'autocorrelation
 function [s]=r_xx(n,x)
 s=0;
 if (n<0)
    for k=1:length(x)+n
      s=s+x(k)*x(k-n);
    end    
 else
    for k=n+1:length(x)-n
        s=s+x(k)*x(k-n);
    end
 end
 end
 
end 