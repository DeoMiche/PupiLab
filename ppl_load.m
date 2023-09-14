function ppl = ppl_load(data_fn)

ppl = ppl_init();
[ppl.path, file, ext] = fileparts(data_fn);
ppl.file = [file ext];

if strcmpi(ext, '.edf')
    EL = Edf2Mat(data_fn);
elseif strcmpi(ext, '.mat')    
    load(fullfile(ppl.path, ppl.file));
    if strcmpi(file(end-6:end), 'pupilab')
        % Do something specific for already processed files
        % like loading settings, epoching etc.
        return;
    end
end

ppl.pupil_data = EL.Samples.pupilSize;
ppl.pupil_time = EL.Samples.time;

ppl.srate = EL.RawEdf.RECORDINGS(1).sample_rate;
ppl.nTrials = floor(length(ppl.pupil_data)/ppl.trialSize);
ppl.i_trial = 1;
ppl.trial_raw = reshape(ppl.pupil_data(1:ppl.nTrials*ppl.trialSize), ppl.trialSize, ppl.nTrials);
ppl.trial_pupil = ppl.trial_raw;
ppl.trial_time = reshape(ppl.pupil_time(1:ppl.nTrials*ppl.trialSize), ppl.trialSize, ppl.nTrials);

ppl.event_time = EL.Events.Messages.time;
ppl.event_info = EL.Events.Messages.info;