clear

% Chemin vers base de donnée
PATH = '../../../PTB-XL/';


%% AJOUT PATH FONCTION EXTRACTION DE FEATURES
% MSE
addpath('../../src/MSE');



%% PARAMETRES
% MSE
m = 2;
r_std = 0.15;
scale_max = 10;


% READ CSV
data = readtable([PATH 'ptbxl_database_clean.csv'],'TextType','string');

%% EXTRACT AND ADD FEATURES TO CSV
for i=1:size(data,1)
    fprintf("%.3f%%\n",i/size(data,1)*100);
    % read signal
    [tm,signal,Fs,labels]=rdmat(char(PATH + data.filename(i)));
    sig = signal(:,7);

    % MSE
    r = r_std*std(sig);
    mse = my_mse(sig, m, r, scale_max);
    data.mse(i) = mse;
end

%% SAVE CSV
writetable(data, [PATH 'ptbxl_database_features.csv']);

