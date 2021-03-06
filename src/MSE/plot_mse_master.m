addpath('../../src/MSE/');

clear

sigma = 1;
N = 1000;
bbg = sigma*randn(1,N);

s_max = 10;
r = 0.15*std(bbg);
m = 2;

FILTRE_NAME = 'moyenneur'; % coarse graining, peut etre chang�

[~, SE] = my_mse_master(bbg,"MSE",m,r,s_max,FILTRE_NAME);
plot_mse(SE)
title('MSE')
[~, SE] = my_mse_master(bbg,"CMSE",m,r,s_max,FILTRE_NAME);
plot_mse(SE)
title('CMSE')
[~, SE] = my_mse_master(bbg,"RCMSE",m,r,s_max,FILTRE_NAME);
plot_mse(SE)
title('RCMSE')




