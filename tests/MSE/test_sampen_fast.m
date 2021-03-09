addpath('../../src/MSE/');

clear
% close all

% variance du bruit
sigma = 1;

% parametre cmse
s_max = 20;
r = 0.15*sigma;
m = 2;

X = randn(1e4,1);

tic;
[~,se2] = my_cmse(X,m,r,20);
toc

tic;
[~,se1] = my_mse(X,m,r,20);
toc

tic;
[se3,scale] = msentropy(X,[],[],[],[],[],[],[],20);
toc

figure
hold on;
plot(scale,se1)
plot(scale,se2)
plot(scale,se3)
hold off;
