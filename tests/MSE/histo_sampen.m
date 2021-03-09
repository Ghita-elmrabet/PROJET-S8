addpath('../../src/MSE/');


clear
% close all

Nb = 100;
N = 1000;

%noise
sigma = 1;

%SampEn var
m = 2;
r = 0.15*sigma;

SE = [];
for i=1:Nb
    i
    bbg = sigma*randn(1,N);
    se = my_sampen(bbg, m, r);
    SE = [SE se];
end