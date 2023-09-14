function ppl = ppl_loadTable(data_fn, ppl)

[path, file, ext] = fileparts(data_fn);

if strcmp(ext, '.mat')
    load(fullfile(path, [file ext]));
    ppl.expTable = EXP.data;
else

try
ppl.expTable = readtable(fullfile(path, [file ext]));
catch
    ppl.expTable = readtable(fullfile(path, [file ext]), 'FileType', 'delimitedtext');
end
end
    
    

