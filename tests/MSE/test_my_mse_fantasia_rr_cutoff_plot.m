addpath('../../src/MSE/');

clear


load ("mat_fix3_fantasia_rr_cutoff_blackman_500_50.mat")
% SE dim
% Nb,co1,co2,tau_max

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

% CALC ANOVAxc
size_mse = size(MSE_old);
size_mse = [2 size_mse];
MSE = zeros(size_mse);
MSE(1,:,:,:,:) = MSE_old;
MSE(2,:,:,:,:) = MSE_young;

% MSE dim
% old,Nb,co1,co2,tau_max

anovaValue = zeros(size(MSE,3), size(MSE,4), size(MSE,5));
% anovaValue dim
% co1,co2,tau_max


for i=1:size(MSE,3)
    for j=1:size(MSE,4)
        for k=1:size(MSE,5)
            anovaValue(i,j,k) = anova1(reshape(MSE(:,:,i,j,k),2,[])', ["Old", "Young"], 'off');
        end
    end
end

best = 5.9794e-04;

figure
h=gca
surf(cuoff, cuoff, anovaValue(:,:,3))
hold on
az = surf(cuoff, cuoff, best*ones(L))
% alpha(az,0.5);
hold off
xlabel('Fréquence de cut-off pour \tau = 2')
ylabel('Fréquence de cut-off pour \tau = 3')
zlabel('p-value')
legend('Anova', 'Blackman \tau=2 N=10 et cutoff=0.25')
set(h,'zscale','log')




