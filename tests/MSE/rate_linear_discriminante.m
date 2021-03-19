clear

load ('../../figures/MSE/fantasia_bp_mat/fantasia_bp_my_mse_9e4.mat')
%load ('../../figures/MSE/fantasia_bp_mat/fantasia_bp_my_cmse_9e4.mat')
%load ('../../figures/MSE/fantasia_bp_mat/fantasia_bp_my_rcmse_9e4.mat')
%load ('../../figures/MSE/fantasia_bp_mat/fantasia_bp_my_mse_butterworth_9e4.mat')
%load ('../../figures/MSE/fantasia_bp_mat/fantasia_bp_my_mse_chebyshev1_9e4.mat')
%load ('../../figures/MSE/fantasia_bp_mat/fantasia_bp_my_mse_chebyshev2_9e4.mat')


mean_young = mean(SE_young,1);
mean_old = mean(SE_old,1);
mean_delta = abs(mean_young - mean_old);

std_young = std(SE_young, 1);
std_old = std(SE_old, 1);
std_sum = std_young + std_old;

score = mean(mean_delta ./ std_sum)