addpath('../../src/MSE/');


clear

filters = ["my_mse_9e4",...
    "my_cmse_9e4",...
    "my_rcmse_9e4",...
    "my_mse_butterworth_9e4",...
    "my_mse_chebyshev1_9e4",...
    "my_mse_chebyshev2_9e4",...
    "my_mse_fenetre_9e4",...
    "my_mse_hamming_9e4",...
    "my_mse_hanning_9e4",...
    "my_mse_blackman_9e4",...
    ];


for j=1:length(filters)
    path = "../../figures/MSE/fantasia_bp_mat/fantasia_bp_" + filters(j) + ".mat";
    load(path)
    
    MSE_old = ses_to_mse(SE_old);
    MSE_young = ses_to_mse(SE_young);

    fig = figure;
    hold on;
    plot(mean(MSE_old,1))
    plot(mean(MSE_young,1))
    hold off;
    xlabel('Scale max')
    ylabel('MSE')
    legend('Old', 'Young')

    name = "fantasia_bp_mse_" + filters(j) + ".png";
    saveas(fig,name)
    close(fig)
    
%     break;
end

% % MANOVA
% SE = zeros(2*N,tau_max/2+4);
% SE(1:N,:) = SE_young(:,tau_max/2+1-4:tau_max);
% SE(N+1:2*N,:) = SE_old(:,tau_max/2+1-4:tau_max);
% group = [repmat("Old",1,N) repmat("Young",1,N)];
% 
% manova1(SE, group)









