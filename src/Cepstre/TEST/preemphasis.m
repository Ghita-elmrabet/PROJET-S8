clc
clear all
close all

a = 0.97;
NFFT = 1024;

[s,Fe] = audioread('speech.wav');
f = linspace(-Fe/2,Fe/2,NFFT);

ech = s(12790:13892,1);
ech = abs(fftshift(fft(ech,NFFT)));

pech = filter([1 -a],1,ech);
pech = abs(fftshift(fft(pech,NFFT)));

figure,
plot(f,ech)
axis tight
hold on
plot(f,pech)
axis tight

xlabel('Frequency(Hz)')
ylabel('Amplitude')
title('Signal spectrum before and after pre-emphasis')



