function[L]=regression(x,y)

%regression non lineaire
%coefs=polyfit(x,y,n);% n degré du polynome pour la regression non lineaire 
%P=polyval(coefs,x);

% regression lineaire
a=sum((x-mean(x)).*(y-mean(y)))/sum((x-mean(x)).^2);
b=mean(y)-a*mean(x);
L=a*x+b;
r_xL=mean((x-mean(x)).*(y-mean(y)))/sqrt(mean((x-mean(x)).^2)*mean((y-mean(y)).^2));
q=r_xL^2; % coef de correlation.On considère que l’approximation d’un nuage par sa droite
%des moindres carrès est de bonne qualité lorsque q est proche de 1

%figure,
%scatter(x,y)
%hold on
%plot(x,L,'r');
%plot(x,P);
end