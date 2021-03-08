addpath('../../src/MSE/');


clear
% close all

N = 30000;

[samp]=rdsamp('fantasia/f1o05', 1, N);

m = 4;
r = 0.15*std(samp);
tau_max = 15;


[CMSE, SE] = my_rcmse(samp,m,r,tau_max);
plot(SE)