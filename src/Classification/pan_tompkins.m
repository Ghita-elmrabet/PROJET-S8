function [ rr ] = pan_tompkins( ECG, Fe )
% pre processing
ECG_low = filter( [1,0,0,0,0,0,-2,0,0,0,0,0,1], [1,-2,1], ECG);

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

QRS = [];
for i = 1:nb
    curr_peak_loc = loc(i);
    curr_peak = ecg_m(curr_peak_loc);
    if curr_peak > THR_SIG % candidat QRS complexe
        QRS = [QRS curr_peak_loc];
        SIG_LEV = 0.125*curr_peak + 0.875*SIG_LEV;
    elseif THR_NOISE < curr_peak && curr_peak < THR_SIG %noise peak
        NOISE_LEV = 0.125*curr_peak + 0.875*NOISE_LEV;
    end
    % on ajuste les thresholds
    THR_SIG = NOISE_LEV + 0.25*(SIG_LEV - NOISE_LEV);
    THR_NOISE = 0.5*THR_SIG;
end

rr = (QRS(2:end)-QRS(1:end-1)) / Fe;
end
