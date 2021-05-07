function [p] = predict2(signal,Fe, Tf, Ts, alpha, F, M, N)

    % THIS IS A TRIAL VERSION FOR predict FUNCTION
    %% Inputs:
    
    % signal
    % Fe: sampling frequency (Hz)
    % Tf: a frame duration (ms)
    % Ts: an overlap duartion (ms)
    % alpha: Pre-emphasis filter coefficient
    % F: Frequency boundaries (min,max)
    % Nf: number of filters in the MEL Filter Bank
    % N: number of CC
    
    %% Outputs:
    
    % p: prediction value
    
    %% START:
    
    
    [audio1,freq1] = audioread("audio1.wav");
    [audio2,freq2] = audioread("audio2.wav");
    
    
    mfcc1 = MFCC(audio1,freq1,Tf,Ts,alpha,F,M,N);
    mfcc2 = MFCC(audio2,freq2,Tf,Ts,alpha,F,M,N);
    
    smfcc = MFCC(signal,Fe,Tf,Ts,alpha,F,M,N);
   
    
    pmfcc1 = norm(smfcc-mfcc1);
    pmfcc2 = norm(smfcc-mfcc2);
    
    
    if (pmfcc1 > pmfcc2)
        p = 'audio2';
    else
        p = 'audio1';
    end
    
    disp(p)
    
    %% END.
    
end