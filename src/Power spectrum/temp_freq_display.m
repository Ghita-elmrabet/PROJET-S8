function [ signal_freq ] = temp_freq_display( Fe, N, signal)
% Temporal & Frequential Display of the signal
Te = 1/Fe;
axe_temps = 0:Te:Te*N-Te;
axe_freq = -Fe/2:Fe/N:Fe/2-Fe/N;
signal_freq = fftshift(fft(signal));

%Display
figure;
subplot(2,1,1)
plot(axe_temps,signal);
title('Temporal display of the signal');
xlabel('Time  s');
ylabel('Amplitude');

subplot(2,1,2)
plot(axe_freq,signal_freq);
title('Frequential display of the signal');
xlabel('Frequency  Hz');
ylabel('Amplitude');
end

