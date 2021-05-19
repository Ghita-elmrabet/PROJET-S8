function [p] = predict(signal,Fe, Tf, Ts, alpha, F, M, N,m,n)
    %% Inputs:
    
    % signal
    % Fe: sampling frequency (Hz)
    % Tf: a frame duration (ms)
    % Ts: an overlap duartion (ms)
    % alpha: Pre-emphasis filter coefficient
    % F: Frequency boundaries (min,max)
    % Nf: number of filters in the MEL Filter Bank
    % N: number of CC
    % m: number of samples.
    % n: number of cases
    
    %% Outputs:
    
    % p: prediction value
    
    %% START:
    
    samps = cell(1,m*n);
    freqs =[];
    
    for i=1:n
        for j=1:m
            [samp,freq] = audioread(sprintf('./audio/sounds/sound%d.wav',(i-1)*m + j));
            samps{(i-1)*m + j} = samp;
            freqs = [freqs freq];
        end
    end
    
    mfcc = zeros(size(samps,2),N);
    for i=1:n
        for j=1:m
            mfcc((i-1)*m + j,:) = MFCC(samps{(i-1)*m + j},freqs((i-1)*m + j),Tf,Ts,alpha,F,M,N);
        end
    end
    
    
    smfcc = MFCC(signal,Fe,Tf,Ts,alpha,F,M,N);
    
    pmfcc = zeros(1,size(mfcc,1));
    
    for k=1:size(mfcc,1)
        pmfcc(k) = norm(smfcc-mfcc(k,:));
    end
    p = find(pmfcc == min(pmfcc));
    
    %% END.
    
end
    
    
    
    