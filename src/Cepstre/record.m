function [audio] = record(name,Fe)
    %% Inputs:
    
    % name: name of the recorded audio '.wav'
    % Fe: sampling frequency (Hz)
    
    %% Outputs:
    
    % audio: the recorded audio signal
    
    %% START:
    
    display('Start Recording ...')
    % Record a sound for 1s
    r = audiorecorder(Fe,16,1);
    recordblocking(r,1);         
    
    display('Stop Recording ...')
    audio = getaudiodata(r);
    audiowrite(name,audio,Fe);
    
    %% END.
end