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
    "my_mse_9e4",...
    "my_mse_blackman_9e4",...
    ];


for j=1:length(filters)
    path = "../../figures/MSE/fantasia_bp_mat/fantasia_bp_" + filters(j) + ".mat";
    load(path)

    tau_max = 20;
    N = 10;

    % ANOVA
    SE = zeros(2,N,tau_max);
    SE(1,:,:) = SE_old;
    SE(2,:,:) = SE_young;


    anovValue = zeros(1,tau_max);
    for s=1:tau_max
        anovValue(s) = anova1(SE(:,:,s)', ["Old", "Young"], 'off');
    end

    fig = figure;
    semilogy(anovValue)
    ylim([1e-4 1])
    xlabel('Scale factor')
    ylabel('p-value')

    name = "anova_" + filters(j) + ".png"
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









