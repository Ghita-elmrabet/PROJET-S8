function [ s ] = r_xx( n,x )
%estmation de la fonction d'autocorrelation
s=0;
     if (n<0)
        for k=1:length(x)+n
          s=s+x(k)*x(k-n);
        end    
     else
        for k=n+1:length(x)-n
            s=s+x(k)*x(k-n);
        end
     end

end

