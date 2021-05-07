function [ ] = pan_tompkins_plt( ECG, Fe )
% pre processing
ECG_low = filter( [1,0,0,0,0,0,-2,0,0,0,0,0,1]/32, [1,-2,1]/32, ECG);

ECG_high = filter( [-1/32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1/32], [1,-1], ECG_low);

ECG_deriv = filter( 0.1*[2,1,0,-1,-2], 1, ECG_high);

ECG_squared = ECG_deriv.^2;

N_window = round(0.150*Fe);
ecg_m = filter( 1/N_window*ones(N_window,1), 1, ECG_squared );

ecg_m = ecg_m(Fe:end);

% find rr interval

[pks, loc] = findpeaks(ecg_m,  'MinPeakDistance', round(0.200*Fe));
nb = length(pks);

THR_SIG = max(ecg_m(1:2*Fe))*1/3;                                          % 0.25 of the max amplitude 
THR_NOISE = mean(ecg_m(1:2*Fe))*1/2;                                       % 0.5 of the mean signal is considered to be noise
SIG_LEV= THR_SIG;
NOISE_LEV = THR_NOISE;

thr_sigs = [];
sig_levs = [];
noise_levs = [];

QRS = [];
for i = 1:nb
    curr_peak_loc = loc(i);
    curr_peak = ecg_m(curr_peak_loc);
    if curr_peak > THR_SIG % candidat QRS complexe
        QRS = [QRS curr_peak_loc];
        SIG_LEV = 0.125*curr_peak + 0.875*SIG_LEV;
    elseif curr_peak < THR_SIG %noise peak
        NOISE_LEV = 0.125*curr_peak + 0.875*NOISE_LEV;
    end
    % on ajuste les thresholds
    THR_SIG = NOISE_LEV + 0.25*(SIG_LEV - NOISE_LEV);
    
    thr_sigs = [thr_sigs THR_SIG];
    sig_levs = [sig_levs SIG_LEV];
    noise_levs = [noise_levs NOISE_LEV];
end

rr = (QRS(2:end)-QRS(1:end-1)) / Fe;

id = 409920;
span = 3000;
figure
subplot 321
plot(ECG(Fe:end))
title('Raw signal')
% xlim([id-span, id+span])
subplot 322
plot(ECG_low(Fe:end))
title('Low pass filtered')
% xlim([id-span, id+span])
subplot 323
plot(ECG_high(Fe:end))
title('High pass filtered')
% xlim([id-span, id+span])
subplot 324
plot(ECG_deriv(Fe:end))
title('Filtered with derivative filter')
% xlim([id-span, id+span])
subplot 325
plot(ECG_squared(Fe:end))
% xlim([id-span, id+span])
title('Squared')
subplot 326
plot(ecg_m);
hold on;
scatter(QRS, ecg_m(QRS))
plot(loc, thr_sigs, 'r--');
plot(loc, sig_levs, 'b--');
plot(loc, noise_levs, 'm--');
hold off;
title('Filtered with moving average filter')
% xlim([id-span, id+span])


Nb = 2000;
axe_f = 0:1/Nb:pi/2-1/Nb;
axe_w = axe_f / pi;
figure
subplot 322
[h1,w] = freqz([1,0,0,0,0,0,-2,0,0,0,0,0,1], [1,-2,1], axe_f);
semilogy(axe_w,abs(h1))
title('Low pass filter frequency response')
xlabel('Normalized frequency')
subplot 323
[h2,w] = freqz([-1/32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1/32], [1,-1], axe_f);
semilogy(axe_w,abs(h2))
title('High pass filter frequency response')
xlabel('Normalized frequency')
subplot 324
[h3,w] = freqz(0.1*[2,1,0,-1,-2], 1, axe_f);
semilogy(axe_w,abs(h3))
title('Derivative filter frequency response')
xlabel('Normalized frequency')

figure
plot(ecg_m);
hold on;
scatter(QRS, ecg_m(QRS))
plot(loc, thr_sigs, 'r--');
plot(loc, sig_levs, 'b--');
plot(loc, noise_levs, 'm--');
hold off;

legend('Integrated signal', 'R pic detected', 'Threshold', 'Signal level', 'Noise level')

end
