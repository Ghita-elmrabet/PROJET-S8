function [] = mfcc_plot(coeffs, OLs)
    imagesc(coeffs, 'XData', [0, size(coeffs,2)*OLs], 'YData', [1, 13])
    set(gca,'YDir','normal')
    xlabel('Secondes')
    ylabel('MFCC coefficients')
    colorbar
end