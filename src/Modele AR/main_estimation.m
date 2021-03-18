%% Initialisation
clear all
close all
clc;

%% Parametres

a = [1 0.8 -0.85 -0.9]; % ordre 3
%a = [1.0000   -3.7700    5.3270   -3.3436    0.7866];

% Verification stabilite
pole = roots(a)
%figure;
%zplane(pole);

p = 10;
v = 0.4;
N = 1000;
w = sqrt(v)*randn(1000,1);
x = filter(1,a,w);

%% Estimation des LARs en utilisant la reccurence de Levinson
[LAR, coefs_ref, thetap, rp] = lar_function(x, p);
thetap = [1 thetap];
%%vecteur des sigma
sigma = zeros(1,p);
sigma(1)=(rp(1))*(1-(abs(coefs_ref(1)))^2);
for i=2:1:p
    sigma(i)=(1-(abs(coefs_ref(i)))^2)*sigma(i-1);
end
%%vecteur FPE
vect_fpe=zeros(1,p);
for i=1:1:p
    [FPE]=estim_fpe(sigma,N,i);
    vect_fpe(i)=FPE;
end

%%affichage
vect_k=(1:p);
figure;
plot(vect_k,vect_fpe);
ylabel("FPE");
xlabel("ordre k supposé");
title ("critère FPE");

%%vecteur Akaike
vect_akaike=zeros(1,p);
for i=1:1:p
    [AIC]=estim_AIC(sigma,N,i);
    vect_akaike(i)=AIC;
end

%%affichage
vect_k=(1:p);
figure;
plot(vect_k,vect_akaike);
ylabel("AIC");
xlabel("ordre k supposé");
title ("critère AIC");

%%vecteur MDL
vect_mdl=zeros(1,p);
for i=1:1:p
    [MDL]=estim_MDL(sigma,N,i);
    vect_mdl(i)=MDL;
end

%%affichage
vect_k=(1:p);
figure;
plot(vect_k,vect_mdl);
ylabel("MDL");
xlabel("ordre k supposé");
title ("critère MDL");

figure;
subplot(2,2,1);
plot(vect_k,vect_fpe,'g');
ylabel("FPE");
xlabel("ordre k supposé");
title ("critère FPE");
subplot(2,2,2);
plot(vect_k,vect_akaike,'b');
ylabel("AIC");
xlabel("ordre k supposé");
title ("critère AIC");
subplot(2,2,3);
plot(vect_k,vect_mdl,'r');
ylabel("MDL");
xlabel("ordre k supposé");
title ("critère MDL");







