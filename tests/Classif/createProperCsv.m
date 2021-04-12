clear

PATH = '../../../PTB-XL/';

% READ CSV
data = readtable([PATH 'ptbxl_database.csv'],'TextType','string');
head(data)

%% REMOVE ROW FILENAME
data(:,28) = [];
data.Properties.VariableNames{27} = 'filename';

%% CHANGE RECORDS PATH
for i=1:size(data,1)
    data.filename(i) = [sprintf( 'records/HR%05d', data.ecg_id(i) )];
end

%% NEW ROW WITH SUPERCLASS AS ID

% SCP CSV
mapScp = containers.Map('KeyType',string);
scp_data = readtable([PATH 'scp_statements.csv'],'TextType','string');
for i=1:size(scp_data,1)
    subclass = convertStringsToChars(matlab.lang.makeValidName(scp_data.Var1(i)));
    mapScp(subclass) = scp_data.diagnostic_class(i);
end

superclass = ["NORM", "MI", "STTC", "CD", "HYP"];
i = 1;
while i <= size(data,1)
    i
    struc = jsondecode(convertStringsToChars(replace(data.scp_codes(i),'''', '"')));
    struc_field = fieldnames(struc);
    for j=1:size(struc_field,1)
        struc_field{j} = convertStringsToChars(mapScp(struc_field{j}));
        if isempty(struc_field{j})
            struc_field{j} = 'aze';
        end
    end
    
    cls = find(contains(superclass,struc_field) ~= 0);
    
    if length(cls) == 1 % doesnt have a superclass
        data.superclass(i) = cls;
        i = i + 1;
    else
        data(i,:) = [];
    end
end

head(data)

writetable(data, [PATH 'ptbxl_database_modified.csv']);