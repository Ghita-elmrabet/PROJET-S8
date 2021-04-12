clear


PATH = '../../../PTB-XL/';

% READ CSV
data = readtable([PATH 'ptbxl_database_features.csv'],'TextType','string');
head(data)
groupsummary(data,"superclass")

% TO READ A SIGNAL
id = 4;
[tm,signal,Fs,labels]=rdmat(char(PATH + data.filename(id)));
