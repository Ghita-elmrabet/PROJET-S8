function [SE] = my_sampen(x, m, r)
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
    SE = -log(n_d / n_n);
end

function [r] = n(x, m, r)
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