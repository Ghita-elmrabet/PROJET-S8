addpath('../../src/MSE/');
addpath('../../src/Utils/');

clear
load('mat_fix2_fantasia_rr_interval_N_1e6_16.mat');


% close all

m = 2;
tau_max = 10;

%% A CHANGER 
% POUR CHANGER LE FILTRE
% POUR CHANGER LE TYPE DE MSE
FILTRENAME = 'moyenneur';
MSEFUNC = @(samp,r) my_mse(samp,m,r,tau_max,FILTRENAME);

Fe = 250;

N_samp = 2500; % < 2800

%% LE TEST
Nb = 16;

SE_old = zeros(Nb,tau_max);
SE_young = zeros(Nb,tau_max);

for i=1:Nb
    i
    [samp] = SAMP_OLD{i};
    % samp = samp(2:end) - samp(1:end-1);
    samp = samp(1:N_samp);
    r = 0.15*std(samp);
    [~,se] = MSEFUNC(samp,r);
    SE_old(i,:) = se;

    [samp] = SAMP_YOUNG{i};
    % samp = samp(2:end) - samp(1:end-1);
    samp = samp(1:N_samp);
    r = 0.15*std(samp);
    [~,se] = MSEFUNC(samp,r);
    SE_young(i,:) = se;
end

MSE_old = ses_to_mse(SE_old);
MSE_young = ses_to_mse(SE_young);

tau_max = 10;
N = 20;

% ANOVA
MSE = zeros(2,Nb,tau_max);
MSE(1,:,:) = MSE_old;
MSE(2,:,:) = MSE_young;


anovValue = zeros(1,tau_max);
for s=1:tau_max
    anovValue(s) = anova1(MSE(:,:,s)', ["Old", "Young"], 'off');
end

fig = figure;
semilogy(anovValue)
xlabel('Scale factor')
ylabel('p-value')

