function [ s ] = aire_rec(f1,f2,x,y)
    N=length(y);
    f=-1/2:1/N:1/2-1/N;
    pw_sgnal=(1/length(y))*fftshift(abs(fft(y,N)).^2); % spectre de puissance
    if find([f==f1],1)
    %if (fnd(f1,f)==1)  % la frequence f1 est de la forme f1=k/N (appartient a f )
       x1=f1;
       A1=0;
       k1=find([f==x1],1);
    else
        x1=(floor(f1*N)+1)/N; % on prend la plus petite frequence de forme k/N superieure a f1;
        k1=find([f==x1],1);
        e1=k1-1;
        
        A1=(x1-f1)/2*(pw_sgnal(k1)+pw_sgnal(e1));
        % approx rectangulaire de l'aire de la partie 
        % comprise entre f1 et x1

    end
    if find([f==f2],1)
       x2=f2;
       A2=0;
       k2=find([f==x2]);
    else
        x2=(floor(f2*N)+1)/N; % on prend la plus grande frequence de forme k/N inferieure a f2;
        k2=find([f==x2],1);
        e2=k2-1;
        
        A2=(x2-f2)/2*(pw_sgnal(k2)+pw_sgnal(e2));
        % approx rectangulaire de l'aire de la partie 
        % comprise entre f2 et x2
    end
    s=0;
    while(k1<=k2)
        s=s+pw_sgnal(k1)/N;
        k1=k1+1;
    end
    A=abs(A1)-abs(A2)+abs(s);
    
    % Affichage 
    figure;
    plot(f,pw_sgnal);
    title('Dispaly Power Spectrum')
    xlabel('Frequency');
    ylabel('Amplitude');
    
    fprintf('The spectrum power between f1 and f2 :\n');
    disp(A);
    fprintf('The spectrum power in the central part :\n');
    disp(abs(s));
    fprintf('The spectrum power in the left extremity :\n');
    disp(abs(A1));
    fprintf('The spectrum power in the right extremity :\n');
    disp(abs(A2));
    
end




 