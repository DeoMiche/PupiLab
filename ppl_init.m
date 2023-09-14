function ppl = ppl_init()
    ppl = struct(...
        'file', [],...
        'path', [],...
        'srate',[],...
        'i_trial',[],...
        'nTrials', 100,...
        'pupil_data', [],...
        'pupil_time', [],...
        'trialSize', 1000,...
        'data2plot', [],...
        'time2plot', [],...
        'trialGroup', [],...
        'missingDataThreshold', 100,...
        'artifactSize', 150,...
        'expTable', [],...
        'idGroup', [],...
        'H', [],...
        'P',[]...
        );
    
    
    ppl.plotOpt = struct(...
        'timeAvg', 0,...
        'groupAvg', 0,...
        'raw', 0,...
        'stats', 0,...
        'baseline',0,...
        'legend',0 ...
    );
end