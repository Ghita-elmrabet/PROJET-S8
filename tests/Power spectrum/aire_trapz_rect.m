
function [A1,A2,A3]=aire_trapz_rect(k,f1,f2,signal) % pour f1 et f2 fixees, plus k est grand plus l'intervalle entre les 2 points                                        %est petit plus la pr??cision du calcul est ??lev??e
    addpath('../../src/Power spectrum/');
    N=2^k;
    f=-1/2:1/N:1/2-1/N;
    pw_signal=(1/N)*fftshift(abs(fft(signal,N)).^2); % spectre de puissance
    A1=aire_trapeze(f,pw_signal,f1,f2);
    A2=trapz(pw_signal,f);
    A3=aire_rec(f,pw_signal,f1,f2);
    figure,
    plot(f,pw_signal)
    xline(f1,'-.r','DisplayName','f1');
    xline(f2,'-.r','DisplayName','f2');
    xlabel('fréquences normalisées')
    ylabel('Amplitudes')
    title('Spectre de puissance du signal')
end
