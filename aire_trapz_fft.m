
function [A]=aire_trapz_fft(k,f1,f2,signal) % pour f1 et f2 fixés, plus k est grand plus l'intervalle entre les 2 points
clc;
clear all;                                        %est petit plus la précision du calcul est élevée
%N=floor(length(signal)*64);
N=2^k;
f=-1/2:1/N:1/2-1/N;
pw_sgnal=(1/N)*abs(fftshift(fft(signal,N))).^2; % spectre de puissance
if find([f==f1],1)
%if (fnd(f1,f)==1)  % la frequence f1 est de la forme f1=k/N (appartient a f )
   x1=f1;
   A1=0;
   k1=find([f==x1],1);
else
    x1=(floor(f1*N)+1)/N; % on prend la plus petite frequence de forme k/N superieure a f1;
    k1=find([f==x1],1);
    if pw_sgnal(k1)<pw_sgnal(k1-1)
        e1=k1;
    else
        e1=k1-1;
    end
    A1=(x1-f1)/2*(pw_sgnal(k1)+min(pw_sgnal(k1),pw_sgnal(k1-1))+abs(pw_sgnal(k1)-pw_sgnal(k1-1))*(f1-f(e1))*N); 
    % approx trapezoidale de l'air de la partie 
    %comprise entre f1 et x1
    
end
if find([f==f2],1)
   x2=f2;
   A2=0;
   k2=find([f==x2]);
else
    x2=floor(f2*N)/N; % on prend la plus grande frequence de forme k/N inférieure a f2;
    k2=find([f==x2],1);
    if pw_sgnal(k2)<pw_sgnal(k2-1)
        e2=k2;
    else
        e2=k2-1;
    end
    A2=(f2-x2)/2*(pw_sgnal(k2)+min(pw_sgnal(k2),pw_sgnal(k2-1))+abs(pw_sgnal(k2)-pw_sgnal(k2-1))*(f2-f(e2))*N); 
    % approx trapezoidale de l'air de la partie 
    %comprise entre f1 et x1
end
s=0;
while(k1<=k2)
s=s+(pw_sgnal(k1+1)+pw_sgnal(k1));
k1=k1+1;
end
A=A1+A2+s/(2*N);
figure
plot(f,pw_sgnal)

end
