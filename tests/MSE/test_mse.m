addpath('../../src/MSE/');

clear

N = 3*150;

s_ord = repmat([85 80 89], 1, N/3);
s_rnd = s_ord(randperm(length(s_ord)));

SE_ord = sample_entropy(s_ord,2,0.5);
SE_rnd = sample_entropy(s_rnd,2,0.5);

MSE_ord = my_mse(s_ord,2,0.5,10);
MSE_rnd = my_mse(s_rnd,2,0.5,10);

% figure
% subplot 221
% plot(signal_rnd)
% title("Signal aléatoire : s_1")
% subplot 223
% histogram(signal_rnd, 100)
% title("Histogram de s_1 (p_i)")
% subplot 222
% plot(signal_ord)
% title("Signal prévisible : s_2")
% subplot 224
% histogram(signal_ord, 100)
% title("Histogram de s_2 (p_i)")

