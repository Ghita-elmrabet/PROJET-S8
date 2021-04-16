clc
clear all

NFFT = 1024;
K = NFFT/2+1;

[s,Fe] = audioread('speech.wav');

Tf = 25;
Nf = round(1E-3*Tf*Fe);
start = 12790;

t = start/Fe:1/Fe:(start+Nf-1)/Fe;
f = linspace(-Fe/2,Fe/2,NFFT);

s = s(:,1);
frame = s(start:start+Nf-1);

window = hamming(length(frame));
wframe = window.*frame;

figure,
plot(t,frame)
axis tight
hold on 
plot(t,wframe)
axis tight
xlabel('Time(s)')
ylabel('Amplitude')
title('30th frame of the speech signal')

frame = abs(fftshift(fft(frame,NFFT)));
wframe = abs(fftshift(fft(wframe,NFFT)));

figure,
plot(f,frame)
axis tight
hold on 
plot(f,wframe)
axis tight
xlabel('Frequency(Hz)')
ylabel('Amplitude')
title('Spectrum of the 30th speech signal frame')

