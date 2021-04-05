clc
clear all
close all

NFFT = 1024;

[s,Fe] = audioread('speech.wav');

Tf = 25;
Nf = round(1E-3*Tf*Fe);
start = 12789;

t = start/Fe:1/Fe:(start+Nf)/Fe;
f = linspace(-Fe/2,Fe/2,NFFT);

s = s(:,1);
frame = s(start:start+Nf);

window = hamming(length(frame));
wframe = window.*frame;

frame = abs(fftshift(fft(frame,NFFT))).^2;

wframe = abs(fftshift(fft(wframe,NFFT))).^2;

figure,
plot(f,frame)
axis tight
hold on 
plot(f,wframe)
axis tight