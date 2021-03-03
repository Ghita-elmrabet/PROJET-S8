function [y] = generate_ar( p, N, sigma2 )
    num = [1, zeros(1, p)];
    
    roots_arg_1 = rand([1, p/2])*2*pi;
    roots_arg_2 = -roots_arg_1;
    
    roots_arg = [roots_arg_1 roots_arg_2];
    
    roots = rand([1, p]) .* exp(1i * roots_arg);
        
    den = poly(roots);
    H = [num; den];
    
    b = H(1, :);
    a = H(2, :);

    n = sigma2*(randn(1, N) + 1i*randn(1, N));
    
    y = filter(b, a, n);

end

