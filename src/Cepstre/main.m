clc
clear all
close all

%% START:

% Extract the speech signal and the sampling frequency
[signal,Fe] = audioread('speech.wav');
% Take the first channel's recorded speech
signal = signal(:,1);

t = 1/Fe:1/Fe:length(signal)/Fe;

figure,
plot(t,signal)
axis tight
xlabel('Time(s)')
ylabel('Amplitude')
title('Speech signal')


Tf = 30;         % Duration of a frame (ms)
Ts = 15;         % Duration of an overlap (ms)
alpha = 0.97;    % Pre-emphasis parameter
F = [0 Fe/2];    % Frequency boudaries (Fmax,Fmin)
M = 40;          % Number of filters in MEL Filter Bank
N = 13;          % Number of CC desired

% Extract MFCC (MATLAB ver.)
s = stft(signal,'Window',hamming(round(0.030*Fe)),'OverlapLength',round(0.015*Fe),'Centered',false);
coeffs = mfcc(s,Fe,'LogEnergy','Ignore')';

mean_coeffs = zeros(1,N);
for i = 1:N
    mean_coeffs(i) = mean(coeffs(i,:));
end

figure,
plot(coeffs,'*-')
xlabel('n')
ylabel('Coefficient')
title('MFCC (MATLAB ver.)')

figure,
plot(mean_coeffs,'*-')
xlabel('n')
ylabel('Coefficient')
title('Mean MFCC (MATLAB ver.)')

% Extract MFFC
mfcc = MFCC(signal,Fe,Tf,Ts,alpha,F,M,N);

figure,
plot(mfcc,'*-')
xlabel('n')
ylabel('Coefficient')
title('MFCC')

mean_mfcc = zeros(1,N);
for i = 1:N
    mean_mfcc(i) = mean(mfcc(i,:));
end

figure,
plot(mean_mfcc,'o-')
xlabel('n')
ylabel('Coefficient')
title('Mean MFCC')

figure,
plot_mfcc(mfcc,1E-3*Ts)
title('MFCC')

figure,
plot_mfcc(coeffs,1E-3*Ts)
title('MFCC (MATLAB ver.)')

%% END:







