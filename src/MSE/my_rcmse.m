function [RCMSE, SE] = my_rcmse(x, m, r, scale_max)
    SE = zeros(1,scale_max);
    
    for s = 1:scale_max
        n_n_tot = 0;
        n_d_tot = 0;
        x_scaled = coarse_graining(x, s);
        for k = 0:(s-1)
            x_downsample = x_scaled(1+k:s:end);
            [n_n, n_d] = n(x_downsample, m, r);
            n_n_tot = n_n_tot + n_n;
            n_d_tot = n_d_tot + n_d;
        end
        SE(s) = -log(n_d_tot / n_n_tot);
    end
    RCMSE = sum(SE);
end


function [n_n, n_d] = n(x, m, r)
    n_n = 0;
    n_d = 0;
    N = length(x);
    for i = 1:N
        for j = i+1:N
            if( j+1 <= N && abs(x(i) - x(j)) < r && abs(x(i+1) - x(j+1)) < r )
                n_n = n_n+1;
                if( j+2 <= N && abs(x(i+2) - x(j+2)) < r )
                    n_d = n_d+1;
                end
            end
        end
    end
end

