clc
clear all

[s,Fe] = audioread('speech.wav');

Tf = 25;
Nf = round(1E-3*Tf*Fe);
start = 12789;

t = start/Fe:1/Fe:(start+Nf)/Fe;

s = s(:,1);
frame = s(start:start+Nf);

window = hamming(length(frame));
wframe = window.*frame;

figure,
plot(t,frame)
axis tight
hold on 
plot(t,wframe)
axis tight
