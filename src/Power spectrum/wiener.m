function [dsp]=wiener(f,signal,n)

r_xx=xcorr(signal,'biased');
dsp=fft(r_xx,n);
dsp=abs(dsp);
figure(2)
plot(f,dsp,'DisplayName','Densité spectrale de puissance du signal (Wiener Khinchin)')
xlabel('Axe des fréquences');
ylabel('Amplitudes');
end