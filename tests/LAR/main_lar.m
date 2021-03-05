%% Initialisation
addpath('../../src/LAR/');
clear all
close all
clc;

%% Parametres
Te = 1;            % Periode d'échantillonnage en s
Fe = 1/Te;         % Fréquence d'échantillonnage en Hz
N  = 5000;         % Nombre d echantillons du processus AR
p  = 5;            % Ordre du Processus AR

moy = 0; % Moyenne du BBGC
var = 1; % Variance du BBGC

axe_temps = 0:Te:Te*N-Te;
axe_freq  = -Fe/2:Fe/N:Fe/2-Fe/N;

RSB = 10; % Rapport signal à bruit

%% Generation d'un processus AR
% Signal utile
mod_poles = rand(1,p);                          % Les modules des poles de H(z)
par_ar    = poly(mod_poles);                    % Les paramètres AR
bruit_ent = var*randn(1,N);             % Le bruit BBGC en entrée du filtre
num       = [1 0];                              % numérateur : zeros
denom     = par_ar;                             % dénominateur : poles
H         = freqz(num, denom, 2*pi*axe_freq);   % Focntion de transfert H(z)
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
[ar_mat1, g] = lpc(y, p);
[ar_mat2, nvar, rc_mat] = aryule(y, p);
LAR_mat = rc2lar(rc_mat);


%% Affichage des résultats de calculs
fprintf("Les paramètres AR initiaux :\n");
disp(par_ar);
fprintf("Les paramètres AR estimés :\n");
disp([1,thetap]);
fprintf("Les paramètres AR estimés par matlab :\n");
disp(ar_mat1);
% fprintf("Les coefficients de réflexion :\n");
% disp(coefs_ref);
fprintf("Les Log-Area-Ratio :\n");
disp(LAR);
fprintf("Les Log-Area-Ratio par matlab :\n");
disp(LAR_mat');
