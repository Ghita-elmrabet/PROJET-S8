function [] = recordMyVoice(path,Fe)
    %% Inputs:
    % path: path to the recorded voice file.
    % Fe: sampling frequency (Hz)
    
    %% START:
    display('Start Speaking');
    signal = audiorecorder(Fe,16,1); 
    recordblocking(signal,2);

    display('Stop Speaking');        
    audio = getaudiodata(signal);  
    audiowrite(path,audio,Fe);
    
    figure(1),
    plot(t,audio)
    xlabel('Time (s)')
    ylabel('Signal')
    title('Signal')
    %% END.
end