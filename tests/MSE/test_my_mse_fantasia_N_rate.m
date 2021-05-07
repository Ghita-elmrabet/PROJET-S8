addpath('../../src/MSE/');


clear
load('mat_fix2_fantasia_rr_interval_N_1e6_16.mat');
% close all

N = 1e5;
m = 2;
tau_max = 5;

%% A CHANGER
FILTRENAME = 'blackman_rate';
N_SIZES = 50:10:150;
RATES = 0.75:0.05:1.25;

MSEFUNC = @(samp,r,rate,N_size) my_mse(samp,m,r,tau_max,FILTRENAME,rate,N_size);

%% LE TEST
Nb = 16;

% N,rate,Nb,tau_max
SE_old = zeros(length(N_SIZES),length(RATES),Nb,tau_max);
SE_young = zeros(length(N_SIZES),length(RATES),Nb,tau_max);


for i=1:Nb
    i
    [samp_old] = SAMP_OLD{i};
    samp_old = samp_old(1:2500);
    r_old = 0.15*std(samp_old);
    
    [samp_young] = SAMP_YOUNG{i};
    samp_young = samp_young(1:2500);
    r_young = 0.15*std(samp_young);
    
    for j=1:length(N_SIZES)
        j
        N_size = N_SIZES(j);
        for k=1:length(RATES)
            rate = RATES(k);
            
            [~,se_old] = MSEFUNC(samp_old,m,r_old,tau_max);
            SE_old(j,k,i,:) = se_old;

            [~,se_young] = MSEFUNC(samp_young,m,r_young,tau_max);
            SE_young(j,k,i,:) = se_young;
        end
    end
end

save("my_mse_blackman_fantasia_2500.mat");

