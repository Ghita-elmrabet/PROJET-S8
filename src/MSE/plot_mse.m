function [fig] = plot_mse(se)
    fig = figure;
    plot(se, '-x')
    xlabel('Scale factor');
    ylabel('Sample Entropy');
end