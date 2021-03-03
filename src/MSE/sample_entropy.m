function [SE] = sample_entropy(x, m, r)
    phim = phi(x,m,r);
    phim1 = phi(x,m+1,r);
    
    SE = -log(phim1 / phim);
    %SE = abs(phim - phim1);
end

function [r] = phi(x, m, r)
    N = length(x);
    
    % u vectors
    u = zeros(N-m+1,m);
    for i = 1:N-m+1
        u(i,:) = x(i:i+m-1);
    end

    % Ci
    C = zeros(N-m+1,1);
    for i = 1:N-m+1
        C(i) = sum( d(u, u(i,:))<r );
    end
    
    % phi
    r = sum(C);
end

function [dist] = d(u1,u2)
    dist = max(abs(u1-u2),[],2);
end