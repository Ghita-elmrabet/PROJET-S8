function [mfcc] = MFCC(signal, Fe, Tf, Ts, alpha, F, M, N)
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
    % MFCC: MFCC coefficients
    
    %% START:
    nf = round(1E-3*Tf*Fe);     % Duration of the frame --> number of samples
    ns  = round(1E-3*Ts*Fe);    % Duration of the overlap --> number of samples
    
    NFFT = 2^nextpow2(nf);      % NFFT
    K = (NFFT/2)+1;
        
    % Step1: Pre-emphasis
    signal = filter([1 -alpha],1,signal);
    
    
    % Step2: Framing + Windowing
    [frames,~] = Framing(signal,nf,ns);
    
    % Step3: DFT + Square
    frames = abs(fft(frames,NFFT)).^2;
    
    % Step4: MEL Filter Bank
    [H,~] = MelFilterBank(M,K,F,Fe);   % MEL Filter Bank
    frames = H*frames(1:K,:);           % Filtered frames
    
    % Step5: log
    frames = log(frames);
    
    % Step6: DCT (eq. IDFT)
    dct = DCT(N,M); % DCT matrix
    mfcc = dct*frames; 
    
    %% END.
end

    
    
    
    
    
    