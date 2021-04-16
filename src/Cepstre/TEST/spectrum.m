clc
clear all
close all

NFFT = 1024;
K = NFFT/2+1;
a = 0.97;

[s,Fe] = audioread('speech.wav');
Tf = 25;
Nf = round(1E-3*Tf*Fe);
start = 12790;

t = start/Fe:1/Fe:(start+Nf-1)/Fe;
f = linspace(-Fe/2,Fe/2,NFFT);

s = s(:,1);
frame = s(start:start+Nf-1);

figure,
plot(t,frame)
axis tight
xlabel('Time(s)')
ylabel('Amplitude')
title('30th frame of the speech signal')

frame = abs(fftshift(fft(frame,NFFT)));
frame = log(frame);

figure,
plot(f,frame)
axis tight
xlabel('Frequency(Hz)')
ylabel('log(|S(f)|)')
title('Speech signal logarithmic spectrum')

[h,~] = envelope(frame,15,'peak');

figure,
plot(f,h)
axis tight
xlabel('Frequency(Hz)')
ylabel('log(|H(f)|)')
title('Envelope')

e = frame-h;

figure,
plot(f,e)
axis tight
xlabel('Frequency(Hz)')
ylabel('log(|E(f)|)')
title('Excitation')
