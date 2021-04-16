clc
clear all
close all


NFFT = 1024;
K = (NFFT/2)+1;
a = 0.97;

N = 13;
M = 20;

[s,Fe] = audioread('speech.wav');
s = filter([1 -a],1,s);

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
MFB = MelFilterBank(M,K,[0 Fe/2],Fe);

C = MFB*frame;
C = log(C);

dct = DCT(N,M);

MFCC = dct*C;

figure,
plot(MFCC,'o-')
xlabel('n')
ylabel('Coefficient')
title('MFCC')
