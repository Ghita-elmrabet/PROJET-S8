addpath('../../src/MSE/');


% clear
% close all

N = 1.5e6;

m = 2;
tau_max = 20;

%% A CHANGER 
% POUR CHANGER LE FILTRE
% POUR CHANGER LE TYPE DE MSE
FILTRENAME = 'moyenneur';
MSEFUNC = @(samp,m,r,tau_max,FILTRENAME) my_mse(samp,m,r,tau_max,FILTRENAME);

% [CMSE, SE] = my_mse(samp,m,r,tau_max);
% plot(SE)


%% LE TEST
Nech = 150;

SE = zeros(Nech,tau_max);

i = 1;
FANTANAME = ['fantasia/f2o' num2str(i,'%02.f')];

[samp_full]=rdsamp(FANTANAME, 3, N);

for j=1:Nech
    j
    samp = samp_full((j-1)*1e4+1:j*1e4);
    r = 0.15*std(samp);
    [~,se] = MSEFUNC(samp,m,r,tau_max,FILTRENAME);
    SE(j,:) = se;
end

SE2 = (SE - mean(SE,1)) ./ std(SE,[],1);
hist(SE2(:),30)


