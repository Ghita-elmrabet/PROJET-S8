function [MSE, SE] = my_mse_master(x, mse_ver, m, r, scale_max, varargin)
    r = std(x)*r;
    if strcmp(mse_ver, 'MSE')
        [MSE, SE] = my_mse(x, m, r, scale_max, varargin{:});
    elseif strcmp(mse_ver, 'CMSE')
        [MSE, SE] = my_cmse(x, m, r, scale_max, varargin{:});
    elseif strcmp(mse_ver, 'RCMSE')
        [MSE, SE] = my_rcmse(x, m, r, scale_max, varargin{:});
    else
        error('Wrong mse version name, use MSE, CMSE et RCMSE');
    end
end