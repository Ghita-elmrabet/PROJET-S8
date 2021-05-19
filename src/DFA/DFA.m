function [alpha]=DFA(x,signal)

y=zeros(1,length(signal));
for i=1:length(signal)
    y(i)=sum(signal(1:i)-mean(signal)); % integration du signal
end
%Calcul des valeurs des F-DFA
F_n=zeros(1,floor(length(signal)/2)-2);
for n=3:floor(length(signal)/2) % nombre de points par intervalle allant de 3 à N/2
    n_elem=floor(length(signal)/n)*n; % le plus grand multiple de n inf ou egal à N
    mat_y=reshape(y(1:n_elem),n,[]);
    mat_x=reshape(x(1:n_elem),n,[]);
    L=[];
    for i=1:size(mat_y,2)
        L=[L, regression(mat_x(:,i),mat_y(:,i))]; % decompostition du vecteur en vecteur de n elements
    end
    L=reshape(L,1,[]);
    F_n(n)=sqrt(1/n_elem*sum((L-y(1:n_elem)).^2));
    
end

R=regression(log(3:floor(length(signal)/2)),log(F_n(3:end))); 

alpha=(R(2)-R(1))/(log(4)-log(3));
signal

figure,
hold on
plot(log(3:floor(length(signal)/2)),log(F_n(3:end)))
plot(log(3:floor(length(signal)/2)),R);
end
