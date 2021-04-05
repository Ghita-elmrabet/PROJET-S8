clc
clear all
close all

NFFT = 1024;
K = NFFT/2+1;

[s,Fe] = audioread('speech.wav');
Tf = 25;
Nf = round(1E-3*Tf*Fe);
start = 12789;

t = start/Fe:1/Fe:(start+Nf)/Fe;
f = linspace(-Fe/2,Fe/2,NFFT);

s = s(:,1);
frame = s(start:start+Nf);

figure,
plot(t,frame)
axis tight

frame = abs(fftshift(fft(frame,NFFT))).^2;
frame = log(frame);

figure,
plot(f,frame)
axis tight

[h,~] = envelope(frame,15,'peak');

figure,
plot(f,h)
axis tight

e = frame-h;

figure,
plot(f,e)
axis tight
