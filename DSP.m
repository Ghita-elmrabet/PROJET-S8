function [D]=DSP(signal,N)
autocorr=xcorr(signal);
D=fftshift(abs(fft(autocorr,N))); %on considere que f=-1/2:1/N:1/2-1/N;
end