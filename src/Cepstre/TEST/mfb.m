clc
clear all
close all

NFFT = 1024;
K = (NFFT/2)+1;

N = 20;

[s,Fe] = audioread('speech.wav');

Tf = 25;
Nf = round(1E-3*Tf*Fe);
start = 12789;

t = start/Fe:1/Fe:(start+Nf)/Fe;
f = linspace(-Fe/2,Fe/2,NFFT);

s = s(:,1);
frame = s(start:start+Nf);



h = hamming(length(frame));
frame = h.*frame;

frame = abs(fftshift(fft(frame,NFFT))).^2;
frame = frame(K-1:end);


f = linspace(0,Fe/2,K);
MFB = MelFilterBank(N,K,[0 Fe/2],Fe);

figure,
plot(f,MFB)
axis tight
hold on
plot(f,frame)

C = MFB*frame;

figure,
plot(C,'o-')
