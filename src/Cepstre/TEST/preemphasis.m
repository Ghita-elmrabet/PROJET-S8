clc
clear all
close all

a = 0.97;
NFFT = 1024;

[s,Fe] = audioread('speech.wav');

Tf = 25;
Nf = round(1E-3*Tf*Fe);
start = 12790;

t = start/Fe:1/Fe:(start+Nf-1)/Fe;
f = linspace(-Fe/2,Fe/2,NFFT);

s = s(:,1);

s = s(start:start+Nf-1);
ech = abs(fftshift(fft(s,NFFT)));

sf = filter([1 -a],1,s);
pech = abs(fftshift(fft(sf,NFFT)));

figure,
plot(t,s)
axis tight
hold on
plot(t,sf)
axis tight

xlabel('Time(s)')
ylabel('Amplitude')
title('Signal before and after pre-emphasis')

figure,
plot(f,ech)
axis tight
hold on
plot(f,pech)
axis tight

xlabel('Frequency(Hz)')
ylabel('Amplitude')
title('Signal spectrum before and after pre-emphasis')



