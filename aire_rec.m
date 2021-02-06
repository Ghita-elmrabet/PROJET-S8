% x=[0:pi/139:pi];
% y=sin(x);
% figure,
% plot(y);
% 
% f=aire_rec1(0,pi,x,y); % donne 1.999 au lieu de 2
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
% precise/ un truc negatif est que les deux point x1 x2 qu'on va  choisir
% doivent exister dans l'axe des abscisses x. 
%Sinon on peut nous meme preciser le nombre de point a considerer dans
%l'intervalle [x1 x2] (je pense qu'on aura ainsi des frequences qui
%n'ont pas de sens par exemple si on divise l'intervalle entre 2
%frequences successives en n sous points , ce que fait la fonction
%suivante qui est plus adaptée pour des fonction mathématiques que la DSP à mon avis mdr)

function [s]=aire_rec2(x1,x2,n,f)
h=(max(x1,x2)-min(x1,x2))/n;
s=0;
x=[x1:h:x2]; 
F=f(x); % on definit la fonction a appliquer 
for j=1:n
I = I+h*F(j);
end
end
