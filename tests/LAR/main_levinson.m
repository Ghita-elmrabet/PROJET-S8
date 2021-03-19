%% Initialisation
clear all
close all
clc;

%% Parametres

a = [1 0.8 -0.85 -0.9]; % ordre 3
%a = [1.0000   -3.7700    5.3270   -3.3436    0.7866];

% Verification stabilite
pole = roots(a)
figure;
zplane(pole);

p = 10;
v = 10;
N = 1000;
w = sqrt(v)*randn(1000,1);
x = filter(1,a,w);

%% Estimation des LARs en utilisant la reccurence de Levinson
[LAR, coefs_ref, thetap] = lar_function(x, p);
thetap = [1 thetap];


%% Estimation Matlab
r = xcorr(x);
indice_max = find(r == max(r));                   
rp = r(indice_max:indice_max+p);   % not lagged values   
[ar,e,rk] = levinson(rp,numel(a)-1);
LAR_mat = rc2lar(rk);
ar_lpc = lpc(x,p)

%% Affichage des resultats de calculs
fprintf('Les parametres AR initiaux :\n');
disp(a);
fprintf('Les parametres AR estimes :\n');
disp(thetap);
fprintf('Les parametres AR estimes par la fonction levinson de Matlab :\n');
disp(ar);

fprintf('Les coefficients de reflexion issus de la fonction levinson de Matlab :\n');
disp(rk);
fprintf('Les coefficients de reflexion issus de notre fonction :\n');
disp(coefs_ref');

fprintf('Les Log-Area-Ratio :\n');
disp(LAR');
fprintf('Les Log-Area-Ratio par matlab :\n');
disp(LAR_mat);

%% Affichage graphique des resultats

x_estime = filter(1,thetap,w);
axe_temps = [0:1:length(x)-1];
axe_freq = [-1/2:1/length(x):1/2-1/length(x)];

figure(1);
subplot(2,1,1)
plot(axe_temps,x,'b','LineWidth',0.75);
hold on;
plot(axe_temps,x_estime,'r');
legend('PAR de base','PAR estime');
title('Representation temporelle des PARs');
xlabel('Temps en sec');

subplot(2,1,2)
plot(axe_freq, fftshift(fft(x)),'b','LineWidth',0.75);
hold on;
plot(axe_freq, fftshift(fft(x_estime)),'r');
legend('PAR de base','PAR estime')
title('Representation frequentielle des PARs');
xlabel('Frequence en Hz');







