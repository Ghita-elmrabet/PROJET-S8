addpath('../../src/MSE/');

clear
% close all

% variance du bruit
sigma = 1;

% parametre cmse


N = 1000;
bbg = sigma*randn(1,N);

s_max = 10;
r = 0.15*std(bbg);
m = 2;

FILTRE_NAME = 'moyenneur';

figure
hold on;
    
plot(sampen_analytical_bbg(sigma,r,s_max,FILTRE_NAME), '-')
[~, SE] = my_mse(bbg,m,r,s_max,FILTRE_NAME);
plot(SE, '-*r')
[~, SE] = my_cmse(bbg,m,r,s_max,FILTRE_NAME);
plot(SE, '-*b')
hold off;

legend("Analytical", "MSE's version", "CMSE's version")
xlabel('Scale factor')
ylabel('Sample Entropy')



