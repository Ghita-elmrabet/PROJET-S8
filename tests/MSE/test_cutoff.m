addpath('../../src/MSE/');

clear
close all

% variance du bruit
sigma = 1;

% parametre cmse
s = 3;
r = 0.15*sigma;
m = 2;
tau = [2,3];
N = 4000;

x = sigma*randn(1,N);

cutoff = 0.1:0.01:0.9;

MSE = NaN(length(cutoff),length(cutoff));

for f_tau2 = 1:length(cutoff)
    for f_tau3 = 1:f_tau2
        % 1er Tau
        cut_tau2 = cutoff(f_tau2);
        [b,a] = cheby1(6,10,cut_tau2);
        x_filtered = filter(b,a,x);
        x_downsample = x_filtered(1:tau(1):end);
        SE_tau2 = my_sampen(x_downsample, m, r);
        
        %2e Tau
        cut_tau3 = cutoff(f_tau3);
        [b,a] = cheby1(6,10,cut_tau3);
        x_filtered = filter(b,a,x);
        x_downsample = x_filtered(1:tau(2):end);
        SE_tau3 = my_sampen(x_downsample, m, r);
        
        MSE(f_tau2,f_tau3) = SE_tau2+SE_tau3;
    end
end
%%

figure
surf(cutoff,cutoff,MSE);
xlabel('Cutoff pour Tau = 3')
ylabel('Cutoff pour Tau = 2')
zlabel('MultiScale Entropy')


%plot(sampen_analytical_bbg(sigma,r,s_max,FILTRE_NAME), '-')
%Legend{end} = 'Analytical';
%hold off;

%legend(Legend)
%xlabel('Scale factor')
%ylabel('SampEn')



