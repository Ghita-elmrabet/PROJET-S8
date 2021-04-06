
%% START:

% Extract the speech signal and the sampling frequency
[signal,Fe] = audioread('speech.wav');
% Take the first channel's recorded speech
signal = signal(:,1);

Tf = 25;         % Duration of a frame (ms)
Ts = 10;         % Duration of an overlap (ms)
alpha = 0.97;    % Pre-emphasis parameter
F = [0 Fe/2];    % Frequency boudaries (Fmax,Fmin)
M = 20;          % Number of filters in MEL Filter Bank
N = 13;          % Number of CC desired

% Extract MFFC
[mfcc] = MFCC(signal,Fe,Tf,Ts,alpha,F,M,N);

figure,
plot(mfcc,'*-')
xlabel('n')
ylabel('Coefficients')
title('MFCC')

mean_mfcc = zeros(1,N);
for i = 1:N
    mean_mfcc(i) = mean(mfcc(i,:));
end

figure,
plot(mean_mfcc,'o-')
xlabel('n')
ylabel('Coefficients')
title('Mean MFCC')

%% END:







