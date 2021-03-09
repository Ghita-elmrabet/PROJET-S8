addpath('../../src/MSE/');


clear
% close all

N = 1e5;

m = 2;
tau_max = 20;

FILTRENAME = 'chebyshev1_nul_phase';
MSEFUNC = @(samp,m,r,tau_max,FILTRENAME) my_mse(samp,m,r,tau_max,FILTRENAME);

% [CMSE, SE] = my_mse(samp,m,r,tau_max);
% plot(SE)

Nb = 10;

SE_old = zeros(Nb,tau_max);
SE_young = zeros(Nb,tau_max);

for i=1:Nb
    i
    FANTANAME_old = ['fantasia/f1o' num2str(i,'%02.f')];
    FANTANAME_young = ['fantasia/f1y' num2str(i,'%02.f')];
    
    [samp]=rdsamp(FANTANAME_old, 2, N);
    samp = samp(9e4+1:end);
    r = 0.15*std(samp);
    [~,se] = MSEFUNC(samp,m,r,tau_max,FILTRENAME);
    SE_old(i,:) = se;
    
    [samp]=rdsamp(FANTANAME_young, 2, N);
    samp = samp(9e4+1:end);
    r = 0.15*std(samp);
    [~,se] = MSEFUNC(samp,m,r,tau_max,FILTRENAME);
    SE_young(i,:) = se;
end

% normalize
SE_old = SE_old / Nb;
SE_young = SE_young / Nb;

figure
hold on;
plot(mean(SE_old,1))
plot(mean(SE_young,1))
hold off;

legend('Old', 'Young')

