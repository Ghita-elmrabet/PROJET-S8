addpath('../../src/MSE/');


clear
% close all

N = 1e5;
m = 2;
tau_max = 20;

%% A CHANGER
FILTRENAME = 'blackman';
N_SIZES = 150:10:250;
RATES = 1:0.05:1.5;


%% LE TEST
Nb = 10;

% N,rate,Nb,tau_max
SE_old = zeros(length(N_SIZES),length(RATES),Nb,tau_max);
SE_young = zeros(length(N_SIZES),length(RATES),Nb,tau_max);


for i=1:Nb
    i
    FANTANAME_old = ['fantasia/f2o' num2str(i,'%02.f')];
    FANTANAME_young = ['fantasia/f2y' num2str(i,'%02.f')];

    [samp_old]=rdsamp(FANTANAME_old, 3, N);
    samp_old = samp_old(9.7e4+1:10e4);
    r_old = 0.15*std(samp_old);
    
    [samp_young]=rdsamp(FANTANAME_young, 3, N);
    samp_young = samp_young(9.7e4+1:10e4);
    r_young = 0.15*std(samp_young);
    
    for j=1:length(N_SIZES)
        j
        N_size = N_SIZES(j);
        for k=1:length(RATES)
            rate = RATES(k);
            MSEFUNC = @(samp,m,r,tau_max) my_mse(samp,m,r,tau_max,FILTRENAME,N_size,rate);
            
            [~,se_old] = MSEFUNC(samp_old,m,r_old,tau_max);
            SE_old(j,k,i,:) = se_old;

            
            [~,se_young] = MSEFUNC(samp_young,m,r_young,tau_max);
            SE_young(j,k,i,:) = se_young;
        end
    end
end

save("my_mse_blackman_N_eleve_rate_eleve_3e3.mat");

