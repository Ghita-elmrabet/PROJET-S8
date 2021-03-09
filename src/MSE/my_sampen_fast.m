function [SaEn] = my_sampen_fast(sig, dim, r)
%
% [SaEn, Phi, Phi1] = saen_range(dim,r,sig)
%
%
% SAMPLE ENTROPY
% computed with the kdtree method.
%
% This code creates and uses a kdtree to solve an orthogonal range
% problem, as proposed by [*1] and [*2].
% The kdtree is the default search method when the number of
% columns of the space matirx X, is not greater than 10.
% Otherwise, the default is 'exhaustive', that is:
% the distances from all points to each point are
% computed to find nearest neighbors.
%
% INPUTS :
%
% dim : is equal to m. Entropy will be compute for dim and
% dim + 1 (or m and m + 1, embedded dimenions)
% r : tolerance in the search for matches*, typically set as :
%     0.2*std(sig)
% sig: signal of which one wants to compute the Entropy value.
%
% OUTPUTS :
%
% SaEn: Sample Entropy.
% Phi: matches count vector for dim (also known as n_i_m), the number
% of points inside the i-th box, in the m space
% Phi1: matches count vector for dim+1 (also known as n_i_m+1),
% the number of points in the m+1 space
%
% REFERENCES :
%
% [1] : "COMPUTING MULTISCALE ENTROPY WITH ORTHOGONAL RANGE SEARCH" -
% Yu-Hsiang Pan et al., 2011
%
% [2] : "Fast computation of sample entropy and approximate entropy in
% biomedicine" - Yu-Hsiang Pan et al.,2011
if (dim+1)<=10
    method = 'kdtree';
else method = 'exhaustive';
end
    
N = length(sig);
Phi = ones(1,N-dim+1);
Phi1 = zeros(1,N-dim+2);
if size(sig,1)==1
    sig=sig';
end
%MAIN
    for m = dim : dim + 1
            X = zeros( N - m + 1 , m );
            for i = 1 : m
                ids = i : N  - m + i;
                X( : , i ) = ids;
            end
            sig_X = sig( X ); %catch the elements in the signal
            Phi_m = rangesearch( sig_X, sig_X, r, 'NSMethod', method, 'Distance', 'chebychev');
            for i = 1 : N - m + 1
                C_s = numel( Phi_m{ i } ) - 1; %substract self-match
                switch m
                    case dim
                        Phi( i ) = C_s;
                    case dim + 1
                        Phi1( i ) = C_s;
                end  
            end            
    end
    
    SaEn = log( sum( Phi ) / sum( Phi1 ) );

end


function [pointArray] = transform_to_space(X, m)
    N = length(X);
    pointArray = zeros(N-m,m);
    for j=1:m
        pointArray(:,j) = X(j:N-m-1+j);
    end
end

function [pointArray] = sort_points_by_x_coord(pointArray)
    pointArray = sortrows(pointArray);
end

function [iLB,iUB] = find_lower_upper_index(pointArray, r)
    x = pointArray(:,1);
    x = [1 3 4 5 6 7 8 10]
    L = length(x); %L = N-m
    
    % LOWER BOUND
    i=1;
    j=2;
    iLB = zeros(1,L);
    while i <= L
        if x(j-1) >= x(i)-r
            iLB(i) = 0;
            i = i+1;
        elseif x(j-1) < x(i)-r && x(i)-r <= x(j)
            iLB(i) = j;
            i = i+1;
        else
            j = j+1;
        end
    end
    
    % UPPER BOUND
    i=L;
    j=L-1;
    iUB = zeros(1,L);
    while 1 <= i
        if x(i)+r >= x(j+1)
            iUB(i) = 0;
            i = i-1;
        elseif x(j) <= x(i)+r && x(i)+r < x(j+1)
            iUB(i) = j;
            i = i-1;
        else
            j = j-1;
        end
    end
end
