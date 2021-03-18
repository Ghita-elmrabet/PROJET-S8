addpath('../../src/MSE/');


clear
% close all

N = 1e5;

m = 2;
tau_max = 20;

%% A CHANGER 
% POUR CHANGER LE FILTRE
% POUR CHANGER LE TYPE DE MSE
FILTRENAME = 'fenetrea';
MSEFUNC = @(samp,m,r,tau_max,FILTRENAME) my_mse(samp,m,r,tau_max,FILTRENAME);

% [CMSE, SE] = my_mse(samp,m,r,tau_max);
% plot(SE)


%% LE TEST
Nb = 5;

SE_old = zeros(Nb,tau_max);
SE_young = zeros(Nb,tau_max);

for i=1:Nb
    i
    FANTANAME_old = ['fantasia/f1o' num2str(i,'%02.f')];
    FANTANAME_young = ['fantasia/f1y' num2str(i,'%02.f')];
    
    [samp]=rdsamp(FANTANAME_old, 2, N);
    samp = samp(9e4+1:10e4);
    r = 0.15*std(samp);
    [se,~] = msentropy(samp,[],[],[],[],[],[],[],tau_max);    
    SE_old(i,:) = se;
    
    [samp]=rdsamp(FANTANAME_young, 2, N);
    samp = samp(9e4+1:10e4);
    r = 0.15*std(samp);
    [se,~] = msentropy(samp,[],[],[],[],[],[],[],tau_max);
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

