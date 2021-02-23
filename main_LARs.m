clear all
close all
clc;

%% Parametres
Te = 1;           % Periode d'échantillonnage en secondes
Fe = 1/Te;
N = 10000;        % Nombre d echantillons du processus AR
p = 4;            % Ordre du PAR
m = 0;            % Moyenne du BBGC
sigma_caree = 1;  % Variance du BBGC

axe_temps = 0:Te:Te*N-Te;
axe_freq = -Fe/2:Fe/N:Fe/2-Fe/N;

RSB = 10; % Rapport signal à bruit. Valeurs à tester : -5dB, 0dB, 10dB

%% Generation d'un processus AR
mod_poles = [0.92, 0.94,  0.96,  0.99]; % Les modules des poles de H(z)
par_ar    = poly(mod_poles);            % Les paramètres AR
bruit_ent = sigma_caree*randn(1,N);     % Le bruit BBGC en entrée du filtre
num       = [1 0];                      % numérateur : zeros
denom     = par_ar;                     % dénominateur : poles

H       = freqz(num, denom, 2*pi*axe_freq);   % Focntion de transfert H(z)
proc_ar = filter(num, denom, bruit_ent);      % Filtrage du BBGC avec H(z)

bruit = randn(1,N); 
Ps    = sum(proc_ar.^2)/N;                      % La puissance du signal 
Pb    = sum(bruit.^2)/N;                        % La puissance du bruit parasite
sigma_caree2   = sqrt((1/10^(RSB/10))*(Ps/Pb)); % La variance du bruit parasite
bruit_parasite = sigma_caree2*bruit;            % Bruit parasite

y = proc_ar;
% y = proc_ar + bruit_parasite; % Bruitage du processus AR

%% Estimation des parametres AR d'ordre P
r      = xcorr(y, 'biased', p+1);
maxi_r = find(r == max(r));         % L'indice du max de la correlation
rp0    = r(maxi_r:maxi_r+p-1);      % Les échantillons de 0 à P-1
Rp     = toeplitz(rp0);             % La matrice de Toeplitz
invRp  = inv(Rp);                   % L'inverse de la matrice Toeplitz
rp1    = r(maxi_r+1:maxi_r+p);      % Les échantillons de 1 à P
rp1    = rp1';

thetap = zeros(1,p);                % Les paramètres d'ordre P 
thetap(1,:) = (- invRp * rp1)';

%% Calcul du coefficient de réflexion d'ordre P+1
betap = flip(thetap);
rhop  = flip(rp1);

coef_ref(1)   = r(maxi_r+1)/r(maxi_r); % a_{1}^{(1)} = rx(1)/rx(0)
coef_ref(p+1) = (r(maxi_r+p+1) - sum(rhop.*thetap)) / (r(maxi_r) - sum(rp1.*thetap)); % a_{p+1}^{(p+1)}

%% Calcul du LAR correspondant
LAR(p+1) = log((1 + coef_ref(p+1)) / (1 - coef_ref(p+1)));

%% Processus AR estimé
num_est   = [1 0];                                    % numérateur : zeros
denom_est = [1,thetap];                               % dénominateur : poles
H_est     = freqz(num_est, denom_est, 2*pi*axe_freq); % Focntion de transfert H(z) estimee

proc_ar_est = filter(num_est, denom_est, bruit_ent);  % Filtrage d un BBGC avec H(z) estimee
y_est       = proc_ar_est;

%% Valider l'estimation en utilisant les fcts Matlab
[ar_estime, g] = lpc(proc_ar, p);

%% Affichage
fprintf("Les paramètres AR initiaux :\n");
disp(par_ar);
fprintf("Les paramètres AR estimés :\n");
disp([1,thetap]);
fprintf("Les paramètres AR estimés par matlab :\n");
disp(ar_estime);
fprintf("Les coefficients de réflexion :\n");
disp(coef_ref);
fprintf("Les Log Area Ratio :\n");
disp(LAR);

figure,
subplot(121), plot(axe_temps, y) 
title('processus AR'), xlabel('temps t'), ylabel('y(t)')
subplot(122), plot(axe_temps, y_est) 
title('processus AR estimé'), xlabel('temps t'), ylabel('y_{estimé}(t)')