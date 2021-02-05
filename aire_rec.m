x=[0:pi/139:pi];
y=sin(x);
figure,
plot(y);

f=aire_rec1(0,pi,x,y); % donne 1.999 au lieu de 2
%methode des rectangles
function [s]=aire_rec1(x1,x2,x,y) % x le vecteur des abissices , y le vecteur des cordonnées
k=find([x==x1],1);
s=0;
while(x(k)~=x2)
s=s+(x(k+1)-x(k))*y(k);
k=k+1;
end
end
% ==> la precision de cette methode depend du nombre d'abssices, plus le
% nombre d'element appartenant à [x1 x2] est grand plus la fonction est
% precise
%Sinon on peut nous meme preciser le nombre de point a considerer dans
%l'intervalle [x1 x2] comme suivant:
function [s]=aire_rec2(x1,x2,n,f)
h=(max(x1,x2)-min(x1,x2))/n;
s=0;
x=[x1:h:x2];
F=f(x); % on definit la fonction a appliquer 
for j=1:n
s = s+h*F(j);
end
end
