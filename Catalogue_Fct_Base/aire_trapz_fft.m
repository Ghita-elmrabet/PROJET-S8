
function [A]=aire_trapz_fft(k,f1,f2,signal) % pour f1 et f2 fixees, plus k est grand plus l'intervalle entre les 2 points                                        %est petit plus la pr??cision du calcul est ??lev??e
    %N=floor(length(signal)*64);
    %N=2^k;
    N=length(signal);
    f=-1/2:1/N:1/2-1/N;
    pw_sgnal=(1/length(signal))*fftshift(abs(fft(signal,N)).^2); % spectre de puissance
    if find([f==f1],1)
    %if (fnd(f1,f)==1)  % la frequence f1 est de la forme f1=k/N (appartient a f )
       x1=f1
       A1=0;
       k1=find([f==x1],1)
    else
        x1=(floor(f1*N)+1)/N % on prend la plus petite frequence de forme k/N superieure a f1;
        k1=find([f==x1],1)
        e1=k1-1
        
        A1=(x1-f1)/2*(pw_sgnal(k1)+pw_sgnal(e1)+(((f1-(e1/N))*abs((pw_sgnal(k1)-pw_sgnal(e1))))/(x1-(e1/N))));
        % approx trapezoidale de l'aire de la partie 
        %comprise entre f1 et x1

    end
    if find([f==f2],1)
       x2=f2
       A2=0;
       k2=find([f==x2])
    else
        x2=(floor(f2*N)+1)/N; % on prend la plus grande frequence de forme k/N inferieure a f2;
        k2=find([f==x2],1)
        e2=k2-1
        
        A2=(x2-f2)/2*(pw_sgnal(k2)+pw_sgnal(e2)+(((f2-(e2/N))*abs((pw_sgnal(k2)-pw_sgnal(e2))))/(x2-(e2/N))));
        % approx trapezoidale de l'air de la partie 
        %comprise entre f2 et x2
    end
    s=0;
    while(k1<=k2)
        s=s+(pw_sgnal(k1+1)+pw_sgnal(k1));
        k1=k1+1;
    end
    s=s/(2*N);
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
