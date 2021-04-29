
data = rdsamp('fantasia/1.0.0/f1o01');


%% 

Fe = 250;
ECG = data(:,2);
rr = pan_tompkins(ECG,Fe/4);

[pks, loc] = findpeaks(rr, 'MinPeakDistance', 250/4, 'MinPeakHeight', 4);

interval_rr = filter([1,-1], 1, loc);
inter_rr_sec = interval_rr(2:end) / Fe;

figure,
plot(inter_rr_sec);
ylabel('Intervalle RR (sec)');
xlim([1, length(inter_rr_sec)]);


