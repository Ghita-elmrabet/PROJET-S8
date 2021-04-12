function [SE] = sampen_analytical_bbg_filtre(sigma, r, scale_max, varargin)
    FILTRE = get_filter_func_from_string(varargin);    

    SE = zeros(1,scale_max);
    for tau = 1:scale_max
        % calc filter variance
        [h,~] = FILTRE(tau);
        h = ones(1,5)/5;
        N = 40;
        %convMat = toeplitz([h(1) zeros(1,N)], [h zeros(1,N)]);
        convMat = toeplitz([h zeros(1,N)], [h(1) zeros(1,N+4)]);
        covMat = sigma*convMat*(convMat');
        [U,lambda] = eig(covMat);
        %SE(tau) = sampen_analytical_bbg_tau(sigma, r, tau, sigma_f);
        det(lambda)
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