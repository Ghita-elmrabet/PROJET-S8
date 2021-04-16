clc
clear all
close all

NFFT = 1024;
K = (NFFT/2)+1;

N = 40;

[s,Fe] = audioread('speech.wav');

Tf = 25;
Nf = round(1E-3*Tf*Fe);
start = 12790;

t = start/Fe:1/Fe:(start+Nf-1)/Fe;
f = linspace(-Fe/2,Fe/2,NFFT);

s = s(:,1);
frame = s(start:start+Nf-1);


h = hamming(length(frame));
frame = h.*frame;

frame = abs(fftshift(fft(frame,NFFT)));
frame = frame(K-1:end);


f = linspace(0,Fe/2,K);
MFB = MelFilterBank(N,K,[0 Fe/2],Fe);

figure,
plot(f,MFB)
axis tight
xlabel('Frequency(Hz)')
ylabel('Amplitude')
title('MEL scale Filter Bank')


figure,
plot(f,MFB)
axis tight
xlabel('Frequency(Hz)')
ylabel('Amplitude')
hold on
plot(f,frame)
xlabel('Frequency(Hz)')
ylabel('Amplitude')

C = MFB*frame;

figure,
plot(C,'o-')
xlabel('n')
ylabel('Amplitude')
