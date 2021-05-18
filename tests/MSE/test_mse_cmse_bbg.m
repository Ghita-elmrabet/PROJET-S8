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


hold on;
    
    
[~, SE] = my_mse(bbg,m,r,s_max,FILTRE_NAME);
plot(SE, '-*')
[~, SE] = my_cmse(bbg,m,r,s_max,FILTRE_NAME);
plot(SE, '-*')
[~, SE] = my_rcmse(bbg,m,r,s_max,FILTRE_NAME);
plot(SE, '-*')
plot(sampen_analytical_bbg(sigma,r,s_max,FILTRE_NAME), '-')
hold off;

legend("MSE's version", "CMSE's version", "RCMSE's version", "Analytical")
xlabel('Scale factor')
ylabel('Sample Entropy')



