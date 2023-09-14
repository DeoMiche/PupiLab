function [trialGroup, idGroup]= ppl_getGroup(tbl, groupSelection)
%     load('/Users/md5050/Desktop/PI/DATA/04_test/4_PI_MD.mat')
%     tbl = EXP.data;
%     groupSelection = 'color == 0 & response < 50; color == 1 & ori > 180';

% groupSelection should be a string OR A VECTOR !!!
    
    trialGroup = nan(size(tbl,1) ,1);
    
    % get variables from tbl columns
    variableID = tbl.Properties.VariableNames;
    for i_var = 1:length(variableID)
        eval([ variableID{i_var} ' = tbl.' variableID{i_var} ';'])
    end
    
    % get groups
    groupDefinition = split(groupSelection,';');
    idGroup = {};
    
    for i_group = 1:length(groupDefinition)
        trialGroup(eval(groupDefinition{i_group})) = i_group;
        idGroup{i_group} = num2str(i_group);
    end
    