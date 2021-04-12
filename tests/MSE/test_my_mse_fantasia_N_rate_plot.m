addpath('../../src/MSE/');

clear

% load ("../../figures/MSE/my_mse_blackman_N_rate.mat")
% load ("my_mse_blackman_N_rate_3e3.mat")
load ("my_mse_blackman_N_eleve_rate_eleve_3e3.mat")
% SE dim
% N,rate,Nb,tau_max

MSE_old = zeros(size(SE_old));
MSE_young = zeros(size(SE_old));

% SE TO MSE
for i=1:size(SE_old,1)
    for j=1:size(SE_old,2)
        for k=1:size(SE_old,3)
            MSE_old(i,j,k,:) = se_to_mse(reshape(SE_old(i,j,k,:),[],1));
            MSE_young(i,j,k,:) = se_to_mse(reshape(SE_young(i,j,k,:),[],1));
        end
    end
end

% CALC ANOVA
size_mse = size(MSE_old);
size_mse = [2 size_mse];
MSE = zeros(size_mse);
MSE(1,:,:,:,:) = MSE_old;
MSE(2,:,:,:,:) = MSE_young;

% MSE dim
% old,N,rate,Nb,tau_max

anovaValue = zeros(size(MSE,2), size(MSE,3), size(MSE,5));
% anovaValue dim
% N,rate,tau_max


for i=1:size(MSE,2)
    for j=1:size(MSE,3)
        for k=1:size(MSE,5)
            anovaValue(i,j,k) = anova1(reshape(MSE(:,i,j,:,k),2,[])', ["Old", "Young"], 'off');
        end
    end
end

figure
surf(N_SIZES, RATES, anovaValue(:,:,20))
xlabel('N')
ylabel('rate')
zlabel('p-value')

figure
surf(N_SIZES, RATES, anovaValue(:,:,13))
xlabel('N')
ylabel('rate')
zlabel('p-value')

figure
surf(N_SIZES, RATES, anovaValue(:,:,5))
xlabel('N')
ylabel('rate')
zlabel('p-value')






