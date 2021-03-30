function [MFCC,frames,indexes] = MFCC(signal, Fe, Tf, Ts, alpha, window, F, Nf, N, l)
    %% Inputs:
    % signal
    % Fe: sampling frequency (Hz)
    % Tf: a frame duration (ms)
    % Ts: a frame movement step (ms)
    % alpha: Pre-emphasis filter coefficient
    % window
    % F: Frequency boundaries (min,max)
    % Nf: number of frames
    % N: number of CC
    % l: liftering parameter
    
    %% Outputs:
    % MFCC: MFCC coefficients
    
    %% START:
    nf = round(1E-3*Tf*Fe);     % Duration of the frame
    ns  = round(1E-3*Ts*Fe); % Step of the frame's movement
    
    NFFT = 2^nextpow2(nf);
    K = (NFFT/2)+1;
        
    % Filtered signal:
    signalF = filter([1 -alpha],1,signal);
    
    
    % Framing + Windowing the signal:
    [frames,indexes] = Framing(signalF,Fe,nf,ns,window);
    
    % Calculate the DSP of each frame:
    DSPofFrames = abs(fft(frames,NFFT));
    figure(4),
    plot(DSPofFrames(:,100))
    axis tight
    xlabel('Frequency')
    ylabel('|FFT|')
    title('|FFT| of the 100th windowed frame')
    
    % Use the MEL Filter Bank for each frame:
    H = MelFilterBank(Nf,K,F,Fe); % MEL Filter Bank
    framesF = H*DSPofFrames(1:K,:); % Filtered frames
    figure(5),
    plot(framesF(:,100))
    axis tight
    xlabel('Frequency')
    ylabel('Filtered DSP')
    title('Filtered DSP of the 100th windowed frame (MEL Filter-Bank)')
    
    % Apply DCT Transformation:
    dct = DCT(N,Nf); % DCT matrix
    MFCC = dct*log(framesF); 
    figure(6),
    plot(MFCC(:,100))
    xlabel('Coefficients')
    ylabel('Amplitude')
    title('MFCCs after DCT transformation')
    % Cepstral lifter:
    lifter = Lifter(N,l);
    
    % MFCC:
    MFCC = diag(lifter)*MFCC;
    figure(7),
    plot(MFCC(:,100))
    xlabel('Coefficients')
    ylabel('Amplitude')
    title('MFCCs after Liftering')
    %% END.
end

    
    
    
    
    
    