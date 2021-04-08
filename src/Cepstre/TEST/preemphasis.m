clc
clear all
close all

a = 0.97;
NFFT = 1024;

[s,Fe] = audioread('speech.wav');
f = linspace(-Fe/2,Fe/2,NFFT);

Tf = 25;
Nf = round(1E-3*Tf*Fe);
start = 12790;

s = s(:,1);

s = s(start:start+Nf-1);
ech = abs(fftshift(fft(s,NFFT)));

pech = filter([1 -a],1,s);
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



