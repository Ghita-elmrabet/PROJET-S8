close all,
clear all,
clc

N=50; %nombre d'echantillions
sigma=1; %variance du BBGC
m=0; %centré
Fe=4;
Te=1/Fe;
% axe des temps
x=Te*(0:N-1);
signal=m+sigma*randn(1,N);% bruit blanc gaussien
figure(1) 
plot(x,signal)

y=zeros(1,N);
for i=1:N
    y(i)=sum(signal(1:i)-mean(signal));
end
%Calcul des valeurs des F-DFA
F_n=zeros(1,floor(N/2)-2);
for n=3:floor(N/2) % nombre de points par intervalle allant de 3 à N/2
    n_elem=floor(N/n)*n; % le plus grand multiple de n inf ou egal à N
    mat_y=reshape(y(1:n_elem),n,[]);
    mat_x=reshape(x(1:n_elem),n,[]);
    L=[];
    for i=1:size(mat_y,2)
        L=[L, regression(mat_x(:,i),mat_y(:,i))]; % decompostition du vectuer en vecteur de n elements
    end
    L=reshape(L,1,[]);
    F_n(n)=sqrt(1/n_elem*sum((L-y(1:n_elem)).^2));
    
end

%R=regression(log(1:floor(N/2)),log(F_n)); % d'apres le pdf normalement c comme ça mais ça marche pas 

R=regression(1:floor(N/2),F_n);
alpha=(log(R(2))-log(R(1)))/log(2);
figure,
hold on
loglog((1:floor(N/2)),F_n)
plot(1:floor(N/2),R);

% d'apres la doc si c un bruit blanc alpha doit valoir 0.5
