function [ pow_spectrum ] = power_spectrum(Fe, N, signal )

axe_freq = -Fe/2:Fe/N:Fe/2-Fe/N;
% Display of the power spectrum on the all signal
pow_spectrum = fftshift(abs(fft(signal).^2)/length(signal));
% Display
figure;
plot(axe_freq,pow_spectrum);
title('Power spectrum of the whole signal')
xlabel('Frequency Hz');
ylabel('Amplitude');

end

