function [SE] = sampen_analytical_bbg(sigma, r, scale_max, filtre)
    if ~exist('filtre','var')
        filtre = "moyenneur";
    end

    if strcmp(filtre, "moyenneur")
        FILTRE = @(s) coarse_graining(s);
    elseif strcmp(filtre, "butterworth")
        FILTRE = @(s) my_butterworth(s);
    else
        throw("wrong filtre name");
    end
    

    SE = zeros(1,scale_max);
    for tau = 1:scale_max
        % calc filter variance
        [b,a] = FILTRE(tau);
        [h,~] = freqz(b,a);
        sigma_f = sum((abs(h).^2))/512;
        
        SE(tau) = sampen_analytical_bbg_tau(sigma, r, tau, sigma_f);
    end
end


function [SE] = sampen_analytical_bbg_tau(sigma, r, tau, sigma_f)
    N = 30000;
    Dx = 1/5000;

    SE = 0;
    for x = ((1:N) - N/2)*Dx
        SE = SE + 1/2/sigma * sqrt(tau/2/pi) * ( erf( (x+r)/(sigma*sqrt(2*sigma_f)) ) ...
            - erf( (x-r)/(sigma*sqrt(2*sigma_f)) ) ) * exp( (-x^2*tau)/(2*sigma^2) );
    end
    SE = SE*Dx; %SE = SE*N*Dx/N;
    SE = -log(SE);
end