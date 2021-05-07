addpath('../../src/MSE/');
addpath('../../src/Utils/');

clear
load('mat_fix2_fantasia_rr_interval_N_1e6_16.mat');


% close all

m = 2;
tau_max = 3;

N_samp = 200; % < 2800
N = 10;


%% A CHANGER 
% POUR CHANGER LE FILTRE
% POUR CHANGER LE TYPE DE MSE
FILTRENAME = 'blackman_coff';
MSEFUNC = @(samp,r,coff) my_rcmse(samp,m,r,tau_max,FILTRENAME,coff,N);

Fe = 250;

cuoff = 0.05:0.05:0.5;
L = length(cuoff);

%% LE TEST
Nb = 16;

SE_old = zeros(Nb,L,L,tau_max);
SE_young = zeros(Nb,L,L,tau_max);

for i=1:Nb
    i
    for j=1:L
        for k=j+1:L
            coff = [0.5 cuoff(j) cuoff(k)];
            
            [samp] = SAMP_OLD{i};
            %samp = samp(2:end) - samp(1:end-1);
            samp = samp(1:N_samp);
            r = 0.15*std(samp);
            [~,se] = MSEFUNC(samp,r,coff);
            SE_old(i,j,k,:) = se;

            [samp] = SAMP_YOUNG{i};
            %samp = samp(2:end) - samp(1:end-1);
            samp = samp(1:N_samp);
            r = 0.15*std(samp);
            [~,se] = MSEFUNC(samp,r,coff);
            SE_young(i,j,k,:) = se;
        end
    end
end


save('mat_fix3_rcmse_fantasia_rr_cutoff_blackman_200_10.mat');