function [SE] = sampen_analytical_bbg(sigma, r, scale_max)
    SE = zeros(1,scale_max);
    for tau = 1:scale_max
        SE(tau) = sampen_analytical_bbg_tau(sigma, r, tau);
    end
end


function [SE] = sampen_analytical_bbg_tau(sigma, r, tau)
    N = 30000;
    Dx = 1/5000;

    SE = 0;
    for x = ((1:N) - N/2)*Dx
        SE = SE + 1/2/sigma * sqrt(tau/2/pi) * ( erf( (x+r)/(sigma*sqrt(2/tau)) ) ...
            - erf( (x-r)/(sigma*sqrt(2/tau)) ) ) * exp( (-x^2*tau)/(2*sigma^2) );
    end
    SE = SE*Dx; %SE = SE*N*Dx/N;
    SE = -log(SE);
end