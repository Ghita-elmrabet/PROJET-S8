clear all
close all
clc;

%% Parametres
Te = 1;           % Periode d'échantillonnage en secondes
Fe = 1/Te;
N = 10000;        % Nombre d echantillons du processus AR
p = 10;            % Ordre du PAR
m = 0;            % Moyenne du BBGC
sigma_caree = 1;  % Variance du BBGC

axe_temps = 0:Te:Te*N-Te;
axe_freq = -Fe/2:Fe/N:Fe/2-Fe/N;

RSB = 10; % Rapport signal à bruit. Valeurs à tester : -5dB, 0dB, 10dB

%% Generation d'un processus AR
mod_poles = rand(1,p);                  % Les modules des poles de H(z)
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

%% Calcul utilisant les fonctions dévéloppées
% [coef, thetap] = coefRef_function(y, p);
[LAR, coefs_ref, thetap] = lar_function(y, p+1);

%% Valider l'estimation en utilisant les fcts Matlab
[ar_mat1, g] = lpc(y, p);
[ar_mat2, nvar, rc_mat] = aryule(y, p);
LAR_mat = rc2lar(rc_mat);


%% Affichage des résultats de calculs
% fprintf("Les paramètres AR initiaux :\n");
% disp(par_ar);
fprintf("Les paramètres AR estimés :\n");
disp([1,thetap]);
fprintf("Les paramètres AR estimés par matlab :\n");
disp(ar_mat1);
fprintf("Les coefficients de réflexion :\n");
disp(coefs_ref);
fprintf("Les Log-Area-Ratio :\n");
disp(LAR);
fprintf("Les Log-Area-Ratio par matlab :\n");
disp(LAR_mat');

%% Processus AR d'ordre p estimé
num_est   = [1 0];                                    % numérateur : zeros
denom_est = [1,thetap];                               % dénominateur : poles
H_est     = freqz(num_est, denom_est, 2*pi*axe_freq); % Focntion de transfert H(z) estimee

proc_ar_est = filter(num_est, denom_est, bruit_ent);  % Filtrage d un BBGC avec H(z) estimee
y_est       = proc_ar_est;

% figure,
% subplot(121), plot(axe_temps, y) 
% title('processus AR'), xlabel('temps t'), ylabel('y(t)')
% subplot(122), plot(axe_temps, y_est) 
% title('processus AR estimé'), xlabel('temps t'), ylabel('y_{estimé}(t)')