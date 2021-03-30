clc
clear all
close all

N = 2E5;
Fe = 44100;

Tf=25;
Ts=10;
alpha=0.998;
R = [100 5000];
M = 20;
C = 13;
L = 22;


hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));

%recordMyVoice('audio.wav',Fe);
[signal,Fe]=audioread('audio.wav');
%signal = randn(N,1);

TL = length(signal)/Fe;
t=0:1/Fe:TL-1/Fe;

signalF = filter([1 -alpha],1,signal);
figure(1),     
plot(t,signalF)
axis tight
xlabel('Time(s)')
ylabel('Amplitude')
title('Pre-emphasized Signal')

[mfcc,frames,indexes] = MFCC(signal, Fe, Tf, Ts, alpha, hamming, R, M, C, L );

figure(8),
plot(mfcc)
xlabel('Coefficients')
ylabel('Amplitude')
title('MFCCs')

NFFT = 2^12;
K = (NFFT/2)+1;

[H,f] = MelFilterBank(M,K,[0 Fe/2],Fe);
figure(9),
plot(f,H)
xlabel('Frequency (Mel)')
ylabel('Amplitude')
title('MEL scale Filter-Bank')

figure(10),
plot(t,signal)
axis tight
xlabel('Time(s)')
ylabel('Amplitude')
title('Signal')




