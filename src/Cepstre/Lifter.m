function [lifter] = Lifter(N,L)
    %% Inputs:
    % N: number of CC
    % L: length of the signal vector
    
    %% Outputs:
    % lifter
    
    %% START:
    lifter = 1+0.5*L*sin(pi*[0:N-1]/L);
    %% END.
end
