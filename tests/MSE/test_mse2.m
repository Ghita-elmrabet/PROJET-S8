addpath('../../src/MSE/');

clear

N = 10000;
m = 2;
r = 3;

s = 5*randn(1,N);

[MSE, SE] = my_mse(s,m,r,30);
plot(SE)