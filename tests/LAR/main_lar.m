%% Initialisation
addpath('../../src/LAR/');
clear all
close all
clc;

%% Paramètres
Te = 1;            % Periode d'échantillonnage en s
Fe = 1/Te;         % Fréquence d'échantillonnage en Hz
N  = 1000;         % Nombre d echantillons du processus AR
p  = 5;            % Ordre du Processus AR

moy = 0; % Moyenne du BBGC
sigma_caree = 1; % Variance du BBGC

axe_temps = 0:Te:Te*N-Te;
axe_freq  = -Fe/2:Fe/N:Fe/2-Fe/N;
RSB = 10; % Rapport signal à bruit. à tester : -5dB, 0dB, 10dB

%% Generation d'un processus AR
% Signal utile
% modu_poles = -1+2*rand(1,p);                          
% modu_poles = rand(1,p);                         
% modu_poles = [0.999,0.99,-0.9,0.9];   % -> mauvaise estimation
% modu_poles = [0.1,0.7,-0.8,0.9];      % -> bonne estimation
modu_poles = [0.68,0.72,-0.75,0.7];     % -> bonne estimation

par_ar    = poly(modu_poles);                    % Les paramètres AR

bruit_ent = sigma_caree*randn(1,N);             % Le bruit BBGC en entrée du filtre
num       = [1 0];                              % numérateur : zeros
denom     = par_ar;                             % dénominateur : poles
H         = freqz(num, denom, 2*pi*axe_freq);   % Focntion de transfert H(z)
phi       = phasez(num, denom, 2*pi*axe_freq);
proc_ar   = filter(num, denom, bruit_ent);      % Filtrage du BBGC avec H(z)

% Bruitage du signal
bruit          = randn(1,N); 
Ps             = sum(proc_ar.^2)/N;             % La puissance du signal 
Pb             = sum(bruit.^2)/N;               % La puissance du bruit parasite
sigma_caree2   = sqrt((1/10^(RSB/10))*(Ps/Pb)); % La variance du bruit parasite
bruit_parasite = sigma_caree2*bruit;            % Bruit parasite

% --> Choix de l'un des 2
y = proc_ar;
% y = proc_ar + bruit_parasite; 

%% Estimation des LARs en utilisant la réccurence de Levinson
[LAR, coefs_ref, thetap] = lar_function(y, p);

%% Valider l'estimation en utilisant les fonctions pré-définies dans MATLAB
[ar_mat1, g]            = lpc(y, p);
[ar_mat2, nvar, rc_mat] = aryule(y, p);
LAR_mat                 = rc2lar(rc_mat);
[r,lg]  = xcorr(y,'biased');
r(lg<0) = [];
ar_mat3                 = levinson(r, p);

%% Affichage des résultats de calculs
fprintf("Les paramètres AR initiaux :\n");
disp(par_ar);
fprintf("Les paramètres AR estimés :\n");
disp([1,thetap]);
fprintf("Les paramètres AR estimés par matlab (lpc):\n");
disp(ar_mat1);
% fprintf("Les paramètres AR estimés par matlab (aryule):\n");
% disp(ar_mat2);
% fprintf("Les paramètres AR estimés par matlab (levinson):\n");
% disp(ar_mat3);
% fprintf("Les coefficients de réflexion :\n");
% disp(coefs_ref);
fprintf("Les Log-Area-Ratio :\n");
disp(LAR);
fprintf("Les Log-Area-Ratio par matlab :\n");
disp(LAR_mat');

%% Processus AR d'ordre p estimé : reconstruction du processus AR
num_est   = [1 0];                                    % numérateur : zeros
denom_est = [1,thetap];                               % dénominateur : poles
Hest     = freqz(num_est, denom_est, 2*pi*axe_freq); % Focntion de transfert H(z) estimee
phi_est   = phasez(num_est, denom_est, 2*pi*axe_freq);

nv_bruit_ent = sigma_caree*randn(1,N);             % Le bruit BBGC en entrée du filtre
% proc_ar_est = filter(num_est, denom_est, bruit_ent);  % Filtrage d un BBGC avec H(z) estimee
proc_ar_est = filter(num_est, denom_est, nv_bruit_ent);  % Filtrage d un BBGC avec H(z) estimee
yest       = proc_ar_est;


%% Aspect énergétique des PARs
Yf = fftshift(abs(fft(y)));
DSPy = sigma_caree*(abs(H).^2);
Ps = (fftshift(abs(fft(y))).^2)/N;

Yfest = fftshift(abs(fft(yest)));
DSPyest = sigma_caree*(abs(Hest).^2);
Psest = (fftshift(abs(fft(yest))).^2)/N;

%% Mesure de similarité entre les signaux 
% Les périodogrammes des deux signaux
[Py, contenu_freq]       = periodogram(y,[],[],Fe,'power');
[Pyest, contenu_freqest] = periodogram(yest,[],[],Fe,'power');

% Log-spectral distance
DLS = sqrt(mean((10*log10(Ps./Psest)).^2));

% L'intercorrélation entre les deux signaux 
Rxy = xcorr(y, yest);

%% Affichage
% figure,
% plot(Rxy, 'r-')

% Contenus fréquentiels des deux signaux
figure,
subplot(2,2,1), plot(axe_temps,y,'k'), title("y(t)"), xlabel('temps (s)'), grid on
subplot(2,2,3), plot(axe_temps,yest), ylabel('y_{estimé}(t)'), xlabel('temps (s)'), grid on
subplot(2,2,2), plot(contenu_freq,Py,'k'), title('Spectre de puissance'), ylabel('P1(f)'), grid on, axis tight
subplot(2,2,4), plot(contenu_freqest,Pyest), xlabel('Frequence (Hz)'), ylabel('P2(f)'), grid on, axis tight

figure,
subplot(121), plot(axe_freq, DSPy, 'r'), title('DSP du PAR'), xlabel('f_n')
subplot(122), plot(axe_freq, DSPyest, 'r'), title('DSP du PAR'), xlabel('f_n')

% figure,
% subplot(221), plot(axe_temps, y), title("PAR d'ordre P"), xlabel('t')
% subplot(222), plot(axe_freq, Yf), title("la fft du PAR"), xlabel('f_n')
% subplot(223), plot(axe_freq, DSPy, 'r'), title('DSP du PAR'), xlabel('f_n')
% subplot(224), plot(axe_freq, Ps), title("Spectre de puissance du PAR"), xlabel("f_n")

% figure,
% plot(axe_temps, y) 
% hold on
% plot(axe_temps, y_est) 
% xlabel('temps t'), ylabel('y_{estimé}(t)')
% legend('y(t)', 'y_{estimé}(t)')

% figure,
% subplot(131),
% plot(axe_freq, 20*log10(abs(H))) 
% hold on
% plot(axe_freq, 20*log10(abs(H_est)))
% legend('Le filtre initial', 'Le filtre estimé')
% ylabel("L'amplitude en dB"), xlabel('fréquence normalisée')
% grid
% subplot(132),
% plot(axe_freq, phi) 
% hold on
% plot(axe_freq, phi_est)
% legend('Le filtre initial', 'Le filtre estimé')
% ylabel("La phase en rad"), xlabel('fréquence normalisée')
% grid
% subplot(133),
% zplane(num, denom)