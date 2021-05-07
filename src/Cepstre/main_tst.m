clc
clear all
close all

%% START:

% Extract the speech signal and the sampling frequency
[signal,Fe] = audioread('speech.wav');
% Take the first channel's recorded speech
signal = signal(:,1);

Tf = 23.21;         % Duration of a frame (ms)
Ts = Tf;         % Duration of an overlap (ms)
alpha = 0.97;    % Pre-emphasis parameter
F = [0 Fe/2];    % Frequency boudaries (Fmax,Fmin)
M = 40;          % Number of filters in MEL Filter Bank
N = 13;          % Number of CC desired

s = signal(1:1024);

% Extract MFCC (MATLAB ver.)
c = mfcc(s, Fe,'WindowLength',1024,'OverlapLength',512,'NumCoeffs',12);
C = MFCC(s, Fe, Tf, Tf, alpha, F, M, N);



