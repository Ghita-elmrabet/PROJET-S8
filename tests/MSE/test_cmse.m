addpath('../../src/MSE/');

clear
% close all

% variance du bruit
sigma = 1;

% parametre cmse
s_max = 20;
r = 0.15*sigma;
m = 2;
FILTRE_NAME = 'chebyshev';

N_all = [1000 2000 4000 10000];


figure

Legend = cell(length(N_all)+1,1);

hold on;
for i=1:length(N_all)
    N = N_all(i);
    bbg = sigma*randn(1,N);
    
    [CMSE, SE] = my_mse(bbg,m,r,s_max,FILTRE_NAME);
    plot(SE, '-*')
    Legend{i} = strcat('N=',num2str(N));
end

plot(sampen_analytical_bbg(sigma,r,s_max,FILTRE_NAME), '-')
Legend{end} = 'Analytical';
hold off;

legend(Legend)
xlabel('Scale factor')
ylabel('SampEn')



