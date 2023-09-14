function [toInstall, textMsg] = ppl_dependenciesCheck(path)


%% EDF2MAT
edfFramework_fn = fullfile(path,'edf2mat/@Edf2Mat/private/edfapi.framework');

home_fn = getenv('HOME');
dest_fn = [home_fn '/Library/Frameworks/edfapi.framework'];

if ~exist(dest_fn, 'dir')
    mkdir(dest_fn)
    copyfile(edfFramework_fn, dest_fn, 'f');
end

eval(['cd("' path '")'])


%% MATLAB toolboxes
[~, toolboxList] = matlab.codetools.requiredFilesAndProducts(fullfile(path, 'PupilGUI.mlapp'));
toolboxList = toolboxList(2:end-3);
% toolboxList(end+1).Name = 'test';
installedToolboxes = ver;

toInstall = {};
for i_tool = 1:length(toolboxList)
    toolboxInstalled = sum(strcmp(toolboxList(i_tool).Name, {installedToolboxes.Name}'));
    if ~toolboxInstalled
        toInstall{end+1} = toolboxList(i_tool).Name;
    end
end

textMsg = 'In order to properly run PupilLab you need to install the following toolbox(es):';
for i_dep = 1:length(toInstall)
    textMsg = [textMsg '\n-' toInstall{i_dep}];
end
