addpath('../../src/MSE/');


clear
% close all

N = 1e4;

tau_max = 20;


Nb = 10;

SE_old = zeros(Nb,tau_max);
SE_young = zeros(Nb,tau_max);

for i=1:Nb
    i
    FANTANAME_old = ['fantasia/f1o' num2str(i,'%02.f')];
    FANTANAME_young = ['fantasia/f1y' num2str(i,'%02.f')];
    
    [samp]=rdsamp(FANTANAME_old, 2, N);
    r = 0.15*std(samp);
    [se,~] = msentropy(samp,[],[],[],[],[],[],[],tau_max);
    SE_old(i,:) = se;
    
    [samp]=rdsamp(FANTANAME_young, 2, N);
    r = 0.15*std(samp);
    [se,~] = msentropy(samp,[],[],[],[],[],[],[],tau_max);
    SE_young(i,:) = se;
end

% normalize
SE_old = SE_old / Nb;
SE_young = SE_young / Nb;

hold on;
plot(mean(SE_old,1))
plot(mean(SE_young,1))
hold off;

legend('Old', 'Young')

