addpath('../../src/MSE/');

clear
close all

% variance du bruit
sigma = 1;

% parametre cmse
s = 3;
r = 0.15*sigma;
m = 2;
tau_max = 10

N = 4000;

x = sigma*randn(1,N);

cutoff = 0.1:0.1:0.9;

SE = zeros(1,length(cutoff));

for s=1:tau_max
    for k=1:length(cutoff)
        cut = cutoff(k);
        [b,a] = cheby1(6,10,cut);
        x_filtered = filter(b,a,x);

        x_downsample = x_filtered(1:s:end);
        SE(s,k) = my_sampen(x_downsample, m, r);

    end
end

figure
surf(cutoff,1:tau_max,SE);
xlabel('Cutoff Frequency')
ylabel('Tau')
zlabel('Sample Entropy')


%plot(sampen_analytical_bbg(sigma,r,s_max,FILTRE_NAME), '-')
%Legend{end} = 'Analytical';
%hold off;

%legend(Legend)
%xlabel('Scale factor')
%ylabel('SampEn')



