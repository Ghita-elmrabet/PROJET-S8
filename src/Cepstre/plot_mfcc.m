function [] = plot_mfcc(coeffs, OLs)
    %% Copyright: J.SOETENS
    
    %% Inputs:
    
    % coeffs: MFCCs
    % OLs: Overlap interval (s)
    
    %% Outputs:
    
    % No output.
    
    %% START:
    
    imagesc(coeffs, 'XData', [0, size(coeffs,2)*OLs], 'YData', [1, 13])
    set(gca,'YDir','normal')
    xlabel('Time(s)')
    ylabel('MFCC coefficients')
    colorbar
    
    %% END.
end