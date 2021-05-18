addpath('../../src/MSE/');

clear


load ("mat_fix3_fantasia_rr_cutoff_blackman_2500_50.mat")
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

moyTau2 = 0.0020;
moyTau3 = 0.0010;
blackmanTau2 = 9.1066e-04;
blackmanTau3 = 0.0026;


figure
sem1 = semilogy(cuoff, anovaValue(:,L,2));
hold on
sem2 = semilogy(cuoff, ones(1,L)*moyTau2);
sem3 = semilogy(cuoff, ones(1,L)*moyTau3);
sem4 = semilogy(cuoff, ones(1,L)*blackmanTau2);
sem5 = semilogy(cuoff, ones(1,L)*blackmanTau3);
hold off
legend([sem1(1),sem2(1),sem3(1),sem4(1),sem5(1)], 'Anova','Filtre moyenneur \tau=2','Filtre moyenneur \tau=3','Blackman \tau=2','Blackman \tau=3')
xlabel('Fréquence de cut-off pour \tau = 2')
ylabel('p-value')



