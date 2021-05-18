addpath('../../src/MSE/');

clear

load('../../Data STAPS/Cell_Telecom.mat');
data = Donnees_Telecom2;

m = 2;
tau_max = 10;

%% A CHANGER 
% POUR CHANGER LE FILTRE
% POUR CHANGER LE TYPE DE MSE
FILTRENAME = 'moyenneur';
MSEFUNC = @(samp,r) my_mse(samp,m,r,tau_max,FILTRENAME);

N_samp = 699; % < 699
Nb_tache = 3;
Nb_sig = 8;

SE = zeros(Nb_tache,Nb_sig,tau_max);

for i=1:Nb_tache
    for j=1:Nb_sig
        s = data{j+1,i+1};
        s = s(1:N_samp);
        r = 0.15*std(s);
        [~,se] = MSEFUNC(s,r);
        SE(i,j,:) = se;
    end
end

MSE = zeros(Nb_tache,Nb_sig,tau_max);
for i=1:Nb_tache
    for j=1:Nb_sig
        MSE(i,j,:) = se_to_mse(SE(i,j,:));
    end
end

c1 = 1;
c2 = 3;

anovValue = zeros(1,tau_max);
for s=1:tau_max
    anovValue(s) = anova1(MSE([c1,c2],:,s)', ["Classe 1", "Classe 2"], 'off');
end


plot(anovValue)

